import 'package:flutter/material.dart';
import 'package:rtm_system/model/postAPI_createCustomer.dart';
import 'package:rtm_system/model/postAPI_createNotice.dart';
import 'package:rtm_system/model/putAPI_updateProfile.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
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



//dung cho tạo khách hàng, cap nhat khach hang
Future post_put_ApiProfile(String phone, String password, String fullname, int gender, String cmnd, String address, String birthday, bool isUpdate, int typeOfUpdate, int account_id) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(isUpdate){
    PutUpdateProfile _putUpdate = PutUpdateProfile();
    status = await _putUpdate.updateProfile(prefs.get("access_token"), phone, typeOfUpdate, account_id, password, fullname, gender, cmnd, address, birthday);
  }else{
    PostCreateCustomer _createCustomer = PostCreateCustomer();
    status = await _createCustomer.createCustomer(prefs.get("access_token"), phone, password, fullname, gender, cmnd, address, birthday);

  }
  return status;
}

Future<void> doCreateCustomer(BuildContext context,String phone, String password, String fullname, int gender, String cmnd, String address, String birthday, bool check, bool isUpdate, int typeOfUpdate, int account_id) async{
  int status = await post_put_ApiProfile(phone, password, fullname, gender, cmnd, address, birthday, isUpdate, typeOfUpdate, account_id);
  if(status == 200){
    if(check){
      showStatusAlertDialog(context, "Đã cập nhật.", HomeCustomerPage(index: 3,), true);
    }else {
      showStatusAlertDialog(context, "Đã cập nhật.", HomeAdminPage(index: 4,), true);
    }
  }else showStatusAlertDialog(context, "Cập nhật thất bại. Xin thử lại !!!", null, false);
}
