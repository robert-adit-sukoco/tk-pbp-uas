// @dart=2.9

import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:tk_pbp_uas/widgets/drawer.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
// // import 'package:gradient_app_bar/';

void main() {
  runApp(MyApp());
}

class Env {
  static String URL_PREFIX = "http://127.0.0.1:8000";
  static bool isLoggedIn = false;
  static Map<dynamic, dynamic> userData = {
    "name": "",
    "pass": "",
  };
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Environment',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'LeaN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          title: Text('LeaN'),
          // backgroundColorStart: Colors.blue,
          // backgroundColorEnd: Colors.indigo,
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.5],
                    colors: [Colors.indigo, Colors.blue])),
            child: Center(
                child: Text(
              'LeaN \n'
              '-Learning Environment- \n',
              // textAlign: TextAlign.center,
              // LeaN is the world's #1 education system centered on teacher-studentinteraction.
              style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))));
  }

  Widget buildDrawer() => NavigationDrawerWidget();
}
