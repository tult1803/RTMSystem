
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllStore {
  static int status;
  Future<Store> getStores(String token, int pageNum, int pageNo) async {
    final response =  await http.get(
        Uri.http('${url_main}', '${url_store}', { "pageNum" : "${pageNum}", "pageNo" : "${pageNo}"}, ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      status = 200;
      return Store.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
