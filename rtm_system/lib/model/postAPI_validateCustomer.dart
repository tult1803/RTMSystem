import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class PostValidateCustomer{

  createValidateCustomer(String token,
      {File face, File cmndFront, File cmndBack}) async {
    Uint8List byteFront = cmndFront.readAsBytesSync();
    Uint8List byteBack = cmndBack.readAsBytesSync();
    Uint8List byteFace = face.readAsBytesSync();
    final response = await http.post(
      Uri.http('$urlMain', '$urlValidateCustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "cmnd1": byteFront,
        "cmnd2": byteBack,
        "avt" : byteFace,
      }),
    );
    print("Status postApi ValidateCustomer:${response.statusCode}");
    return response.statusCode;
  }

}
