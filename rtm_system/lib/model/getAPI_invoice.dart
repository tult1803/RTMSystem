import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;



class GetInvoice{
  static int statusInvoice;
  createInvoice(String token, int customer_id, int product_id,int pageNum, int pageNo,DateTime from, DateTime to, {String searchTerm}) async {
    var fDate = new DateFormat('yyyy-MM-dd hh:mm:ss');
    final response = await http.get(
      Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "product_id": "$product_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "${fDate.format(from)}", "to" : "${fDate.format(to)}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print("Status getApi Invoice:${response.statusCode}");

    statusInvoice = response.statusCode;
    print(Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "product_id": "$product_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}"}));
    if (response.statusCode == 200) {
      return  Invoice.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

