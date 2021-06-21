import 'dart:convert';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;



class GetInvoice{
  static int statusInvoice;
  getInvoice(String token, String customer_id, String product_id, int status_id,int pageNum, int pageNo,String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "product_id": "$product_id","status_id" : "$status_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "$from", "to" : "$to" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    statusInvoice = response.statusCode;
    print('Status GetAPI Invoice: $statusInvoice');
    if (response.statusCode == 200) {
      return  Invoice.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

