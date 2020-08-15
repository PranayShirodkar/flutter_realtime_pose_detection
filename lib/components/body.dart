import 'package:flutter/material.dart';
import 'package:flutter_realtime_pose_detection/Pages/Info_page.dart';
import 'package:flutter_realtime_pose_detection/components/background.dart';
import 'package:flutter_realtime_pose_detection/components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            "Welcome to Back-Bend!",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 26)
        ),
        SizedBox(height: size.height*0.02),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Image.asset(
            "assets/images/spine.png",
            height: size.height * 0.4,
          ),
        ),
        SizedBox(height: size.height*0.04),
        RoundedButton(
          text: "Get Started!",
          press: (){
            Navigator.pushNamed(
              context,'2.'
            );
          },
        ),
      ],
    ),
    );
  }
}