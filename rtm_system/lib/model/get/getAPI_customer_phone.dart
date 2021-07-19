import 'dart:convert';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class GetAPIProfileCustomer{
  getProfileCustomer(String token, String phone) async {
    print(Uri.http('$urlMain', '$urlProfileCustomer/$phone'));
    final response = await http.get(
      Uri.http('$urlMain', '$urlProfileCustomer/$phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('Status getAPI DataCustomerFromPhone: ${response.statusCode}');
    if (response.statusCode == 200) {
      return InfomationCustomer.fromJson(jsonDecode(response.body));
    } else {
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

