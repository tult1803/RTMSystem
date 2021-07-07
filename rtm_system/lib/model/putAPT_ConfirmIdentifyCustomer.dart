import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PutConfirmIdentifyCustomer {
  updateCustomer(String token,
      {String cmnd,
      String birthday,
      String fullName,
      String address,
      int gender}) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlConfirmIdentifyCustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "cmnd": cmnd,
        "birthday": birthday,
        "fullname": fullName,
        "address": address,
        "gender": gender,
      }),
    );
    print("Status putAPI Confirm Identify Customer:${response.statusCode}");
    return response.statusCode;
  }
}
