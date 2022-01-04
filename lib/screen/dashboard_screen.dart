import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tk_pbp_uas/screen/grade_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.jsonData}) : super(key: key);
  final Map<String, dynamic> jsonData;
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<Widget> itemsData = [];

  void getData() async {
    final response = await http.get(Uri.parse(
        "https://pbp-uas-backend.herokuapp.com/get_students_subjects?sid=" +
            widget.jsonData['username']));

    

    List<Widget> listItem = [];
    List<dynamic> responseList = json.decode(response.body);
    
    if (widget.jsonData['is_teacher'].toString().compareTo("true") == 0) {
      final response2 = await http.get(Uri.parse(
        "https://pbp-uas-backend.herokuapp.com/get_teachers_subjects?teacher_id=" +
            widget.jsonData['username']));

      List<dynamic> responseList2 = json.decode(response2.body);
      for (var post in responseList2) {

        listItem.add(ListTile(
          leading: const Icon(Icons.list),
          title: Text(post['name'].split('-')[1].trim() +
              " - " +
              post['name'].split('-')[0].trim()),
          trailing: TextButton(child: const Text("Task Manager"),
          onPressed: () {},)
          ,));
      }
    } else {
      for (var post in responseList) {
        listItem.add(Card(
          
          child: Column(mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
               title: Text(post['name'].split('-')[1].trim() +
              " - " + post['name'].split('-')[0].trim()),
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Task Viewer'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('View Grades'),
                  onPressed: () async {Map<String, dynamic> inputJson = {};
              inputJson.addAll(widget.jsonData);
              inputJson.addAll(post);
              final response1 = await http.get(Uri.parse(
                  "https://pbp-uas-backend.herokuapp.com/get_subjects_tasks?subject_id=" +
                      post['subject_id']));
              List<dynamic> tmpList = [];
              List<dynamic> store = json.decode(response1.body);
              for (var data in store) {
                final response2 = await http.get(Uri.parse(
                    "https://pbp-uas-backend.herokuapp.com/get_tasks_submissions?task_id=" +
                        data['task_id']));
                List<dynamic> responseList = json.decode(response2.body);
                if (responseList.isNotEmpty) {
                  Map<String, dynamic> tmpMap = {};
                  tmpMap['name'] = data['task_name'];
                  for (var submission in responseList) {
                    tmpMap['score'] = submission['grade'];
                  }
                  tmpList.add(tmpMap);
                }
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Grade(jsonMap: inputJson, jsonList: tmpList)));},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        )));
        
      }
    }
    setState(() {
      itemsData = listItem;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: ListView.builder(
            itemCount: itemsData.length,
            itemBuilder: (context, index) {
              return itemsData[index];
            }));
  }
}

