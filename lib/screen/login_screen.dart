import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: "Login Page",
    home: BelajarForm(),
  ));
}

class BelajarForm extends StatefulWidget {
  const BelajarForm({Key? key}) : super(key: key);
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

class _BelajarFormState extends State<BelajarForm> {
  final _formKey = GlobalKey<FormState>();

  bool hidepassword = true;
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  String username = "";
  String password = "";
  String gabungan = "";
  bool ada = false;

  showAlertDialog1(BuildContext context, String _username) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert1 = AlertDialog(
      backgroundColor: Colors.lightBlue,
      title: Text("Login Successful! Nice to meet you " + _username + "!"),
      // content: Text(""),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert1;
      },
    );
  }

  showAlertDialog2(BuildContext context, String _username) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert2 = AlertDialog(
      backgroundColor: Colors.lightBlue,
      title: const Text("Wrong username / password!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }

  void baru(String nama) {
    setState(() {
      username = nama;
      if (username == "") {
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
        title: const Text("LOG IN"),
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
                  'Welcome Back to LeaN!',
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
                        hintText: "contoh: fasya.prandari",
                        labelText: "Username",

                        icon: const Icon(Icons.people),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      controller: usernameCont,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const Padding(padding: EdgeInsets.all(10.0)),
                    TextFormField(
                      // obscureText: true,
                      obscureText: hidepassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        icon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      controller: passwordCont,
                      // onChanged: (String value) {
                      //   baru(value);
                      // },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
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
                          if (_formKey.currentState!.validate()) {
                            final response1 = await http.post(Uri.parse(
                                "https://pbp-uas-backend.herokuapp.com/login?username=" +
                                    username +
                                    "&password=" +
                                    password));
                            print(response1.request!.method);
                            print(response1.statusCode);
                            if (response1.statusCode == 200) {
                              final response2 = await http.get(Uri.parse(
                                  "https://pbp-uas-backend.herokuapp.com/apiuser/" +
                                      username +
                                      "/"));
                              showAlertDialog1(context, username);
                              Map<String, dynamic> feedback =
                                  json.decode(response2.body);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard(jsonData: feedback)));
                            } else {
                              showAlertDialog2(context, username);
                            }
                          } else {
                            showAlertDialog2(context, username);
                          }
                        }
                        // }
                        // }
                        ),

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
