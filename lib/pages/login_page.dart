import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'lib.dart'
import 'dart:convert';
import '../main.dart';
import '../utils.dart';

void main() {
  runApp(MaterialApp(
    title: "Login Page",
    home: BelajarForm(),
  ));
}

class BelajarForm extends StatefulWidget {
  static const routeName = '/login';
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

Future<bool> login(String username, String password) async {
  final response = await http.post(
      Uri.parse(
          "https://localhost:8000/login?username=$username&password=$password"),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
            'Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept'
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }));
  var res = jsonDecode(response.body);

  if (res['success'] == false) {
    return false;
  }
  return true;
}

// class Login {
//   final String username;
//   final String pass;

//   Login({
//     required this.username,
//     required this.pass,
//   });

//   factory Login.fromJson(Map<String, dynamic> json) {
//     return Login(
//       username: json['user'],
//       pass: json['pass'],
//     );
//   }
// }

// Future<http.Response> fetch(String username, String pass) {
//   return http.post(
//     Uri.parse('https://127.0.0.1:8000/login?'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8'
//     },
//     body: jsonEncode(<String, String>{
//       'username': username,
//       'pass': pass,
//     }),
//   );
// // String url = "https://127.0.0.1:8000/login?";
// // final response = await http.post(Uri.parse(url));

class _BelajarFormState extends State<BelajarForm> {
  final _formKey = GlobalKey<FormState>();

  bool hidepassword = true;
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  String username = "";
  String password = "";
  String gabungan = "";
  bool ada = false;

  showAlertDialog(BuildContext context, String _username) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        // onPressed: () {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => HomePage()));
        //},
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

    // Create AlertDialog
    AlertDialog alert2 = AlertDialog(
      backgroundColor: Colors.lightBlue,
      title: Text("Wrong username / password!"),
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
        title: Text("LOG IN"),
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
                  'Welcome Back to LeaN!',
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
                        hintText: "contoh: fasya.prandari",
                        labelText: "Username",

                        icon: Icon(Icons.people),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
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

                    Padding(padding: EdgeInsets.all(10.0)),
                    TextFormField(
                      // obscureText: true,
                      obscureText: hidepassword,
                      decoration: new InputDecoration(
                        // fillColor: Color(0xffF1F0F5),
                        // hintText: "contoh: Budidudi",
                        labelText: "Password",
                        icon: Icon(Icons.lock),

                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
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
                    Padding(padding: EdgeInsets.all(10.0)),
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
                          // String username = usernameCont.text;
                          // String password = passwordCont.text;
                          // bool result = await login(username, password);
                          // if (result == true) {
                          //   // await (result) {
                          //   //     Env.userData['name'] = result['username'];
                          //   //     Env.userData['email'] = result['email'];
                          //   //   };
                          if (_formKey.currentState!.validate()) {
                            print("masuk");
                            final response = await http.post(
                                Uri.parse('http://127.0.0.1:8000/login'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json;charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'username': username,
                                  'password': password,
                                }));
                            showAlertDialog(context, username);
                            print(username + " berhasil login!");
                            print(response);
                            print(response.body);
                          } else {
                            print("invalid");
                          }
                        }
                        // }
                        // }
                        ),

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
