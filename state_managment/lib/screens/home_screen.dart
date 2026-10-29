import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/providers/notes_provider.dart';

import 'package:state_managment/providers/settting_provider.dart';
import 'package:state_managment/screens/create_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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
          if(provider.notes.isEmpty){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No Notes Yet .Add One"),
            );
          }
          return ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              return ListTile(
                leading: CircleAvatar(child: Icon(CupertinoIcons.news)),
                title: Text(note.title),
                subtitle: Text(note.desc),
                trailing: PopupMenuButton<String>(
                  icon: Icon(CupertinoIcons.ellipsis_vertical),
                  elevation: 8,
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12)
                  ),
                  onSelected:(value) {
                    if(value=="delete"){
                      provider.delete(note.title);
                    }
                  },
                  itemBuilder: (context){
                  return [
                    PopupMenuItem(
                      value: "Edit",
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.pencil,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("Edit")
                        ],
                      )
                      ),
                    PopupMenuDivider(),
                     PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                           Icon(CupertinoIcons.delete,color: Colors.red,),
                           SizedBox(width: 15,),
                           Text("Delete")
                           
                        ],
                      ),
                     )
                  ];
                }),
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
