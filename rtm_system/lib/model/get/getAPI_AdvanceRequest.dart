import 'dart:convert';
import 'package:rtm_system/model/model_advance_request.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAdvanceRequest{
  getAdvanceRequest(String token, String accountId, String phone, int statusId, int pageNum, int pageNo, String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlAdvanceRequest', { "customer_id" : "$accountId", "status_id" : "$statusId", "from" : "$from", "to" : "$to", "pageNum" : "$pageNum" ,"pageNo" : "$pageNo", "phone": "${searchTerm == null ? "" : searchTerm}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("Status getAPI AdvanceRequest:${response.statusCode}");
    if (response.statusCode == 200) {
      return  AdvanceRequest.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
