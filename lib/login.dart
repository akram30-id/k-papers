import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:k_papers/home.dart';
import 'package:k_papers/lupa_password.dart';
import 'package:k_papers/model/api.dart';
import 'package:k_papers/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notLogIn, LogIn, Loginuser }

class _LoginState extends State<Login> {
  String username, password;
  LoginStatus _loginStatus = LoginStatus.notLogIn;
  bool _secureText = true;
  final key = GlobalKey<FormState>();

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  cek() {
    final form = key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    try {
      final response = await http.post(Uri.parse(Api.login), body: {
        'username': username,
        'password': password
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Connection Timeout, please try again");
      });
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];
      String usernameApi = data['username'];
      String namaApi = data['nama'];
      String email = data['email'];
      String id = data['id'];
      String phoneApi = data['phone'];
      String level = data['level'];
      if (value == 1) {
        if (level == "1") {
          setState(() {
            _loginStatus = LoginStatus.LogIn;
            savePref(value, namaApi, usernameApi, email, id, phoneApi, level);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          });
        } else if (level == "2") {
          setState(() {
            _loginStatus = LoginStatus.Loginuser;
            savePref(value, namaApi, usernameApi, email, id, phoneApi, level);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          });
        } else if (level == "3") {
          _loginStatus = LoginStatus.notLogIn;
          savePref(value, namaApi, usernameApi, email, id, phoneApi, level);
        }
        print(pesan);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Username dan Password salah"),
        ));
        print(pesan);
      }
      print(data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  savePref(int value, String nama, String username, String email, String id,
      String phone, String level) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("email", email);
      preferences.setString("nama", nama);
      preferences.setString("id", id);
      preferences.setString("phone", phone);
      preferences.setString("level", level);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: key,
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
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
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
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    obscureText: _secureText,
                    onSaved: (e) => password = e,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        suffixIcon: IconButton(
                            icon: _secureText
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: showHide)),
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
                      "Login",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Register();
                        }));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LupaPassword();
                    }));
                  },
                  child: Text(
                    "Lupa Password",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
