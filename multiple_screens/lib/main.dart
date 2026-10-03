import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(title: 'Home Screen'),
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
  var colorsarray = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(color: colorsarray[0]),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(color: colorsarray[1]),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(color: colorsarray[2]),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(color: colorsarray[3]),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(color: colorsarray[4]),
          ),
        ],
      ),
    );
  }
}
