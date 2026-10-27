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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fade;
  late Animation<double> _scale;
  void nextScreen() async {
    var pref = await SharedPreferences.getInstance();
    var getvalue = pref.getBool("isLoggedIn");
    Timer(Duration(seconds: 2), () {
      if (getvalue != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 3),
            pageBuilder: (context, animation, secondayAnimation) =>
                getvalue ? SwipeScreen() : LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  );
                  return FadeTransition(
                    opacity: curved,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.95,
                        end: 1.0,
                      ).animate(curved),
                      child: child,
                    ),
                  );
                },
          ),
        );
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
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fade = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
    nextScreen();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlutterLogo(size: 100),
                  SizedBox(height: 20),
                  Text(
                    "Welcome",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
