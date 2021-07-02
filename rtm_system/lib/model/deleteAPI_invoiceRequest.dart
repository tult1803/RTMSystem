import 'dart:convert';

import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class DeleteInvoiceReqeust{
  deleteInvoiceRequest(String token, String invoiceId ,{String reason}) async {
    final response = await http.delete(
      Uri.http('$urlMain', '$urlDeleteInvoiceRequest/$invoiceId', {"reason": reason}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print('');
    print("Status deleteAPI InvoiceRequest:${response.statusCode}");
    return response.statusCode;
  }

}
