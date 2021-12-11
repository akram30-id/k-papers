import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:k_papers/home.dart';
import 'package:k_papers/model/api.dart';
import 'package:k_papers/view/trending.dart';
import 'package:path/path.dart';

class AddTrending extends StatefulWidget {
  // final VoidCallback reload;
  // AddTrending(this.reload);

  @override
  _AddTrendingState createState() => _AddTrendingState();
}

class _AddTrendingState extends State<AddTrending> {
  File _imageFile;

  _gallery() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 3000, maxWidth: 1920);
    setState(() {
      _imageFile = File(image.path);
      print(_imageFile.path);
    });
  }

  submit() async {
    try {
      var stream = http.ByteStream(DelegatingStream(_imageFile.openRead()));
      stream.cast();
      var length = await _imageFile.length();
      var uri = Uri.parse(Api.addTrending);
      final request = http.MultipartRequest("POST", uri);
      request.files.add(http.MultipartFile("image", stream, length,
          filename: context.basename(_imageFile.path)));
      var response =
          await request.send().timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Connection Timeout, please try again");
      });
      ;
      if (response.statusCode == 200) {
        print("UPLOAD SUCCESS");
        setState(() {
          // widget.reload();
          Navigator.push(this.context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        });
      } else {
        print("UPLOAD FAILED");
      }
      return response;
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: 150,
      height: 350,
      decoration: BoxDecoration(color: Colors.grey),
      child: Center(
        child: Icon(
          Icons.add_circle,
          size: 30,
        ),
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Upload Wallpaper Image",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('asset/icon.png'))),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 250,
                  width: 150,
                  child: InkWell(
                    onTap: _gallery,
                    child: _imageFile == null
                        ? placeholder
                        : Image.file(
                            _imageFile,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    submit();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 5.0),
                              blurRadius: 15),
                        ]),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
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
