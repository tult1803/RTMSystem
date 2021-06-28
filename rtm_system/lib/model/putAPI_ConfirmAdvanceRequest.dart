
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutConfirmAdvanceRequest{
  putConfirmAdvanceRequest(String token, String id) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlConfirmAdvanceRequest/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    return response.statusCode;
  }

}
