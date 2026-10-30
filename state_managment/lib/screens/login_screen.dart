import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:state_managment/blocs/auth/auth_bloc.dart';
import 'package:state_managment/blocs/auth/auth_event.dart';
import 'package:state_managment/blocs/auth/auth_state.dart';
import 'package:state_managment/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLogin = false;
  bool show = true;
  void login() {
    context.read<AuthBloc>().add(
      LoginEvent(email: email.text.toString(), password: pass.text.toString()),
    );
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcom Back !"), centerTitle: true),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccessState) {
            final pref = await SharedPreferences.getInstance();
            await pref.setBool("isLoggedin", true);
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is AuthFailureState) {
             final pref = await SharedPreferences.getInstance();
            await pref.setBool("isLoggedin", false);
             if (!context.mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg)));
          }
        },
        child: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            // color: Colors.grey,
          ),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      label: Text("Enter Your Email"),
                      focusColor: Colors.black,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a Valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: pass,
                    obscureText: show,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      label: Text("Enter Your Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                          show ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "PassWord is Required";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Text("Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
