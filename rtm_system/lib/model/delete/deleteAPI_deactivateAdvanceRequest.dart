import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class DeleteAdvanceRequest{
  deleteAdvanceRequest(String token, String id) async {
    final response = await http.delete(
      Uri.http('$urlMain', '$urlDeleteAdvanceRequest/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status deleteAdvanceRequest:${response.statusCode}");
    return response.statusCode;
  }

}
