import 'dart:convert';

import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class ChangeForgotPassword{
  getPassword(String fbToken, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.http('$urlMain', '$urlForgetPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "password": "$password",
        "confirmPassword": "$confirmPassword",
        "firebaseToken": "$fbToken",
      }),
    );
    print("Status postApi Forget Password:${response.statusCode}");
    return response.statusCode;
  }
}
