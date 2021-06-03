import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetProduct{
  getProduct(String token, int idProduct) async {
    final response = await http.get(
      Uri.http('${url_main}', '${url_product}/$idProduct'),
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
      // return DataProduct.fromJson(json.decode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

