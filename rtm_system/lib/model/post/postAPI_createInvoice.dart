import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateInvoice{

  createInvoice(String token, String customerId, String productId, String storeId, String quantity, String degree, String invoiceRequestId) async {
    final response = await http.post(
      Uri.http('$urlMain', '$urlCreateInvoice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "customer_id": customerId,
        "product_id": productId,
        "store_id": storeId,
        "quantity": double.tryParse(quantity),
        "degree": double.tryParse(degree),
        "invoice_request_id": invoiceRequestId
      }),
    );
    print("Status postApi CreateInvoice:${response.statusCode}");
    return response.statusCode;
  }

}
