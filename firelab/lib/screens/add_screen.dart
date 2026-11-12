import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final dbRefrence=FirebaseFirestore.instance.collection("users");

  Future<void> save(BuildContext context)async{
    final id=Uuid().v4();
    await dbRefrence.doc(id).set({
      "uid":id,
      "name":name.text,
      "email":email.text
    });
     if (!context.mounted) return;
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Users"), centerTitle: true),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  label: Text("Enter Full Name"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is Required";
                  }
                  if (value.trim().length < 8 ||!RegExp(r'^[a-zA-Z ]+$').hasMatch(value) ) {
                    return "Enter a Valid Name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  label: Text("Enter Email"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Required";
                  }
                  if (!value.contains("@") ) {
                    return "Enter a valid Email";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      save(context);
                    }
                  },
                  child: Text("Add"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
