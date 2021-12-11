import 'package:flutter/material.dart';
import 'package:k_papers/view/add/add_feautured.dart';
import 'package:k_papers/view/add/add_popular.dart';
import 'package:k_papers/view/add/add_trending.dart';
import 'package:k_papers/view/popular.dart';

class AddChoose extends StatefulWidget {
  @override
  _AddChooseState createState() => _AddChooseState();
}

class _AddChooseState extends State<AddChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Category"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddTrending();
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Trending",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 5.0),
                          blurRadius: 15),
                    ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddFeautured();
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Feautured",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 5.0),
                          blurRadius: 15),
                    ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddPopular();
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 5.0),
                          blurRadius: 15),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
