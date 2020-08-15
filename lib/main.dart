import 'package:flutter/material.dart';
import 'package:flutter_realtime_pose_detection/Pages/welcome_screen.dart';
import 'package:flutter_realtime_pose_detection/components/body_info.dart';
import 'package:flutter_realtime_pose_detection/constants.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:flutter_realtime_pose_detection/home.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter App (Garuda)",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '1.',
        routes:{
          '1.' : (context) => WelcomeScreen(),
          '2.' : (context) => InfoBody(),
          '3.' : (context) => HomePage(cameras),
        },
    );
  }
}

