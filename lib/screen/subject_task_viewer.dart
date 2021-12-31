import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tk_pbp_uas/navigation_drawer_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class SubjectViewer extends StatefulWidget {
  final String title;
  const SubjectViewer({Key? key, required this.title}) : super(key: key);
  @override
  _SubjectViewerState createState() => _SubjectViewerState();
}

class _SubjectViewerState extends State<SubjectViewer> {
  TextEditingController controller = TextEditingController();
  List<PlatformFile>? _files;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          title: const Text("Submission"),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.indigo),
                    child: Align(
                      child: Text(
                        "Subjek",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment(0, -0.80),
                    ),
                  ),
                  height: 150,
                  width: 400,
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "File:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text("Choose File"),
                onPressed: _chooseFile,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            Padding(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Comment:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextField(
                controller: controller,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text("Upload"),
                  onPressed: _uploadFile,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ))
          ],
        ));
  }

  Widget buildDrawer() => NavigationDrawerWidget();

  void _chooseFile() async {
    _files = (await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      allowedExtensions: null,
    ))!
        .files;
    print('Loaded file path is: ${_files!.first.path}');
  }

  void _uploadFile() async {
    var uri = Uri.parse('http://localhost:50419/added_file');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'file', _files!.first.path.toString()));
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Uploaded!");
    } else {
      print("Error");
    }
  }
}
