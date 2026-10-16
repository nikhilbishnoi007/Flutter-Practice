import "package:flutter/material.dart";

class DetailScreen  extends StatelessWidget{
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text("Detail"),
      centerTitle: true,
      backgroundColor:const Color.fromARGB(255, 237, 238, 240),
    ),
    body: Hero(
      tag: "detail" ,
      child: Image.asset("assets/images/boy5avatar.jpg",width: 400,height: 400,)
      ),
   );
  }
} 