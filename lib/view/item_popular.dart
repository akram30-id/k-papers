import 'package:flutter/material.dart';
import 'package:k_papers/model/image_model.dart';
import 'package:wallpaper/wallpaper.dart';

class ItemPopular extends StatefulWidget {
  final ImageModel model;
  ItemPopular(this.model);

  @override
  _ItemPopularState createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      link =
          "https://akram-syahrastani.000webhostapp.com/kpapers/item/image/popular/";

  Stream<String> progressString;
  String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Hero(
        tag: 'item3',
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: 200,
                height: 350,
                child: Image.network(
                  link + widget.model.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      progressString = Wallpaper.ImageDownloadProgress(
                          link + widget.model.image);
                      progressString.listen((data) {
                        setState(() {
                          res = data;
                          downloading = true;
                        });
                        print("Data Recieved" + data);
                      }, onDone: () async {
                        var width = MediaQuery.of(context).size.width;
                        var height = MediaQuery.of(context).size.height;
                        home = await Wallpaper.homeScreen(
                            options: RequestSizeOptions.RESIZE_FIT,
                            width: width,
                            height: height);
                        setState(() {
                          downloading = false;
                          home = home;
                        });
                        print("Task Done");
                      }, onError: (error) {
                        setState(() {
                          downloading = false;
                        });
                        print("Some Error");
                      });
                    },
                    child: Text(home,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    color: Color.fromRGBO(85, 132, 176, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      progressString = Wallpaper.ImageDownloadProgress(
                          link + widget.model.image);
                      progressString.listen((data) {
                        setState(() {
                          res = data;
                          downloading = true;
                        });
                        print("Data Recieved" + data);
                      }, onDone: () async {
                        var width = MediaQuery.of(context).size.width;
                        var height = MediaQuery.of(context).size.height;
                        lock = await Wallpaper.lockScreen(
                            options: RequestSizeOptions.RESIZE_FIT,
                            width: width,
                            height: height);
                        setState(() {
                          downloading = false;
                          lock = lock;
                        });
                        print("Task Done");
                      }, onError: (error) {
                        setState(() {
                          downloading = false;
                        });
                        print("Some Error");
                      });
                    },
                    child: Text(lock,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    color: Color.fromRGBO(85, 132, 176, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      progressString = Wallpaper.ImageDownloadProgress(
                          link + widget.model.image);
                      progressString.listen((data) {
                        setState(() {
                          res = data;
                          downloading = true;
                        });
                        print("Data Recieved" + data);
                      }, onDone: () async {
                        var width = MediaQuery.of(context).size.width;
                        var height = MediaQuery.of(context).size.height;
                        both = await Wallpaper.bothScreen(
                            options: RequestSizeOptions.RESIZE_FIT,
                            width: width,
                            height: height);
                        setState(() {
                          downloading = false;
                          both = both;
                        });
                        print("Task Done");
                      }, onError: (error) {
                        setState(() {
                          downloading = false;
                        });
                        print("Some Error");
                      });
                    },
                    child: Text(both,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    color: Color.fromRGBO(85, 132, 176, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.blue[700],
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
