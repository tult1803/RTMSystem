import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdateProfile {
  updateProfile(
      String token,
      String phone,
      int type,
      String accountId,
      String password,
      String fullName,
      int gender,
      String cmnd,
      String address,
      String birthday) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdateAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "type": type,
        "account_id": accountId,
        "password": password,
        "fullname": fullName,
        "gender": gender,
        "birthday": birthday,
        "phone": phone,
        "cmnd": "$cmnd",
        "vip": false,
        "address": "$address",
      }),
    );

    print("Status putAPI Update Profile:${response.statusCode}");
    return response.statusCode;
  }
}
