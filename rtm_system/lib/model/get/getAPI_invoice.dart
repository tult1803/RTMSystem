import 'dart:convert';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;



class GetInvoice{
  getInvoice(String token, String customerId, String productId, int statusId,int pageNum, int pageNo,String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlInvoice', { "customer_id" : "$customerId", "product_id": "$productId","status_id" : "$statusId","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "$from", "to" : "$to", "customer_phone": searchTerm}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print('Status GetAPI Invoice: ${response.statusCode}');
    if (response.statusCode == 200) {
      return  Invoice.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

