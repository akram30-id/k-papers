import 'package:flutter/material.dart';
import 'package:k_papers/login.dart';
import 'package:k_papers/main.dart';
import 'package:k_papers/me.dart';
import 'package:k_papers/view/add/add_choose.dart';
import 'package:k_papers/view/trending.dart' as trending;
import 'package:k_papers/view/feautured.dart' as feautured;
import 'package:k_papers/view/popular.dart' as popular;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum LoginStatus { Login, noLogin, LoginUser }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  LoginStatus _loginStatus = LoginStatus.noLogin;

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getString('level');
      _loginStatus = value == '1'
          ? LoginStatus.Login
          : value == '2'
              ? LoginStatus.LoginUser
              : LoginStatus.noLogin;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      setState(() {
        preferences.setInt("value", 2);
        preferences.setString("level", "3");
        _loginStatus = LoginStatus.noLogin;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyApp();
        }));
      });
      preferences.commit();
    });
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Ingin logout atau ubah password?"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                },
                child: Text("Logout"),
              ),
              SimpleDialogOption(
                child: Text("Ubah Password"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Me();
                  }));
                },
              )
            ],
          );
        });
  }

  TabController controller;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
    getPref();
  }

  DateTime lastPressed;

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.noLogin:
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins'
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Carousel(
                        dotSize: 7.0,
                        dotSpacing: 10.0,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.transparent,
                        images: [
                          Image.asset(
                            "asset/1.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/2.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/3.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/4.jpg",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            icon: Icon(Icons.account_circle_sharp),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                            }),
                      ],
                    )
                  ],
                ),
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Color.fromRGBO(85, 132, 176, 1),
                  tabs: [
                    Tab(
                      text: "Trending",
                    ),
                    Tab(
                      text: "Featured",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                  ],
                  controller: controller,
                ),
                Expanded(
                  child: SizedBox(
                    height: 380,
                    child: TabBarView(controller: controller, children: [
                      trending.Trending(),
                      feautured.Feautured(),
                      popular.Popular()
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
        break;

      case LoginStatus.Login:
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins'
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Carousel(
                        dotSize: 7.0,
                        dotSpacing: 10.0,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.transparent,
                        images: [
                          Image.asset(
                            "asset/1.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/2.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/3.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/4.jpg",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            icon: Icon(Icons.account_circle_sharp),
                            onPressed: () {
                              _showDialog();
                            }),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddChoose();
                              }));
                            }),
                      ],
                    )
                  ],
                ),
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Color.fromRGBO(85, 132, 176, 1),
                  tabs: [
                    Tab(
                      text: "Trending",
                    ),
                    Tab(
                      text: "Featured",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                  ],
                  controller: controller,
                ),
                Expanded(
                  child: SizedBox(
                    height: 380,
                    child: TabBarView(controller: controller, children: [
                      trending.Trending(),
                      feautured.Feautured(),
                      popular.Popular()
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
        break;

      case LoginStatus.LoginUser:
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins'
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Carousel(
                        dotSize: 7.0,
                        dotSpacing: 10.0,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.transparent,
                        images: [
                          Image.asset(
                            "asset/1.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/2.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/3.jpg",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/4.jpg",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            icon: Icon(Icons.account_circle_rounded),
                            onPressed: () {
                              _showDialog();
                            }),
                      ],
                    )
                  ],
                ),
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Color.fromRGBO(85, 132, 176, 1),
                  tabs: [
                    Tab(
                      text: "Trending",
                    ),
                    Tab(
                      text: "Featured",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                  ],
                  controller: controller,
                ),
                Expanded(
                  child: SizedBox(
                    height: 380,
                    child: TabBarView(controller: controller, children: [
                      trending.Trending(),
                      feautured.Feautured(),
                      popular.Popular()
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
        break;
    }
  }
}
