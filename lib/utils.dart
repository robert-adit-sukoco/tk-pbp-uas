// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'main.dart';

// Future<Map<dynamic, dynamic>> getUserData() async {
//   final prefs = await SharedPreferences.getInstance();
//   int? userId = prefs.getInt('user_id');
//   userId ??= 1;
//   final response =
//       await http.get(Uri.parse("${Env.URL_PREFIX}/getData/$userId"));
//   var res = jsonDecode(response.body);
//   return res;
// }

// Future<bool> is_authenticated() async {
//   if (true) {
//     final prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getInt('user_id');
//     var sessionId = prefs.getString('session_id');
//     final response = await http.post(Uri.parse("${Env.URL_PREFIX}/auth/"),
//         headers: <String, String>{
//           'Content-Type': 'application/json;charset=UTF-8'
//         },
//         body: jsonEncode(<String, dynamic>{
//           'user_id': userId,
//           'session_id': sessionId,
//         }));
//     var res = jsonDecode(response.body);
//     if (res['is_authenticated'] == true) {
//       return true;
//     }
//     return false;
//   }
//   return false;
// }
