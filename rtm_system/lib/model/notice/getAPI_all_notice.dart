import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_system/model/notice/model_all_notice.dart';

class GetAPIAllNotice {
  static int status;

  Future<Notice> getNotices(String token) async {
    final response =  await http.get(Uri.parse('http://3.137.137.156:5000/api/rtm/v1/notice/get-notice-list?pageNum=13&pageNo=1'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print("Status getApi Notice: ${response.statusCode}");
    if (response.statusCode == 200) {
      status = 200;
      return Notice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

}
