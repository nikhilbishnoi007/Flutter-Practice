import "package:flutter/material.dart";
import "package:login_ui/screens/detail_screen.dart";

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  bool flag = true;
  bool flag2 = true;
  var _opacity = 0.8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        centerTitle: true,
      ),
      body: ListWheelScrollView(
          itemExtent: 200,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
              child: AnimatedCrossFade(
                firstChild: Image.asset(
                  "assets/images/boy1avatar.jpg",
                  width: 200,
                  // height: 200,
                ),
                secondChild: Image.asset(
                  "assets/images/boy5avatar.jpg",
                  width: 200,
                  // height: 200,
                ),

                crossFadeState: flag
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 1),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  flag2 = !flag2;
                  if (flag2) {
                    _opacity = 1.0;
                  } else {
                    _opacity = 0.2;
                  }
                });
              },
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 3),
                // curve: Curves.easeOut,
                child: Container(
                  margin: EdgeInsets.all(12),
                  width: 200,
                  // height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen()),
                  );
                },
                child: Hero(
                  tag: "detail",
                  child: Image.asset(
                    "assets/images/boy5avatar.jpg",
                    width: 200,
                    // height: 200,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12)
              ),
            )
          ],
        ),
    );
  }
}
