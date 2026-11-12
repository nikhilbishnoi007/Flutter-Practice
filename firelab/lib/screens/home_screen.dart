import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firelab/screens/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRefrence = FirebaseFirestore.instance.collection("users");
  List<Map<String, dynamic>> users = [];

  Future<void> fetchdata() async {
    dbRefrence.snapshots().listen((data) {
      users.clear();
      setState(() {
        users=data.docs.map((d)=>d.data()).toList();
      });
    });
  }

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

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), centerTitle: true),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
            title: Text(user['name']),
            subtitle: Text(user['email'],style: TextStyle(fontSize: 12),),
            trailing: PopupMenuButton(
              icon: Icon(CupertinoIcons.ellipsis_vertical),
              elevation: 8,
              offset: Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              onSelected: (value) async {
                if (value == "Eidt") {
                } else if (value == "Delete") {
                  final res = await confirmDelete(context);
                  if (!res) return;

                  await dbRefrence.doc(user['uid']).delete();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('User deleted')));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: "Edit",
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.pencil, color: Colors.blue),
                        SizedBox(width: 15),
                        Text("Edit"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "Delete",
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.delete, color: Colors.red),
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
