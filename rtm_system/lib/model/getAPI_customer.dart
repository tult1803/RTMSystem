import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

import 'model_AllCustomer.dart';



class GetCustomer{
  static int statusInvoice;
  createCustomer(String token, int type, String accountId, int pageNum, int pageNo, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlCustomer/$type', { "accountId":"$accountId", "pageNum" : "$pageNum" ,"pageNo" : "$pageNo", "name": searchTerm }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getApi Invoice:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  Customer.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
