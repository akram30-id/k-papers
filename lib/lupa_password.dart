import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:k_papers/model/api.dart';
import 'package:k_papers/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  String username, id;
  final key = GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
  }

  cek() async {
    try {
      final response = await http.post(Uri.parse(Api.cekusername), body: {
        "username": username,
        "id": id
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
          return ResetPassword();
        }));
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
      cek();
    }
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
                  onSaved: (e) => username = e,
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Username wajib diisi";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
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
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
