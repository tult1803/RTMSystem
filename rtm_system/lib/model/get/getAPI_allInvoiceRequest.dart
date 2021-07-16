import 'dart:convert';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetInvoiceRequest{
  static int statusInvoice;
  getInvoiceRequest(String token, String account_id, String product_id, int pageNum, int pageNo,String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlInvoiceRequest', { "account_id" : "$account_id", "product_id": "$product_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "$from", "to" : "$to", "phone": "${searchTerm == null ? "" : searchTerm}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getInvoiceRequest:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  InvoiceRequest.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

