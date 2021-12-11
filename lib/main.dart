import 'package:flutter/material.dart';
import 'package:k_papers/begin.dart';
import 'package:k_papers/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
     home: Begin(), 
    );
  }
}