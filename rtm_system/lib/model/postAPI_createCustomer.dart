
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateCustomer{

  createNotice(String token, String phone, String password, String fullname, int gender, String cmnd, String address, String birthday) async {
    final response = await http.post(
      Uri.http('${url_main}', '${url_createCustomer}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "password": password,
        "role_id": 3,
        "fullname": fullname,
        "gender": gender,
        "birthday": birthday,
        "phone": phone,
        "cmnd": cmnd,
        "address": address
      }),
    );
    print("Status postApi CreateCustomer:${response.statusCode}");
    return response.statusCode;
  }

}
