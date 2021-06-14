import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;



class GetInvoice{
  static int statusInvoice;
  getInvoice(String token, int customer_id, int product_id, int status_id,int pageNum, int pageNo,String from, String to, {String searchTerm}) async {
    print(Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "product_id": "$product_id","status_id" : "$status_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "$from", "to" : "$to" }));
    final response = await http.get(
      Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "product_id": "$product_id","status_id" : "$status_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "$from", "to" : "$to" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print("Status getApi Invoice:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  Invoice.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

