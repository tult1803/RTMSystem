import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/model/model_login.dart';
import 'package:rtm_system/presenter/postAPI_login.dart';

Future LoginApi(String username, String password)async{
  DataLogin data;
  int status;
  PostAPI getAPI = PostAPI();
  // Đỗ dữ liệu lấy từ api
  data = await getAPI.createLogin(
      username, password);
  status = await PostAPI.status;
  print("Token: ${data.access_token}");
}
