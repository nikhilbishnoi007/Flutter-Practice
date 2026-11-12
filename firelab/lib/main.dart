
import 'package:firelab/screens/home_screen.dart';
import 'package:firelab/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final pref=await SharedPreferences.getInstance();
  bool isLoggedIn = pref.getBool('login') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key,required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireLab',
      debugShowCheckedModeBanner: false,
      home:isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

