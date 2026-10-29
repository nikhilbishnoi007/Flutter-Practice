import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:state_managment/providers/home_provider.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"), centerTitle: true),
      body: Center(
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              spacing: 20,
              children: [
                Text(
                  "the value of count:${provider.count.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: provider.increment,
                       child: Icon(Icons.add)
                       ),
                    ElevatedButton(onPressed: provider.decrement, child: Icon(Icons.remove))   
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
