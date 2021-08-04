import 'dart:convert';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:rtm_system/view/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAPIProfileCustomer{
  getProfileCustomer(BuildContext context,String token, String phone) async {
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
      if (response.statusCode == 403) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        showCupertinoAlertDialog(context, showMessage("", MSG059), widget: LoginPage(), isPush: true);
      }
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

}

