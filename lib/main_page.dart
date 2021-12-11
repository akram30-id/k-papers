import 'package:flutter/material.dart';
import 'package:k_papers/home.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/home_screen.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35), BlendMode.srcOver))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.1),
              child: Text(
                "Welcome to K-Papers",
                style: TextStyle(
                  fontFamily: "RobotoSlab",
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 350),
                width: 300,
                height: 200,
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
                child: Column(
                  children: [
                    Text(
                      "Turn your internet",
                      style: TextStyle(
                          fontFamily: "fonts/Poppins.ttf",
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "on to continue",
                      style: TextStyle(
                          fontFamily: "fonts/Poppins.ttf",
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            "Nor hence hoped her after other",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 17,
                                color: Colors.white),
                          ),
                          Text(
                            "known defer his. For county now",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 17,
                                color: Colors.white),
                          ),
                          Text(
                            "sister engage had season better.",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.9),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                color: Color.fromRGBO(85, 132, 176, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
