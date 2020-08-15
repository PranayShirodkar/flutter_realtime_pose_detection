import 'package:flutter/material.dart';
import 'package:directed_graph/directed_graph.dart';
import 'dart:math' as math;

const double degrees2Radians = math.pi / 180.0;
var redChannel = 0;
var greenChannel = 255;

class BodyPainter extends CustomPainter {
  DirectedGraph<String> bodyStructure;
  Paint _paint;
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  var bodyMap;

  BodyPainter(this.results, this.previewH, this.previewW, this.screenH, this.screenW){
    _paint = Paint()
      ..color=Color.fromARGB(170, redChannel, greenChannel, 0)
      ..strokeCap=StrokeCap.round
      ..strokeWidth=7;
    bodyMap = Map();
    var nose = Vertex<String>('nose');
    var neck = Vertex<String>('neck');
    var rightEye = Vertex<String>('rightEye');
    var leftEye = Vertex<String>('leftEye');
    var rightEar = Vertex<String>('rightEar');
    var leftEar = Vertex<String>('leftEar');
    var rightShoulder = Vertex<String>('rightShoulder');
    var leftShoulder = Vertex<String>('leftShoulder');
    var rightElbow = Vertex<String>('rightElbow');
    var leftElbow = Vertex<String>('leftElbow');
    var rightWrist = Vertex<String>('rightWrist');
    var leftWrist = Vertex<String>('leftWrist');
    var rightHip = Vertex<String>('rightHip');
    var leftHip = Vertex<String>('leftHip');
    var tailBone = Vertex<String>('tailBone');
    var rightKnee = Vertex<String>('rightKnee');
    var leftKnee = Vertex<String>('leftKnee');
    var rightAnkle = Vertex<String>('rightAnkle');
    var leftAnkle = Vertex<String>('leftAnkle');
//    bodyStructure = DirectedGraph<String>(
//      {
//        nose: [rightEye, leftEye],
//        rightEye: [rightEar],
//        leftEye: [leftEar],
//        nose: [neck],
//        neck: [rightShoulder,leftShoulder],
//        rightShoulder: [rightElbow, rightHip],
//        leftShoulder: [leftElbow, leftHip],
//        rightElbow: [rightWrist],
//        leftElbow: [leftWrist],
//        rightHip: [rightKnee],
//        leftHip: [leftKnee],
//        rightKnee: [rightAnkle],
//        leftKnee: [leftAnkle]
//      },
//    );
    bodyStructure = DirectedGraph<String>(
      {
        nose: [neck],
        neck: [tailBone],
      },
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    bodyMap = Map();
    results.forEach((re) {
      var list = re["keypoints"].values.map<Widget>((k) {
        var _x = k["x"];
        var _y = k["y"];
        var scaleW, scaleH, x, y;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          y = _y * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          y = (_y - difH / 2) * scaleH;
        }
        bodyMap[k["part"]] = Offset(x, y);
      }).toList();
    });
    bodyMap["neck"] = Offset(
        (bodyMap["leftShoulder"].dx+bodyMap["rightShoulder"].dx)/2,
        (bodyMap["leftShoulder"].dy+bodyMap["rightShoulder"].dy)/2);
    bodyMap["tailBone"] = Offset(
        (bodyMap["leftHip"].dx+bodyMap["rightHip"].dx)/2,
        (bodyMap["leftHip"].dy+bodyMap["rightHip"].dy)/2);
    var gradNoseNeck = (bodyMap["neck"].dy - bodyMap["nose"].dy)/(bodyMap["neck"].dx - bodyMap["nose"].dx);
    var gradNeckTail = (bodyMap["nose"].dy - bodyMap["tailBone"].dy)/(bodyMap["nose"].dx - bodyMap["tailBone"].dx);
    var numerator = gradNoseNeck-gradNeckTail;
    var denominator = 1+(gradNoseNeck*gradNeckTail);
    var angleBetweenGrads = math.atan((numerator/denominator).abs());
    var thresh = 20;
    var updateRate = 50;
    if ((angleBetweenGrads != double.nan) && (angleBetweenGrads.abs() > (thresh*degrees2Radians))) {
      if ((255-redChannel) < updateRate) {
        redChannel = 255;
      }
      else {
        redChannel = redChannel + updateRate;
      }
      if (greenChannel < updateRate) {
        greenChannel = 0;
      }
      else {
        greenChannel = greenChannel - updateRate;
      }
    }
    else if ((angleBetweenGrads != double.nan) && (angleBetweenGrads.abs() <= (thresh*degrees2Radians))) {
      redChannel = 0;
      greenChannel = 255;
    }
    paintBody(canvas);

  }

  void paintBody(Canvas canvas) {
    _paint.color = Color.fromARGB(170, redChannel, greenChannel, 0);
    bodyStructure.vertices.forEach((vertex) {
      bodyStructure.edges(vertex).forEach((otherEnd) {
        canvas.drawLine(
          bodyMap[vertex.toString()],
          bodyMap[otherEnd.toString()],
          _paint,
        );
      });
    });
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}