import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

import 'model_AllCustomer.dart';



class GetCustomer{
  static int statusInvoice;
  createCustomer(String token, int accountId, int pageNum, int pageNo, {String searchTerm}) async {
    var fDate = new DateFormat('yyyy-MM-dd hh:mm:ss');
    final response = await http.get(
      Uri.http('${url_main}', '${url_customer}/${accountId}', {"pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", }),
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
