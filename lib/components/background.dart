import 'package:flutter/material.dart';

class BackGround extends StatelessWidget{
  final Widget child;
  const BackGround({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget> [
          Positioned(
            top:0,
            left:0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width*0.4,
            ),
          ),

          Positioned(
            bottom:0,
            right:0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width*0.32,
            ),
          ),

          Positioned(
            top:-50,
            right:0,
            child: RotationTransition(
              turns:AlwaysStoppedAnimation(130/360),
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width*0.25,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,

            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width*0.3,
            ),
          ),

          child,
        ],
      ),
    );
  }
}