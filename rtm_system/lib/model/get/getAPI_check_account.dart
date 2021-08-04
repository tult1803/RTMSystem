import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class CheckAccount{
  checkAccount(String phone) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlCheckAccount/$phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    print("Status getApi Check Account:${response.statusCode}");
   return response.statusCode;
  }
}
