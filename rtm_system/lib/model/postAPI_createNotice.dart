
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateNotice{
  createNotice(String tittle, String content, String account_id, String token) async {
    final response = await http.post(
      Uri.http('${url_main}', '${url_createNotice}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "title": tittle,
        "content": content,
        "account_id": account_id
      }),
    );
    print("Status postApi CreateNotice:${response.statusCode}");
    return response.statusCode;
  }

}
