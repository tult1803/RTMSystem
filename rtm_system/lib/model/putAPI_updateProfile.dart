
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdateProfile{

  updateProfile(String token, String phone, int type, int account_id, String password, String fullname, int gender, String cmnd, String address, String birthday) async {
    final response = await http.put(
      Uri.http('${url_main}', '${url_updateProfile}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "type": type,
        "account_id": account_id,
        "password": password,
        "fullname": fullname,
        "gender": gender,
        "birthday": birthday,
        "phone": phone,
        "cmnd": cmnd,
        "address": address,
        "vip":false,
      }),
    );
    print("Status putAPI Update Profile:${response.statusCode}");
    print('$type - $account_id - $password - $fullname - $gender - $birthday - $phone - $cmnd - $address');
    return response.statusCode;
  }

}
