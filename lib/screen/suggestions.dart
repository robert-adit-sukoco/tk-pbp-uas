import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'lib.dart'
import 'dart:convert';
import '../main.dart';

void main() {
  runApp(MaterialApp(
    title: "Suggestions Form",
    home: SuggestionsForm(),
  ));
}

class SuggestionsForm extends StatefulWidget {
  @override
  _SuggestionsFormState createState() => _SuggestionsFormState();
}

class _SuggestionsFormState extends State<SuggestionsForm> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  String _uname = "";
  String _notes = "";
  String gabungan = "";
  bool ada = false;

  showAlertDialog(BuildContext context, String _uname) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.lightBlue,
      title: Text("Thank you for your response, " + _uname + "!"),
      // content: Text(""),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void baru(String nama) {
    setState(() {
      _uname = nama;
      if (_uname == "") {
        ada = false;
      } else {
        ada = true;
      }
    });
  }

  void baru2(String note) {
    setState(() {
      _notes = note;
      if (_notes == "") {
        ada = false;
      } else {
        ada = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions Form"),
        backgroundColor: Colors.indigo,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
          child: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Text(
                  'Put your suggestions about LeaN over here!!',
                  style: TextStyle(fontFamily: 'Raleway-Bold', fontSize: 25),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(30.0)),
                    // TextField(),
                    TextFormField(
                      decoration: new InputDecoration(
                        // fillColor: Color(0xffF1F0F5),
                        hintText: "ex: fasya.prandari",
                        labelText: "Name",

                        icon: Icon(Icons.people),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                      ),
                      onChanged: (String value) {
                        baru(value);
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    Padding(padding: EdgeInsets.all(10.0)),
                    TextFormField(
                      decoration: new InputDecoration(
                        // fillColor: Color(0xffF1F0F5),
                        // hintText: "contoh: Budidudi",
                        labelText: "Notes",
                        icon: Icon(Icons.note),

                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                      ),
                      onChanged: (String value) {
                        baru2(value);
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Notes tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.all(30.0)),
                    RaisedButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            showAlertDialog(context, _uname);
                            print(_uname +
                                " berhasil memberi masukan: " +
                                _notes);
                          }
                        }),

                    Padding(padding: EdgeInsets.all(30.0)),
                    Text(
                      '- Learning Environment -',
                      style:
                          TextStyle(fontFamily: 'Raleway-Bold', fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
