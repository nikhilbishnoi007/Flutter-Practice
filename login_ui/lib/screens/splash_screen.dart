import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_ui/screens/login_screen.dart';
import 'package:login_ui/screens/swipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void nextScreen() async {
    var pref = await SharedPreferences.getInstance();
    var getvalue = pref.getBool("isLoggedIn");
    Timer(Duration(seconds: 2), () {
      if (getvalue != null) {
        if (getvalue) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SwipeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Center(child: Text("Welcome!")),
      ),
    );
  }
}
