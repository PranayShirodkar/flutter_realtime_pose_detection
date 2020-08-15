import 'package:flutter/material.dart';
import 'package:flutter_realtime_pose_detection/constants.dart';

class TableElement extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final String image;

  const TableElement({
    Key key,
    this.text,
    this.image,
    this.color,
    this.textColor = subTextColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:20),
      child: Material(
        elevation: 12.0,
        borderRadius: BorderRadius.circular(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: size.width * 0.92,
            height: size.height*0.17,
            color: color,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Text(
                      text, textAlign: TextAlign.left,
                      style:
                      TextStyle(color: textColor,
                        fontSize: 22,
                      )),
              ),

                Flexible(
                  flex:1,
                  child: Image.asset(
                    image,
                    height: 60,
                    width: 60,
                  ),
                )
            ],
            ),
          ),
         ),
        ),
    );
  }
}
