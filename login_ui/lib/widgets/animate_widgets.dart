import 'package:flutter/material.dart';
import 'package:login_ui/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimateCr extends StatefulWidget {
  const AnimateCr({super.key});
  @override
  State<AnimateCr> createState() => _AnimateCrState();
}

class _AnimateCrState extends State<AnimateCr> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
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
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}

class AnimateOp extends StatefulWidget {
  const AnimateOp({super.key});
  @override
  State<AnimateOp> createState() => _AnimateOpState();
}

class _AnimateOpState extends State<AnimateOp> {
  bool flag = true;
  var _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          flag = !flag;
          if (flag) {
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
          // margin: EdgeInsets.all(12),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class AnimateH extends StatefulWidget {
  const AnimateH({super.key});
  @override
  State<AnimateH> createState() => _AnimateHState();
}

class _AnimateHState extends State<AnimateH> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen()),
        );
      },
      child: Hero(
        tag: "detail",
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/boy5avatar.jpg",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

class Clip extends StatelessWidget {
  const Clip({super.key});
  @override
  Widget build(BuildContext build) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        ),
      ),
    );
  }
}

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({super.key});
  @override
  State<TweenAnimation> createState() => _TweenState();
}

class _TweenState extends State<TweenAnimation>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  late Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    animation = Tween(begin: 0.0, end: 200.0).animate(animationController);
    colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.blue,
    ).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animation.value,
      height: animation.value,
      decoration: BoxDecoration(
        color: colorAnimation.value,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class RippleEffect extends StatefulWidget {
  const RippleEffect({super.key});
  @override
  State<RippleEffect> createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  var radiusList=[100.0,150.0,200.0,250.0,300.0];
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
      lowerBound: 0.5
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }
  Widget buildContainer(double radius){
        return Container(
          width: radius*animation.value,
          height: radius*animation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withValues(alpha: 1.0-animation.value)
          ),
        );  
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildContainer(radiusList[0]),
        buildContainer(radiusList[1]),
        buildContainer(radiusList[2]),
        buildContainer(radiusList[3]),
        buildContainer(radiusList[4]),
        Icon(Icons.phone)
      ]
    );
  }
}

class SharedPrefrence extends StatefulWidget{
  const SharedPrefrence({super.key});
  @override
   State<SharedPrefrence> createState()=> _SharedPrefrenceState();
}
class _SharedPrefrenceState extends State<SharedPrefrence>{
  var textController=TextEditingController();
  var userName="";

  Future<void> savedValue() async{
  var name=textController.text.toString();
  var pref=await SharedPreferences.getInstance();
  pref.setString("username", name);

  }
  Future<void> getValue() async{
    var prefs=await SharedPreferences.getInstance();
    var getusername=prefs.getString("username");
    setState(() {
      userName=getusername !=null?"Hello $getusername":"Create Username";
    });
  }
  @override
  void initState(){
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
     return Center(
      child: Column(
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              label: Text("Create a Username"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
          ),
          ElevatedButton(
            onPressed: savedValue,
            child: Text("Save")
          ),
          SizedBox(height: 10,),
          Text(userName)
        ],
      )
     );
  }
}