import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdateProfile {
  updateProfile(
      String token,
      String fullName,
      int gender,
      String birthday) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdateAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "fullname": fullName,
        "gender": gender,
        "birthday": birthday,
      }),
    );

    print("Status putAPI Update Account:${response.statusCode}");
    return response.statusCode;
  }
}
