import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class DeleteInvoice{
  deleteInvoice(String token, String invoiceId ) async {
    final response = await http.delete(
      Uri.http('$urlMain', '$urlDeleteInvoice/$invoiceId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status deleteAPI  Invoice:${response.statusCode}");
    return response.statusCode;
  }

}
