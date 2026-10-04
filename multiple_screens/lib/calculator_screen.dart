import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var first = TextEditingController(text: "0");
  var second = TextEditingController(text: "0");
  var count = TextEditingController(text: "0");

  void add() {
    final a = int.tryParse(first.text) ?? 0;
    final b = int.tryParse(second.text) ?? 0;
    setState(() {
      count.text = (a + b).toString();
    });
  }

  void sub() {
    final a = int.tryParse(first.text) ?? 0;
    final b = int.tryParse(second.text) ?? 0;
    setState(() {
      count.text = (a - b).toString();
    });
  }

  void multi() {
    final a = int.tryParse(first.text) ?? 0;
    final b = int.tryParse(second.text) ?? 0;
    setState(() {
      count.text = (a * b).toString();
    });
  }

  void dev() {
    final a = int.tryParse(first.text) ?? 0;
    final b = int.tryParse(second.text) ?? 0;
    setState(() {
      count.text = (a / b).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        title: Text("CalCulator"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: 500,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: TextField(
                controller: first,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    count.text = "0";
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 143, 139, 110),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: TextField(
                controller: second,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    count.text = "0";
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 143, 139, 110),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: TextField(
                readOnly: true,
                controller: count,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: .spaceAround,
              children: [
                ElevatedButton(
                  onPressed: add,
                  child: FaIcon(FontAwesomeIcons.plus),
                ),
                ElevatedButton(
                  onPressed: sub,
                  child: FaIcon(FontAwesomeIcons.minus),
                ),
                ElevatedButton(
                  onPressed: multi,
                  child: FaIcon(FontAwesomeIcons.xmark),
                ),
                ElevatedButton(
                  onPressed: dev,
                  child: FaIcon(FontAwesomeIcons.divide),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
