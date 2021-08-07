import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetInvoiceRequest{
  static int statusInvoice;
  getInvoiceRequest(BuildContext context, String token, String accountId, String productId, int pageNum, int pageNo,String from, String to, {String searchTerm}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlInvoiceRequest', { "account_id" : "$accountId", "product_id": "$productId","pageNum" : "$pageNum" ,"pageNo" : "$pageNo", "from" : "$from", "to" : "$to", "phone": "${searchTerm == null ? "" : searchTerm}" }),
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
      checkTimeToken(context, response.statusCode);
      throw Exception('Failed to load data');
    }
  }

}

