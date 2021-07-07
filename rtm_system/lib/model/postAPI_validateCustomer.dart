import 'dart:convert';
import 'dart:io';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PostValidateCustomer {
  createValidateCustomer(String token,
      {File face, File cmndFront, File cmndBack}) async {
    final byteFace = face.readAsBytesSync();
    final bytecmndFront = cmndFront.readAsBytesSync();
    final bytecmndBack = cmndBack.readAsBytesSync();
    final response = await http.post(
      Uri.http('$urlMain', '$urlValidateCustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "cmnd1": bytecmndFront,
        "cmnd2": bytecmndBack,
        "avt": byteFace,
      }),
    );
    print(byteFace);
    print("Status postApi ValidateCustomer:${response.statusCode}");
    return response.statusCode;
  }
}
