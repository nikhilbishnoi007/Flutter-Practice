import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/screens/swipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  bool islogin = false;
  var email = TextEditingController();
  var password = TextEditingController();
  var date = TextEditingController();
  final formKey=GlobalKey<FormState>();
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime(2008),
    );
    if (pickedDate != null) {
      setState(() {
        date.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void login() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwipeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 237, 238, 240),

      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       // Navigator.pop(context);
      //     },
      //   ),
      //   title: Center(
      //     child: Text("Login Screen", style: TextStyle(color: Colors.blueGrey)),
      //   ),
      // ),
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          margin: EdgeInsets.only(left: 25, right: 25),
          padding: EdgeInsets.only(top: 25),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Login ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F0D42),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hint: Text(
                          "Enter Your Email",
                          style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return "Email is required";
                        }
                        if(!value.contains("@")){
                          return "Enter a Valid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: isPassword,
                      controller: password,
                      decoration: InputDecoration(
                        hint: Text(
                          "Enter Your Password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: Icon(
                            isPassword
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if(value ==null || value.isEmpty){
                          return "PassWord Required to login";
                        }
                        return null ;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: date,
                      readOnly: true,
                      decoration: InputDecoration(
                        hint: Text(
                          "Select Your DOB",
                          style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: pickDate,
                          icon: Icon(Icons.calendar_month_sharp),
                        ),
                      ),
                      onTap: pickDate,
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return "DOB is required";
                        }
                        return null;
                      },
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:(){
                          if(formKey.currentState!.validate()){
                          login();
                          }
                        },
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Colors.grey, thickness: 1),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width: 300,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.g_mobiledata_outlined,
                    size: 28,
                    color: Colors.black,
                  ),
                  label: Text(
                    "Continue With Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Don't Have Account Sign UP",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
