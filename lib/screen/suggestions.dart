import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Suggestions Form",
    home: SuggestionsForm(),
  ));
}

class SuggestionsForm extends StatefulWidget {
  const SuggestionsForm({Key? key}) : super(key: key);

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
    Widget okButton = TextButton(
      child: const Text("OK"),
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
        title: const Text("Suggestions Form"),
        backgroundColor: Colors.indigo,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
          child: Center(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 40.0)),
                const Text(
                  'Put your suggestions about LeaN over here!!',
                  style: TextStyle(fontFamily: 'Raleway-Bold', fontSize: 25),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(30.0)),
                    // TextField(),
                    TextFormField(
                      decoration: InputDecoration(
                        // fillColor: Color(0xffF1F0F5),
                        hintText: "ex: fasya.prandari",
                        labelText: "Name",

                        icon: const Icon(Icons.people),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
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

                    const Padding(padding: EdgeInsets.all(10.0)),
                    TextFormField(
                      decoration: InputDecoration(
                        // fillColor: Color(0xffF1F0F5),
                        // hintText: "contoh: Budidudi",
                        labelText: "Notes",
                        icon: const Icon(Icons.note),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                    const Padding(padding: EdgeInsets.all(30.0)),
                    ElevatedButton(
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            showAlertDialog(context, _uname);
                          }
                        }),

                    const Padding(padding: EdgeInsets.all(30.0)),
                    const Text(
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
