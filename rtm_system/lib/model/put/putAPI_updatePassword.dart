import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdatePassword {
  updatePassword(
      String token,
      String accountId,
      String password) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdatePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "account_id": accountId,
        "password": password,
      }),
    );

    print("Status putAPI Update Password:${response.statusCode}");
    return response.statusCode;
  }
}
