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
        fontFamily: "MainFont",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F0D42),
          // brightness: Brightness.dark,
        ),
        useMaterial3: true,
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
      {"name": "nikhil", "course": "MCA", "RollNo": 1001, "Role": "Monitor","avatar":"assets/images/boy5avatar.jpg"},
      {"name": "priyanka", "course": "BCA", "RollNo": 1002, "Role": "HeadGirl","avatar":"assets/images/girlavatar.jpg"},
      {"name": "dilshan", "course": "BCA", "RollNo": 1003, "Role": "HeadBoy","avatar":"assets/images/boy1avatar.jpg"},
      {"name": "khushi", "course": "BCA", "RollNo": 1004, "Role": "Student","avatar":"assets/images/girl1avatar.jpg"},
      {"name": "vikash", "course": "MCA", "RollNo": 1005, "Role": "Student","avatar":"assets/images/boy2avatar.jpg"},
      {"name": "hacker", "course": "BCA", "RollNo": 1006, "Role": "Student","avatar":"assets/images/boy3avatar.jpg"},
      {"name": "manish", "course": "MCA", "RollNo": 1007, "Role": "Student","avatar":"assets/images/boy4avatar.jpg"},
      {"name": "neha", "course": "BCA", "RollNo": 1008, "Role": "Student","avatar":"assets/images/girl2avatar.jpg"},
      {"name": "ankit", "course": "BCA", "RollNo": 1009, "Role": "Student","avatar":"assets/images/boyavatar.jpg"},
      {"name": "zaheer", "course": "BCA", "RollNo": 1010, "Role": "Student","avatar":"assets/images/boy6avatar.jpg"},
    ];
    String capitalize(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),

        title: Center(
          child: Text(widget.title, style: TextStyle(color: Colors.blueGrey)),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(16),
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(blurRadius: 10)],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(names[index]["avatar"] as String),
                    ),
                    title: Text(
                      capitalize(names[index]["name"] as String),
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      capitalize(names[index]["Role"] as String),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Course: ${names[index]["course"]}",
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
