
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/ultils/src/url_api.dart';

class GetAPIAllStore {
  Future<Store> getStores(String token, int pageNum, int pageNo) async {
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
      throw Exception('Failed to load data');
    }
  }
}
