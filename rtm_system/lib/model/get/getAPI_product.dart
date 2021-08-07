import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetProduct {
  getProduct(BuildContext context, String token, String idProduct, {int limit, int type}) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlProduct', {
        "id": "$idProduct",
        "limit": "${limit == null ? "" : limit}",
        "type": "${type == null ? "" : type}"
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status getApi Product:${response.statusCode}");
    if (response.statusCode == 200) {
      List<dynamic> listProduct = json.decode(response.body);
      return listProduct;
    } else {
      checkTimeToken(context, response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}
