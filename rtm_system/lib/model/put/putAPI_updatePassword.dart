import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PutUpdatePassword {
  updatePassword(
      String token,
      String accountId,
      String password,
      String newPassword,
      String confirmPassword) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdatePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "account_id": accountId,
        "password": password,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      }),
    );

    print("Status putAPI Update Password:${response.statusCode}");
    return response.statusCode;
  }
}
