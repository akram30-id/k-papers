import 'package:flutter/material.dart';
import 'package:k_papers/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Begin extends StatefulWidget {
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text("Welcome to K-Papers", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
      seconds: 3,
      navigateAfterSeconds: HomePage(),
      imageBackground: AssetImage("asset/home_screen.jpg"),
      // loadingText: Text(
      //   "Welcome to K-Papers",
      //   style: TextStyle(
      //     fontSize: 30,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
