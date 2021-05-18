import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllNotice {
  static int status;

  Future<Notice> getNotices(int num, int no) async {
    final response = await http.get(
      Uri.http('${url_main}', '${url_notice}'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // status = 200;
      return Notice.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
