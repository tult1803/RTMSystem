import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;



class GetInvoiceRequest{
  static int statusInvoice;
  getInvoiceRequest(String token, int account_id, int product_id, int pageNum, int pageNo,DateTime from, DateTime to, {String searchTerm}) async {
    var fDate = new DateFormat('yyyy-MM-dd hh:mm:ss');
    final response = await http.get(
      Uri.http('${url_main}', '${url_invoice_request}', { "account_id" : "$account_id", "product_id": "$product_id","pageNum" : "${pageNum}" ,"pageNo" : "${pageNo}", "from" : "${fDate.format(from)}", "to" : "${fDate.format(to)}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print("Status getInvoiceRequest:${response.statusCode}");
    statusInvoice = response.statusCode;
    if (response.statusCode == 200) {
      return  Invoice.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

