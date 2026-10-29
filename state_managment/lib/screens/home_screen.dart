import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/providers/home_provider.dart';
import 'package:state_managment/providers/settting_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          Consumer<SetttingProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton(
                onSelected: (value) {
                  provider.switchMode(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: ThemeMode.system,
                      child: Text("System"),
                    ),
                    PopupMenuItem(value: ThemeMode.light, child: Text("Light")),
                    PopupMenuItem(value: ThemeMode.dark, child: Text("Dark")),
                  ];
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: .center,
              spacing: 10,
              children: [
                Text(
                  "Value of count is:${provider.count}",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: provider.count >= 10
                          ? null
                          : provider.increment,
                      child: Icon(
                        Icons.add,
                        color: provider.count >= 100
                            ? Colors.grey
                            : Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: provider.count <= 1
                          ? null
                          : provider.decrement,
                      child: Icon(
                        Icons.remove,
                        color: provider.count <= 0 ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ],
                ),

                if (provider.count <= 1)
                  const Text(
                    "Minimum value of count is 1",
                    style: TextStyle(color: Colors.red),
                  ),
                if (provider.count >= 10)
                  const Text(
                    "Maximum value of count is 10",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
