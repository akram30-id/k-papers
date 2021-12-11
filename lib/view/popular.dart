import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:k_papers/main.dart';
import 'package:k_papers/model/api.dart';
import 'package:k_papers/model/image_model.dart';
import 'package:k_papers/view/item_popular.dart';
import 'package:k_papers/view/item_trending.dart';
import 'package:http/http.dart' as http;

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  var loading = false;
  var result = "Waiting to set wallpaper";
  final list = List<ImageModel>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  String home = "Home Screen", lock = "Lock Screen", both = "Both Screen";

  Stream<String> progressString;
  String res;
  bool downloading = false;

  Future<void> _image() async {
    list.clear();
    setState(() {
      loading = true;
    });
    try {
      final response = await http
          .get(Uri.parse(Api.imagePopular))
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Connection timeout, please try again");
      });
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final show = ImageModel(
          api['image'],
          api['id'],
        );
        list.add(show);
      });
      setState(() {
        loading = false;
      });
      return response;
    } catch (e) {
      print(e);
    }
  }

  _delete(String id) async {
    final response =
        await http.post(Uri.parse(Api.deletePopular), body: {"id": id});
    final data = jsonDecode(response.body);
    String pesan = data['message'];
    int value = data['value'];
    if (value == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(pesan),
      ));
      setState(() {
        _image();
      });
    } else {
      print(pesan);
    }
  }

  dialogDelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  "Apakah anda yakin ingin menghapus item ini ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        _delete(id);
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: _image,
          key: _refresh,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.black54,
                ))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height)),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Column(
                      children: [
                        Container(
                          width: 100,
                          height: 150,
                          child: InkWell(
                            onDoubleTap: () {
                              dialogDelete(x.id);
                            },
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ItemPopular(x);
                              }));
                            },
                            child: Card(
                              // semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                "https://akram-syahrastani.000webhostapp.com/kpapers/item/image/popular/" +
                                    x.image,
                                fit: BoxFit.cover,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Text(
                          "Free",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ],
                    );
                  }),
        ),
      ),
    );
  }
}
