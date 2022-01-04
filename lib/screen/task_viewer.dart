import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;

class TaskViewer extends StatefulWidget {
  final String title;
  const TaskViewer({Key? key, required this.title}) : super(key: key);
  @override
  _TaskViewerState createState() => _TaskViewerState();
}

class _TaskViewerState extends State<TaskViewer> {
  String task_name = "";
  String description = "";
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              drawer: buildDrawer(),
              appBar: AppBar(
                title: Text("Task Viewer"),
                centerTitle: true,
                backgroundColor: Colors.indigo,
              ),
              body: ListView(
                padding: EdgeInsets.all(15),
                children: widgets,
              ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<String> getData() async {
    const url = 'http://pbp-uas-backend.herokuapp.com/apitask/';
    widgets = [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 0, 20),
        child: Text(
          "Kelas",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 40,
          ),
        ),
      ),
    ];
    try {
      final response = await http.get(Uri.parse(url));
      List<dynamic> data = jsonDecode(response.body);
      for (Map<String, dynamic> element in data) {
        widgets.add(new MyCard(
          element['task_name'],
          element['description'],
        ));
      }
    } catch (error) {
      print(error);
    }
    return "";
  }
}

Widget buildDrawer() => NavigationDrawerWidget();

class MyCard extends StatelessWidget {
  String task_id = "";
  String subject_fkey = "";
  String task_name = "";
  String description = "";

  MyCard(String task_name, String description) {
    this.task_name = task_name;
    this.description = description;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
      shadowColor: Colors.indigo,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Text(
                    this.task_name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 4),
                Align(
                  child: Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  alignment: Alignment(-0.95, 1),
                ),
                Divider(color: Colors.white70),
                const SizedBox(height: 24),
                Container(
                  height: 300,
                  child: SingleChildScrollView(
                      child: Align(
                    child: Text(
                      this.description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    alignment: Alignment(-0.90, -1),
                  )),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 400,
                        height: 40,
                        child: ElevatedButton(
                          child: Text(
                            "Upload File",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                getColor(Colors.white, Colors.indigo),
                            backgroundColor:
                                getColor(Colors.indigo, Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      )),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorHovered) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return colorHovered;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }
}
