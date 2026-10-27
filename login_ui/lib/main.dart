import 'package:flutter/material.dart';
import 'package:login_ui/screens/login_screen.dart';
import 'package:login_ui/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        fontFamily: "MainFont",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F0D42)),
      ),
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  void logout() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
      ),
      body: Container(
        width: 400,
        height: 400,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: 20,
          children: [
            Icon(Icons.home),
            ElevatedButton(onPressed: logout, child: Text("LogOut")),
          ],
        ),
      ),
    );
  }
}
