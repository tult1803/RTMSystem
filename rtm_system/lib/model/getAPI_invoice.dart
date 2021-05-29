import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetInvoice{
  static int statusInvoice;
  createInvoice(String token, int customer_id, DateTime from, DateTime to) async {
    var fDate = new DateFormat('yyyy-MM-dd hh:mm:ss');
    final response = await http.get(
      Uri.http('${url_main}', '${url_invoice}', { "customer_id" : "$customer_id", "pageNum" : "100" ,"pageNo" : "1", "from" : "${fDate.format(from)}", "to" : "${fDate.format(to)}" }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print("Status getApi Invoice:${response.statusCode}");
    statusInvoice = response.statusCode;
        if (response.statusCode == 200) {
      List<dynamic> listInvoice = json.decode(response.body);
      return listInvoice;
      // return DataProduct.fromJson(json.decode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
