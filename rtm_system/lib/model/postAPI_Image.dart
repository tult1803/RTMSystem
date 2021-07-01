import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:rtm_system/ultils/src/url_api.dart';

class ImageService{
  postCreateAdvance(token, userId, storeId, money, reason, receiveDate) async {
    String fomatMoney = money.replaceAll(',','');
    int parseMoney = int.parse(fomatMoney);
    final response = await http.post(
        Uri.http('$urlMain', '$urlCreateRequestAdvance'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "customer_id": userId,
          "store_id": storeId,
          "amount": parseMoney,
          "description": reason,
          "receive_date": receiveDate,
        }),
    );
    print('Status postCreateAdvance' + response.statusCode.toString());
    return response.statusCode;
  }
}