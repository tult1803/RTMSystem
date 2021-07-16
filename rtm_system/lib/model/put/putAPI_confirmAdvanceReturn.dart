import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutConfirmAdvanceReturn{
  putConfirmAdvanceReturn(String token, String id) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlReceiveReturnCash/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("putConfirmAdvanceReturn: ${response.statusCode}");
    return response.statusCode;
  }

}
