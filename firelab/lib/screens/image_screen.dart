import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? pickfile;
  void pickimage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      setState(() => pickfile = File(xfile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ImagePicker"), centerTitle: true),
      body: ListView(
        children: [
          ElevatedButton(onPressed: pickimage, child: Text("Select image")),
          pickfile == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("No image selected"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 12,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Image.file(pickfile!, fit: BoxFit.cover),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => pickfile = null);
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
