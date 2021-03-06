import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAdvanceHistory{
  static int statusInvoice;
  getAdvanceHistory(BuildContext context, String token, String accountId,int pageNum, int pageNo) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlAdvanceHistory/$accountId', {  "pageNum" : "$pageNum" ,"pageNo" : "$pageNo" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getAdvanceHistory:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      List<dynamic> listAdvance = json.decode(response.body);
      return listAdvance;
    } else {
      // throw an exception.
      checkTimeToken(context, response.statusCode);
      throw Exception('Failed to load data');
    }
  }

}

