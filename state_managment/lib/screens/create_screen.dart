import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/models/notes_model.dart';
import 'package:state_managment/providers/notes_provider.dart';

class CreateScreen extends StatefulWidget{
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var  title=TextEditingController();
  var  desc=TextEditingController();

  var form=GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Notes"),
        centerTitle: true,
      ),
    body: Consumer<NotesProvider>(
      builder: (context,provider,child){
        return Form(
          key: form,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                  label: Text("Enter Title"),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                validator: (value){
                  if(value==null || value.trim().isEmpty){
                    return "Title is required";
                  }
                  return null;
                },
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                controller: desc,
                maxLines: 5,
                decoration: InputDecoration(
                  hint: Text("Start Writing"),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                validator: (value){
                  if(value==null||value.trim().isEmpty){
                    return "Write Somthing to save";
                  }
                  return null;
                },
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton.icon(
                  onPressed: (){
                    if(form.currentState!.validate()){
                   NotesModel note=NotesModel(title:title.text, desc:desc.text,createdAt: DateTime.now());
                   provider.addNotes(note);
                   Navigator.pop(context);
                    }
                  },
                 label: Text("Save"),
                 icon: Icon(CupertinoIcons.check_mark),
                ),
              )
            ],
          )
          );
      }
      ),
    );
  }
}