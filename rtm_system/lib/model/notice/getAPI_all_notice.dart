import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllNotice {
  static int status;
  // ?pageNum=13&pageNo=1
  Future<Notice> getNotices(String token, int pageNum, int pageNo, {String searchTerm}) async {
    final response =  await http.get(
      //Link khi ra: 'http://3.137.137.156:5000/api/rtm/v1/notice/get-notice-list?pageNum=14&pageNo=1'
      // { "pageNum" : "14", "pageNo" : "1" } sẽ thay cho dấu ? và & khi parse
      // Nếu để nguyên link thì khi parse hệ thống sẽ parse ? thành %3F nên sẽ bị lỗi khi gọi API
        Uri.http('${url_main}', '${url_notice}', { "pageNum" : "${pageNum}", "pageNo" : "${pageNo}" }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print("Status getApi Notice:${response.statusCode}");
    if (response.statusCode == 200) {
      status = 200;
      return Notice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

}
