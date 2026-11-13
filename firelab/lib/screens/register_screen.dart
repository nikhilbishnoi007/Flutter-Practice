import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelab/screens/home_screen.dart';
import 'package:firelab/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidepass = true;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> register(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await auth.createUserWithEmailAndPassword(
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

  Future<void> continuewithGoogle(BuildContext context) async {
    String clientId = dotenv.env['GOOGLE_CLIENT_ID'] ?? "";
    try {
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: clientId);
      GoogleSignInAccount result = await signIn.authenticate();
      GoogleSignInAuthentication googleAuth = result.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      setState(() => isLoading = true);
      await auth.signInWithCredential(credential);
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

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(label: Text("Username")),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "UserName is required";
                  }
                  if (value.contains(" ")) return "Enter a valid username";
                  return null;
                },
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    register(context);
                  }
                },
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text("Register"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Already have an  Account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  continuewithGoogle(context);
                },
                label: Text("Continue With Google"),
                icon: FaIcon(FontAwesomeIcons.google),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
