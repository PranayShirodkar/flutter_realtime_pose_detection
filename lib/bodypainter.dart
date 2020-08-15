import 'package:flutter/material.dart';
import 'package:directed_graph/directed_graph.dart';

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
      ..color=Color(0xaa00ff00)
      ..strokeCap=StrokeCap.round
      ..strokeWidth=7;
    bodyMap = Map();
    var nose = Vertex<String>('nose');
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
    var rightKnee = Vertex<String>('rightKnee');
    var leftKnee = Vertex<String>('leftKnee');
    var rightAnkle = Vertex<String>('rightAnkle');
    var leftAnkle = Vertex<String>('leftAnkle');
    bodyStructure = DirectedGraph<String>(
      {
        nose: [rightEye, leftEye],
        rightEye: [rightEar],
        leftEye: [leftEar],
        nose: [rightShoulder, leftShoulder],
        rightShoulder: [rightElbow, rightHip, leftShoulder],
        leftShoulder: [leftElbow, leftHip],
        rightElbow: [rightWrist],
        leftElbow: [leftWrist],
        rightHip: [rightKnee],
        leftHip: [leftKnee],
        rightKnee: [rightAnkle],
        leftKnee: [leftAnkle]
      },
    );
//    bodyStructure = DirectedGraph<String>(
//      {
//        nose: [rightShoulder, leftShoulder],
//        rightShoulder: [rightHip, leftShoulder],
//        leftShoulder: [leftHip],
//      },
//    );
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
    paintBody(canvas);
  }

  void paintBody(Canvas canvas) {
//    bodyMap.forEach((bodyPart, offset) {
//      canvas.drawLine(
//        offset,
//        bodyMap["nose"],
//        _paint,
//      );
//    });
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