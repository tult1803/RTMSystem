import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/postAPI_login.dart';
DataLogin data;
Future LoginApi(String username, String password)async{
  int status;
  PostAPI getAPI = PostAPI();
  // Đỗ dữ liệu lấy từ api
  data = await getAPI.createLogin(
      username, password);
  status = await PostAPI.status;

}
