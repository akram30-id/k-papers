import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k_papers/custom/date_pick.dart';
import 'package:http/http.dart' as http;
import 'package:k_papers/model/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String pilihTanggal, labelText;
  String username, password, nama, phone, email, otp;
  final _key = GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var validate = false;
  cek() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      register();
    } else {
      setState(() {
        validate = true;
      });
    }
  }

  register() async {
    try {
      final response = await http.post(Uri.parse(Api.register), body: {
        "nama": nama,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "otp": otp,
        "tgl_lahir": "$tgl_lahir",
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Connection Timeout, please try again");
      });
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];
      if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(pesan),
        ));
      } else if (value == 1) {
        print(pesan);
        Navigator.pop(context);
      } else {
        print(pesan);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  DateTime tgl_lahir = new DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl_lahir,
        firstDate: DateTime(1945),
        lastDate: DateTime(2030));
    if (picked != null && picked != tgl_lahir) {
      setState(() {
        tgl_lahir = picked;
        pilihTanggal = new DateFormat.yMd().format(tgl_lahir);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidate: validate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 200,
                  height: 200,
                  child: Image.asset("asset/icon.png"),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Nama Lengkap wajib diisi";
                    }
                    return null;
                  },
                  onSaved: (e) => nama = e,
                  decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment(-0.85, 0.0),
                child: Text(
                  "Tanggal Lahir",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: DateDropDown(
                  labelText: labelText,
                  valueText: new DateFormat.yMd().format(tgl_lahir),
                  valueStyle: valueStyle,
                  onPressed: () {
                    _selectedDate(context);
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Username wajib diisi";
                    }
                    return null;
                  },
                  onSaved: (e) => username = e,
                  decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Email wajib diisi";
                    }
                    return null;
                  },
                  onSaved: (e) => email = e,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Password wajib diisi";
                    }
                    return null;
                  },
                  onSaved: (e) => password = e,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _secureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: showHide,
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (e) {
                    if (e.length < 6 && e.length > 1) {
                      return "PIN harus 6 angka";
                    }
                    return null;
                  },
                  onSaved: (e) => otp = e,
                  decoration: InputDecoration(
                      labelText: "PIN Pemulihan",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Nomor HP wajib diisi";
                    }
                    return null;
                  },
                  onSaved: (e) => phone = e,
                  decoration: InputDecoration(
                      labelText: "Nomor HP",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  cek();
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
                    "Register",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
