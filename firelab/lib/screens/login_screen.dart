import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelab/screens/forgot_passsword.dart';
import 'package:firelab/screens/home_screen.dart';
import 'package:firelab/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidepass = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  Future<void> login(BuildContext context) async {
    setState(() => isLoading = true);
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );

      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (value) => false,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
  Future<void>continuewithGoogle(BuildContext context)async{
    String clientId=String.fromEnvironment("GOOGLE_CLIENT_ID");
    try{
        GoogleSignIn signIn=GoogleSignIn.instance;
        await signIn.initialize(serverClientId: clientId);
        GoogleSignInAccount result=await signIn.authenticate();
        GoogleSignInAuthentication googleauth=result.authentication;
        final credential=GoogleAuthProvider.credential(
          idToken: googleauth.idToken
        );
        setState(()=>isLoading=true);
        await auth.signInWithCredential(credential);
        if(!context.mounted)return;
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (context)=>HomeScreen()), 
          (value)=>false
          );
    }catch(e){
      if(!context.mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      if(mounted)setState(()=>isLoading=false);
    }
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(label: Text("Email")),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) return "Enter a valid email";
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                obscureText: hidepass,
                controller: pass,
                decoration: InputDecoration(
                  label: Text("Password"),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidepass = !hidepass;
                      });
                    },
                    icon: Icon(
                      hidepass ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) return "Minimum 6 characters";
                  return null;
                },
              ),
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotScreen()),
                  );
                },
                child: Text("forgot password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(context);
                  }
                },
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text("Login"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("don't have Account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text("Register"),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  continuewithGoogle(context);
                },
                icon: FaIcon(FontAwesomeIcons.google),
                label: Text("Continue With Google"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
