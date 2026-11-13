import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelab/screens/add_screen.dart';
import 'package:firelab/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRefrence = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;

  Future<bool> confirmDelete(BuildContext context) async {
    final response = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure you want to delete this user."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Yes", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      }),
    );
    return response ?? false;
  }

  Future<bool> confirmLogout(BuildContext context) async {
    final res = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("LogOut"),
          content: Text("Are you sure you want to logout"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("LogOut"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
    return res ?? false;
  }

  Future<void> logout(BuildContext context) async {
    try {
      await auth.signOut();
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (value)=>false
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final res = await confirmLogout(context);
                if (res) {
                  if (!context.mounted) return;
                  logout(context);
                }
              },
              child: Text("LogOut", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: dbRefrence.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            List<Map<String, dynamic>> users = [];
            users = snapshot.data!.docs.map((d) => d.data()).toList();
            return users.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "No User Added Yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        ),
                        title: Text(user['name']),
                        subtitle: Text(
                          user['email'],
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: PopupMenuButton(
                          icon: Icon(CupertinoIcons.ellipsis_vertical),
                          elevation: 8,
                          offset: Offset(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          onSelected: (value) async {
                            if (value == "Edit") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddUserScreen(data: user),
                                ),
                              );
                            } else if (value == "Delete") {
                              final res = await confirmDelete(context);
                              if (!res) return;

                              await dbRefrence.doc(user['uid']).delete();
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('User deleted')),
                              );
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: "Edit",
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.pencil,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 15),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "Delete",
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 15),
                                    Text("Delete"),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      );
                    },
                  );
          }
          return Text("No User found");
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUserScreen()),
            );
          },
          label: Text("Add User"),
          icon: Icon(CupertinoIcons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
