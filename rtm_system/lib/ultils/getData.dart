import 'package:flutter/material.dart';
import 'package:rtm_system/model/postAPI_createCustomer.dart';
import 'package:rtm_system/model/postAPI_createNotice.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertDialog.dart';
//dùng cho tạo thông báo
Future postAPINotice(String tittle, String content) async {
  PostCreateNotice _createNotice = PostCreateNotice();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status = await _createNotice.createNotice(
      tittle, content, prefs.get("accountId"), prefs.get("access_token"));
  return status;
}

Future<void> getNotice(BuildContext context,String mainTittle, String content, int indexOfBottomBar) async{
  int status = await postAPINotice(mainTittle, content);
  if(status == 200){
    showStatusAlertDialog(context, "Tạo thành công.", HomeAdminPage(index: indexOfBottomBar,), true);
  }else showStatusAlertDialog(context, "Tạo thất bại. Xin thử lại !!!", null, false);
}



//dung cho tạo khách hàng
Future postAPICreateCustomer(String phone, String password, String fullname, int gender, String cmnd, String address, String birthday) async {
  PostCreateCustomer _createCustomer = PostCreateCustomer();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status = await _createCustomer.createNotice(prefs.get("access_token"), phone, password, fullname, gender, cmnd, address, birthday);
  return status;
}

Future<void> doCreateCustomer(BuildContext context,String phone, String password, String fullname, int gender, String cmnd, String address, String birthday, int indexOfBottomBar) async{
  int status = await postAPICreateCustomer(phone, password, fullname, gender, cmnd, address, birthday);
  if(status == 200){
    showStatusAlertDialog(context, "Tạo thành công.", HomeAdminPage(index: indexOfBottomBar,), true);
  }else showStatusAlertDialog(context, "Tạo thất bại. Xin thử lại !!!", null, false);
}
