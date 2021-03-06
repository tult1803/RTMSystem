
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateNotice{
  createNotice(String tittle, String content, String accountId, String token) async {
    final response = await http.post(
      Uri.http('$urlMain', '$urlCreateNotice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "title": tittle,
        "content": content,
        "account_id": accountId
      }),
    );
    print("Status postApi CreateNotice:${response.statusCode}");
    return response.statusCode;
  }

}
