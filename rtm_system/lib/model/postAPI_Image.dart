import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:rtm_system/ultils/src/url_api.dart';

class ImageService{
  postCreateAdvance(token, userId, storeId, money, reason, receiveDate, File file) async {
    String fileName = file.path.split('/').last;
    String typeImage = file.path.split('.').last;
    String contentType = 'image/$typeImage';
    String fomatMoney = money.replaceAll(',','');
    int parseMoney = int.parse(fomatMoney);
    String image_url = '';
    Uint8List imageByte = file.readAsBytesSync();
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
          "image_url": image_url,
          "content": imageByte,
          "filename": fileName,
          "contentType": "$contentType"
        }),
    );
    print('Status ' + response.statusCode.toString());
    return response.statusCode;
  }
}