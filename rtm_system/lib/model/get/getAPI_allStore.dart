
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllStore {
  Future<Store> getStores(BuildContext context,String token, int pageNum, int pageNo) async {
    final response =  await http.get(
        Uri.http('$urlMain', '$urlStore', { "pageNum" : "$pageNum", "pageNo" : "$pageNo"}, ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print('Status getAPI AllStore: ${response.statusCode}');
    if (response.statusCode == 200) {
      return Store.fromJson(jsonDecode(response.body));
    } else {
      checkTimeToken(context, response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}
