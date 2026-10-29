import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/providers/notes_provider.dart';

import 'package:state_managment/providers/settting_provider.dart';
import 'package:state_managment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SetttingProvider()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: Consumer<SetttingProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            themeMode: provider.mode,
            darkTheme: ThemeData.dark(),
            title: "State Managment",
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
