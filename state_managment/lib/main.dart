import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/providers/home_provider.dart';
import 'package:state_managment/providers/settting_provider.dart';
import 'package:state_managment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetttingProvider(),
      child: Consumer<SetttingProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            themeMode: provider.mode,
            darkTheme:ThemeData.dark(),
            title: "State Managment",
            debugShowCheckedModeBanner: false,
            home: ChangeNotifierProvider(
              create: (context) => HomeProvider(),
              child: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
