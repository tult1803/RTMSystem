import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PostValidateCustomer{

  createValidateCustomer(String token,
      {String face, String cmndFront, String cmndBack}) async {
    final response = await http.post(
      Uri.http('$urlMain', '$urlValidateCustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "cmnd1": cmndFront,
        "cmnd2": cmndBack,
        "avt" : face,
      }),
    );
    print("Status postApi ValidateCustomer:${response.statusCode}");
    return response.statusCode;
  }

}
