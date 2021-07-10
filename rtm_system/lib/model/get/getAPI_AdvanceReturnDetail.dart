import 'dart:convert';
import 'package:rtm_system/model/model_advance_return_detail.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAdvanceReturnDetail{
  static int statusInvoice;
  getAdvanceReturnDetail(String token, String id) async {
    final response = await http.get(
    Uri.http('$urlMain', '$urlAdvanceReturnDetail/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getAdvanceReturnDetail: ${response.statusCode}");
    statusInvoice = response.statusCode;
    if (statusInvoice == 200) {
      return  AdvanceReturnDetail.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

