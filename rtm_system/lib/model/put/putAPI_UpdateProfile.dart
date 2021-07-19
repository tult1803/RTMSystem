import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PutUpdateProfileCustomer {
  updateProfileCustomer(
    String token,
    String cmnd,
    String birthday,
    String fullname,
    String address,
    int gender,
  ) async {
    print(birthday);
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdateCustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "cmnd": cmnd,
        "birthday": birthday,
        "fullname": fullname,
        "address": address,
        "gender": gender,
      }),
    );
    print("Status putAPI updateProfileCustomer:${response.statusCode}");
    return response.statusCode;
  }
}
