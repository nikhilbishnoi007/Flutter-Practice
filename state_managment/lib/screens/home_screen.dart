import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/providers/notes_provider.dart';

import 'package:state_managment/providers/settting_provider.dart';
import 'package:state_managment/screens/create_screen.dart';
import 'package:state_managment/screens/view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<bool> confirmDelte(BuildContext context) async {
    var delete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure you want to Delete this note?"),
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
      },
    );
    return delete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        centerTitle: true,
        actions: [
          Consumer<SetttingProvider>(
            builder: (context, provider, child) {
              final isLight = provider.mode == ThemeMode.light;
              return IconButton(
                onPressed: () {
                  provider.switchMode(
                    isLight ? ThemeMode.dark : ThemeMode.light,
                  );
                },
                icon: Icon(
                  isLight ? CupertinoIcons.sun_max : CupertinoIcons.moon,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          if (provider.notes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No Notes Yet .Add One"),
            );
          }
          return ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              final formate=DateFormat("dd/mm/yyyy").format(note.createdAt);
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewScreen(title: note.title, detail: note.desc),
                    ),
                  );
                },
                leading: CircleAvatar(child: Icon(CupertinoIcons.book)),
                title: Text(note.title),
                subtitle: Text(formate),
                trailing: PopupMenuButton<String>(
                  icon: Icon(CupertinoIcons.ellipsis_vertical),
                  elevation: 8,
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  onSelected: (value) async {
                    if (value == "delete") {
                      bool res = await confirmDelte(context);
                      if (res) {
                        provider.delete(note.title);
                      }
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      // PopupMenuItem(
                      //   value: "Edit",
                      //   child: Row(
                      //     children: [
                      //       Icon(CupertinoIcons.pencil, color: Colors.blue),
                      //       SizedBox(width: 15),
                      //       Text("Edit"),
                      //     ],
                      //   ),
                      // ),
                      // PopupMenuDivider(),
                      PopupMenuItem(
                        value: "delete",
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
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateScreen()),
            );
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: Text("Add Notes"),
          icon: Icon(CupertinoIcons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
