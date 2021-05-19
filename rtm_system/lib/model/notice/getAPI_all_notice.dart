import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllNotice {
  static int status;

  Future<Notice> getNotices(String token) async {
    final response =  await http.get(Uri.parse('${url_notice}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      status = 200;
      return Notice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

}
