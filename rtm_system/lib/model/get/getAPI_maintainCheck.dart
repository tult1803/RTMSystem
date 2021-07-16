import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetMaintainCheck {
  getMaintainCheck() async {
    final response = await http.get(
      Uri.http(
        '$urlMain',
        '$urlMaintainCheck',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 3), onTimeout: (){
      return http.Response('Error', 404);
    });

    print("Status getApi Maintain Check:${response.statusCode}");
    return response.statusCode;
  }
}
