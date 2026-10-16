import "package:flutter/material.dart";
import "package:login_ui/main.dart";
import "package:login_ui/screens/animation_screen.dart";

class SwipeScreen  extends StatefulWidget{
  const SwipeScreen({super.key});
  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>{
  final PageController _controller=PageController(initialPage: 0);
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return  PageView(
      controller: _controller,
      children: [
        LoginScreen(),
        AnimationScreen()
      ],
    );
  }
} 