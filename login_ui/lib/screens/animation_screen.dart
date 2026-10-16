import "package:flutter/material.dart";

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  bool flag = true;
  bool flag2=true;
  var _opacity = 0.8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              setState(() {
                flag = true;
              });
            },
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: AnimatedCrossFade(
              firstChild: Image.asset(
                "assets/images/boy1avatar.jpg",
                width: 200,
                height: 200,
              ),
              secondChild: Image.asset(
                "assets/images/boy5avatar.jpg",
                width: 200,
                height: 200,
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
                flag2=!flag2;
                if (flag2) {
                  _opacity = 1.0;
                } else {
                  _opacity = 0.2;
                }
              });
            },
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 2),
              child: Container(
                margin: EdgeInsets.all(12),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
