import 'package:flutter/material.dart';
import 'package:login_ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final globalKey = GlobalKey<ScaffoldState>();

  Future<void> confirmLogout(BuildContext context) async {
    final shouldlogout = await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("LogOut"),
        content: const Text("Are you sure you want to logout"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("LogOut", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (shouldlogout == true) {
      if (!context.mounted) return;
      await logout(context);
    }
  }

  Future<void> logout(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        leading: IconButton(
          onPressed: () {
            globalKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: Container(
        width: 400,
        height: 400,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: 20,
          children: [Icon(Icons.home)],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(height: 50),
            FlutterLogo(size: 50),
            SizedBox(height: 15),
            Text(
              "Hello Nikhil",
              textAlign: .center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ListTile(leading: Icon(Icons.home), title: Text("Home")),
            ListTile(leading: Icon(Icons.settings), title: Text("Setting")),
            ListTile(leading: Icon(Icons.help), title: Text("Help")),
            ListTile(
             
              leading: Icon(Icons.info),
              title: Text("About"),
            ),
            ListTile(
              onTap: () => confirmLogout(context),
              leading: Icon(Icons.logout),
              title: Text("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}
