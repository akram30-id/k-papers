import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:k_papers/main.dart';
import 'package:k_papers/model/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  String password_lama, password_baru, id;
  final key = GlobalKey<FormState>();
  bool _secureText1 = true;
  bool _secureText2 = true;

  showHide1() {
    setState(() {
      _secureText1 = !_secureText1;
    });
  }

  showHide2() {
    setState(() {
      _secureText2 = !_secureText2;
    });
  }

  change() async {
    try {
      final response = await http.post(Uri.parse(Api.edit), body: {
        "password_lama": password_lama,
        "id": id,
        "password_baru": password_baru
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Connection Timeout, please try again");
      });
      final data = jsonDecode(response.body);
      String pesan = data['message'];
      int value = data['value'];
      if (value == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(pesan),
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyApp();
        }));
      } else if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(pesan),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(pesan),
        ));
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  submit() {
    final form = key.currentState;
    if (form.validate()) {
      form.save();
      change();
    }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.asset("asset/icon.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Ubah Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  obscureText: _secureText1,
                  onSaved: (e) => password_lama = e,
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Password lama wajib diisi";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password lama",
                      suffixIcon: IconButton(
                          icon: Icon(_secureText1
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            showHide1();
                          })),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  obscureText: _secureText2,
                  onSaved: (e) => password_baru = e,
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Password baru wajib diisi";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password baru",
                      suffixIcon: IconButton(
                          icon: Icon(_secureText2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            showHide2();
                          })),
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  submit();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 5.0),
                            blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                child: Text(
                  "Lupa password",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
