import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/blocs/auth/auth_bloc.dart';
import 'package:state_managment/providers/notes_provider.dart';

import 'package:state_managment/providers/settting_provider.dart';
import 'package:state_managment/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SetttingProvider()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: Consumer<SetttingProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            themeMode: provider.mode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            title: "State Managment",
            debugShowCheckedModeBanner: false,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
