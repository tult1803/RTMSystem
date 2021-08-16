import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rtm_system/model/model_AdvanceDetail.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAdvanceDetail{
  static int statusInvoice;
  getAdvanceDetail(BuildContext context,String token, String id, int statusId) async {
    final response = await http.get(
    Uri.http('$urlMain', '$urlAdvanceDetail/$id', { "status_id" : "$statusId"}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getAdvanceDetail:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  AdvanceDetail.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      checkTimeToken(context, response.statusCode);
      throw Exception('Failed to load data');
    }
  }

}

