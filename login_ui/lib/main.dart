import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F0D42)),
      ),
      home: const MyHomePage(title: 'Welcome! Login to Conitnue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPassword = true;
  var email = TextEditingController();
  var password = TextEditingController();
  var date = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   backgroundColor: const Color.fromARGB(255, 237, 238, 240),
      //   title:Center(child:Text(widget.title,style: TextStyle(color: Colors.blueGrey))),
      // ),
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          margin: EdgeInsets.only(left: 25, right: 25),
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Welcome Back!", style: TextStyle(fontSize: 20)),
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
              Column(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  TextField(
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
                  ),
                  SizedBox(height: 10),
                  TextField(
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
                  ),
                  SizedBox(height: 10),
                  TextField(
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
                      onPressed: () {
                        // String uemail=email.text.toString();
                        // String upassword=password.text.toString();
                        // print("Email:$uemail Password:$upassword");
                      },
                      child: Text("Login"),
                    ),
                  ),
                ],
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
