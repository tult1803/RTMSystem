import 'dart:convert';
import 'package:rtm_system/model/model_AdvanceRequest.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAdvanceRequest{
  static int statusInvoice;
  getAdvanceRequest(String token, String account_id, int status_id, int pageNum, int pageNo, String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlAdvanceRequest', { "customer_id" : "$account_id", "status_id" : "$status_id", "from" : "$from", "to" : "$to", "pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getAdvanceRequest:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  AdvanceRequest.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

