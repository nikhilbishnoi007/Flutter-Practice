import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddUserScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const AddUserScreen({super.key, this.data});
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final dbRefrence = FirebaseFirestore.instance.collection("users");
  bool get isEdit => widget.data != null;
  bool isLoading = false;

  Future<void> save(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final id = Uuid().v4();
    await dbRefrence.doc(id).set({
      "uid": id,
      "name": name.text,
      "email": email.text,
    });
    setState(() {
      isLoading = false;
    });
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> update(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    await dbRefrence.doc(widget.data?['uid']).update({
      "name": name.text,
      "email": email.text,
    });
    setState(() {
      isLoading=false;
    });
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    name.text = widget.data?['name'] ?? "";
    email.text = widget.data?['email'] ?? "";
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Update User" : "Add Users"),
        centerTitle: true,
      ),
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
                  if (value.trim().length < 8 ||
                      !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
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
                  if (!value.contains("@")) {
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
                  onPressed: () async{
                    if (formkey.currentState!.validate()) {
                      isEdit ? await  update(context) : await save(context);
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                      : Text(isEdit ? "Update" : "Add"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
