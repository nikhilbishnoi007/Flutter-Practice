import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_screens/calculator_screen.dart';
import 'package:multiple_screens/widgets/home_widgets.dart';

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
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const HomeScreen(title: 'Home Screen'),
      home:  const SwipeScreens(),
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
        actions: [
             IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calculator()),
                );
              },
              icon: FaIcon(FontAwesomeIcons.arrowRight,size: 20,color: Colors.black,),
            ),
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: .center,
          children: [
            One(),
            Two(),
        
          ],
        ),
      ),
    );
  }
}
class SwipeScreens extends StatelessWidget {
  const SwipeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          HomeScreen(title: 'Home'),
          Calculator(),
        ],
      ),
    );
  }
}