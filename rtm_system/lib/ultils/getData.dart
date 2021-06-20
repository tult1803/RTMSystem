import 'package:flutter/material.dart';
import 'package:rtm_system/model/PostCreateRequestInvoice.dart';
import 'package:rtm_system/model/postAPI_createCustomer.dart';
import 'package:rtm_system/model/postAPI_createNotice.dart';
import 'package:rtm_system/model/putAPI_confirmInvoice.dart';
import 'package:rtm_system/model/putAPI_signInvoice.dart';
import 'package:rtm_system/model/putAPI_updatePrice.dart';
import 'package:rtm_system/model/putAPI_updateProfile.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
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

Future<void> getNotice(BuildContext context, String mainTittle, String content,
    int indexOfBottomBar) async {
  int status = await postAPINotice(mainTittle, content);
  if (status == 200) {
    showStatusAlertDialog(
        context,
        "Tạo thành công.",
        HomeAdminPage(
          index: indexOfBottomBar,
        ),
        true);
  } else
    showStatusAlertDialog(
        context, "Tạo thất bại. Xin thử lại !!!", null, false);
}

//dung cho tạo khách hàng, cap nhat khach hang
// ignore: non_constant_identifier_names
Future post_put_ApiProfile(
    String phone,
    String password,
    String fullname,
    int gender,
    String cmnd,
    String address,
    String birthday,
    bool isUpdate,
    int typeOfUpdate,
    String accountId) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (isUpdate) {
    PutUpdateProfile _putUpdate = PutUpdateProfile();
    status = await _putUpdate.updateProfile(
        prefs.get("access_token"),
        phone,
        typeOfUpdate,
        accountId,
        password,
        fullname,
        gender,
        cmnd,
        address,
        birthday);
  } else {
    PostCreateCustomer _createCustomer = PostCreateCustomer();
    status = await _createCustomer.createCustomer(prefs.get("access_token"),
        phone, password, fullname, gender, cmnd, address, birthday);
  }
  return status;
}

Future<void> doCreateCustomer(
    BuildContext context,
    String phone,
    String password,
    String fullname,
    int gender,
    String cmnd,
    String address,
    String birthday,
    bool isCustomer,
    bool isUpdate,
    int typeOfUpdate,
    String accountId,
    {bool isCreate}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status = await post_put_ApiProfile(phone, password, fullname, gender,
      cmnd, address, birthday, isUpdate, typeOfUpdate, accountId);
  if (status == 200) {
    if (isCustomer) {
      showStatusAlertDialog(
          context,
          "Đã cập nhật",
          HomeCustomerPage(
            index: 3,
          ),
          true);
    } else {
      if (isUpdate) {
        prefs.setString("fullname", fullname);
        prefs.setString("phone", phone);
        prefs.setInt("gender", gender);
        prefs.setString("birthday", birthday);
      } else
        prefs.setString("password", password);
      showStatusAlertDialog(
          context,
          "Đã cập nhật",
          isCreate == null
              ? HomeAdminPage(
                  index: 4,
                )
              : AllCustomer(),
          true);
    }
  } else
    showStatusAlertDialog(
        context, "Cập nhật thất bại. Xin thử lại !!!", null, false);
}

// ignore: non_constant_identifier_names
Future<void> put_API_PayAdvance(
  BuildContext context,
) async {
  int status = 200;
  if (status == 200) {
    showStatusAlertDialog(
        context,
        "Đã trả tiền thành công.",
        HomeCustomerPage(
          index: 0,
        ),
        true);
  } else
    showStatusAlertDialog(
        context, "Trả tiền thất bại. Xin thử lại !!!", null, false);
}

// ignore: non_constant_identifier_names
Future<void> put_API_GetMoney(BuildContext context, indexPage) async {
  int status = 200;
  //await post_put_ApiProfile();
  showAlertDialogAPI(
      context,
      'Nhan tien nha?',
      HomeCustomerPage(
        index: indexPage,
      ),
      status);
}

Future<void> putAPIUpdatePrice(BuildContext context, String productId,
    double price, String productName) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutUpdatePrice putUpdatePrice = PutUpdatePrice();
  status = await putUpdatePrice.updatePrice(
      prefs.get("access_token"), prefs.get("accountId"), productId, price);

  if (status == 200) {
    prefs.setString("$productName", "$price");
    showCustomDialog(context,
        isSuccess: true,
        content: "Giá sản phẩm đã cập nhật",
        widgetToNavigator: HomeAdminPage(
          index: 2,
        ));
  } else
    showCustomDialog(
      context,
      isSuccess: false,
      content: "Cập nhật giá thất bại",
    );
}

Future<void> doCreateRequestInvoiceOrInvoice(
    BuildContext context,
    int productId,
    String sell_date,
    int customerId,
    int quantity,
    int degree,
    int invoice_request_id,
    bool isCustomer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  if (isCustomer) {
    PostCreateRequestInvoice postCreateRequestInvoice =
        PostCreateRequestInvoice();
    status = await postCreateRequestInvoice.createRequestInvoice(
        prefs.get("access_token"), productId, sell_date);
  } else {
    //call api tao invoice cua manager
  }
  if (status == 200) {
    if (isCustomer) {
      showStatusAlertDialog(
          context,
          "Đã gửi yêu cầu bán hàng.",
          HomeCustomerPage(
            index: 1,
          ),
          true);
    } else {
      //chuyen trang và thong báo
    }
  } else
    showStatusAlertDialog(
        context, "Cập nhật thất bại. Xin thử lại!", null, false);
}

// Xac nhan hoa don, cho ca manager va customer
// Customer : truyền invoice_id để xác nhận
Future<void> doConfirmOrAcceptOrRejectInvoice(
    BuildContext context, String invoiceId, int type, bool isCustomer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  if (isCustomer) {
    // 1 is sign invoice, 2 is accept invoice, 3 is reject invoice
    if (type == 1) {
      PutSignInvoice putSignInvoiceInvoice = PutSignInvoice();
      status = await putSignInvoiceInvoice.putSignInvoice(
          prefs.get("access_token"), invoiceId);
    } else if (type == 2) {
      PutConfirmInvoice putConfirmInvoice = PutConfirmInvoice();
      status = await putConfirmInvoice.putConfirmInvoice(
          prefs.get("access_token"), invoiceId);
    } else if (type == 3) {
      //call api to reject
    }
  } else {
    //call api tao invoice cua manager
    switch (type) {
      case 1: break;
      case 2: break;
      case 3: break;
    }
  }

  //Code ở đây sai
  // if (status == 200) {
  //   if (isCustomer) {
  //     showStatusAlertDialog(
  //         context,
  //         "Xác nhận thành công.",
  //         HomeCustomerPage(
  //           index: 1,
  //         ),
  //         true);
  //   } else {
  //     //chuyen trang và thong báo
  //   }
  // } else
  //   showCustomDialog(context,
  //       content: "Có lỗi xảy ra. Xin thử lại", isSuccess: false);
  // showStatusAlertDialog(
  //     context, "Cập nhật thất bại. Xin thử lại!", null, false);
}
