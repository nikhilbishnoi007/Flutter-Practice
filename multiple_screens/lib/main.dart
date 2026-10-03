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
        scaffoldBackgroundColor: const Color(0xFF121212),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 2),
        child: Column(children: [One(), Two(), Three(), Four()]),
      ),
    );
  }
}

var userdeatil = [
  {"name": "user1"},
  {"name": "user2"},
  {"name": "user3"},
  {"name": "user4"},
  {"name": "user5"},
  {"name": "user6"},
  {"name": "user7"},
  {"name": "user8"},
  {"name": "user9"},
  {"name": "user10"},
];

class One extends StatelessWidget {
  const One({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.blue,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: SizedBox(
                width: 100,
                height: 100,

                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("helo"),
                ),
              ),
            );
          },
          itemCount: userdeatil.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class Two extends StatelessWidget {
  const Two({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        color: Colors.green,
        child: ListView.builder(
          itemCount: userdeatil.length,
          itemBuilder: ((context, index) => Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.white),
              title: Text(
                "${userdeatil[index]["name"]}",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text("mob no."),
              trailing: Icon(Icons.delete),
            ),
          )),
        ),
      ),
    );
  }
}

class Three extends StatelessWidget {
  const Three({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.grey,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Four extends StatelessWidget {
  const Four({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.blue,
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
