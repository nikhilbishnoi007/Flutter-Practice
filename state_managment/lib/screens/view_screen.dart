import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget{
  final String title;
  final String detail;
  const  ViewScreen({super.key,required this.title,required this.detail});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
      title: Text(title),
      centerTitle: true,
     ),
     body: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      child: Text(detail),
     ),
  );
  }
}