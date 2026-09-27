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
      body:ListView(
          children: [
         Container(
          width: 400,
          height: 200,
          color: Colors.red,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.grey,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.amber,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.yellow,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.blue,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.black,
         ),
         Container(
          width: 400,
          height: 200,
          color: Colors.green,
         ),
        ],
      )
    );
  }
}
