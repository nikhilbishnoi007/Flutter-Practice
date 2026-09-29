import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Managment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F0D42)),
      ),
      home: const HomeScreen(title: 'Student Details'),
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
    var names = [
      {"name": "nikhil", "class": "BCA", "RollNo": 1001},
      {"name": "priyanka", "class": "BCA", "RollNo": 1002},
      {"name": "dilshan", "class": "BCA", "RollNo": 1003},
      {"name": "khushi", "class": "BCA", "RollNo": 1004},
      {"name": "vikash", "class": "BCA", "RollNo": 1005},
      {"name": "hacker", "class": "BCA", "RollNo": 1006},
      {"name": "kaif", "class": "BCA", "RollNo": 1008},
      {"name": "ankit", "class": "BCA", "RollNo": 1009},
    ];
    String capitalize(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBEAFE),

        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(16),
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Name: ${capitalize(names[index]["name"] as String)}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Class: ${names[index]["class"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "RollNo: ${names[index]["RollNo"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: names.length,
      ),
    );
  }
}
