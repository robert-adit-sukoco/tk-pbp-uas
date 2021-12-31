// @dart=2.9

import 'package:flutter/material.dart';
import 'package:tk_pbp_uas/widgets/drawer.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Environment',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'LeaN'),
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
          title: const Text('LeaN'),
          // backgroundColorStart: Colors.blue,
          // backgroundColorEnd: Colors.indigo,
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.5],
                    colors: [Colors.indigo, Colors.blue])),
            child: const Center(
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

  Widget buildDrawer() => const NavigationDrawerWidget();
}
