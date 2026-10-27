import "package:flutter/material.dart";
import "package:login_ui/widgets/animate_widgets.dart";

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        backgroundColor: const Color.fromARGB(255, 237, 238, 240),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Column(
            spacing: 20,
            children: [AnimateCr(),AnimateH(),AnimateOp()]),
        ),
      ),
    );
  }
}
