import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 204, 199, 214),
        ),
      ),
      home: const HomeScreen(title: 'Flutter Demo'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:Container(
        height: 400,
        color: Colors.black,
        child:SingleChildScrollView(
          child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("this is a iron man image",style: TextStyle(color: Colors.white,fontSize: 20),),
          Image.asset("assets/images/Stark.jpg"),
          Text("this is Inersteller image",style: TextStyle(color: Colors.white,fontSize: 20)),
          Image.asset("assets/images/intersteller.jpg"),
          Image.asset("assets/images/intersteller.jpg")
    
        ],
      )
      )
      )
    );
  }
}
