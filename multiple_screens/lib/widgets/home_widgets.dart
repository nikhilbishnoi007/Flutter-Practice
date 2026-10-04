import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var userdetail = [
  {"name": "nikhil", "RollNo": 1001, "avatar": "assets/images/boy5avatar.jpg"},
  {
    "name": "priyanka",

    "RollNo": 1002,

    "avatar": "assets/images/girlavatar.jpg",
  },
  {"name": "dilshan", "RollNo": 1003, "avatar": "assets/images/boy1avatar.jpg"},
  {"name": "khushi", "RollNo": 1004, "avatar": "assets/images/girl1avatar.jpg"},
  {"name": "vikash", "RollNo": 1005, "avatar": "assets/images/boy2avatar.jpg"},
  {"name": "hacker", "RollNo": 1006, "avatar": "assets/images/boy3avatar.jpg"},
  {"name": "manish", "RollNo": 1007, "avatar": "assets/images/boy4avatar.jpg"},
  {"name": "neha", "RollNo": 1008, "avatar": "assets/images/girl2avatar.jpg"},
  {"name": "ankit", "RollNo": 1009, "avatar": "assets/images/boyavatar.jpg"},
  {"name": "zaheer", "RollNo": 1010, "avatar": "assets/images/boy6avatar.jpg"},
];

class One extends StatelessWidget {
  const One({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.all(3),
            child: SizedBox(
              width: 100,
              height: 100,

              child: CircleAvatar(
                backgroundImage: AssetImage(
                  userdetail[index]["avatar"] as String,
                ),
              ),
            ),
          );
        },
        itemCount: userdetail.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class Two extends StatelessWidget {
  const Two({super.key});
  String capatalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: ListView.builder(
        itemCount: userdetail.length,
        itemBuilder: ((context, index) => Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                userdetail[index]["avatar"] as String,
              ),
            ),
            title: Text(
              capatalize(userdetail[index]["name"] as String),
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              "${userdetail[index]["RollNo"]}",
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.instagram,
               color: Colors.red,
              ),
          ),
        )),
      ),
    );
  }
}

class Three extends StatelessWidget {
  const Three({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: RichText(
                text: TextSpan(
                children:<TextSpan>[
                  TextSpan(text: "hello"),
                  TextSpan(text: " ${userdetail[index]["name"]}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 20))
                ]
              )
              )
              ),
            ),
          );
        },
      ),
    );
  }
}

class Four extends StatelessWidget {
  const Four({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}
