import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/PostCreateRequestInvoice.dart';
import 'package:rtm_system/model/deleteAPI_invoice.dart';
import 'package:rtm_system/model/postAPI_Image.dart';
import 'package:rtm_system/model/postAPI_createCustomer.dart';
import 'package:rtm_system/model/postAPI_createInvoice.dart';
import 'package:rtm_system/model/postAPI_createNotice.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/model/putAPI_ConfirmAdvanceRequest.dart';
import 'package:rtm_system/model/putAPI_ReturnAdvance.dart';
import 'package:rtm_system/model/putAPI_confirmInvoice.dart';
import 'package:rtm_system/model/putAPI_signInvoice.dart';
import 'package:rtm_system/model/putAPI_updatePrice.dart';
import 'package:rtm_system/model/putAPI_updateProfile.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';
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

Future<void> put_API_ConfirmAdvance(
    BuildContext context, id
    ) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutConfirmAdvanceRequest putConfirmAdvanceRequest = PutConfirmAdvanceRequest();
  status = await putConfirmAdvanceRequest.putConfirmAdvanceRequest(
      prefs.get("access_token"), id);
  if (status == 200) {
    showStatusAlertDialog(
        context,
        showMessage('', MSG012),
        HomeCustomerPage(
          index: 1,
        ),
        true);
  } else
    showStatusAlertDialog(
        context, showMessage(MSG025, MSG027), null, false);
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
          index: 0,
        ));
  } else
    showCustomDialog(
      context,
      isSuccess: false,
      content: "Cập nhật giá thất bại",
    );
}

// Xac nhan hoa don, cho ca manager va customer
// Customer : truyền invoice_id để xác nhận
Future<void> doConfirmOrAcceptOrRejectInvoice(
    BuildContext context, String invoiceId, int type, bool isCustomer,
    {Widget widgetToNavigator,
    bool isRequest,
    Map<String, dynamic> map}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  if (isCustomer) {
    // 1 is sign invoice, 2 is accept invoice
    if (type == 1) {
      PutSignInvoice putSignInvoiceInvoice = PutSignInvoice();
      status = await putSignInvoiceInvoice.putSignInvoice(
          prefs.get("access_token"), invoiceId);
    } else if (type == 2) {
      PutConfirmInvoice putConfirmInvoice = PutConfirmInvoice();
      status = await putConfirmInvoice.putConfirmInvoice(
          prefs.get("access_token"), invoiceId);
    }
    if (status == 200) {
      showStatusAlertDialog(
          context,
          showMessage("", MSG012),
          HomeCustomerPage(
            index: 0,
          ),
          true);
    } else {
      showStatusAlertDialog(
          context,
          showMessage("", MSG012),
          HomeCustomerPage(
            index: 1,
          ),
          true);
    }

    ///Bị lỗi thiếu hàm
    // else {
    //   showStatusAlertDialog(context, showMessage(MSG025, MSG027), null, false);
    // }
  } else {
    //call api tao invoice cua manager
    switch (type) {
      case 1:
        print('Xác nhận');
        break;
      case 2:
        isRequest == true
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddProductPage(
                      tittle: "Tạo hoá đơn yêu cầu",
                      customerId: map["customer_id"],
                      invoiceRequestId: map["id"],
                      phone: map["customer_phone"],
                      fullName: map["customer_name"],
                      storeName: map["store_name"],
                      productName: map["product_name"],
                      dateToPay: map["sell_date"],
                      productId: map["product_id"],
                      savePrice: "${map["price"]}",
                      storeId: map["store_id"],
                      isCustomer: false,
                      isChangeData: true,
                      widgetToNavigator: widgetToNavigator,
                    )))
            : print('Chấp nhận');
        break;
      case 3:
        doDeleteInvoice(context, invoiceId,
            widgetToNavigator: widgetToNavigator);
        break;
    }
  }
}

//Tao advance request
Future<void> doCreateRequestAdvance(BuildContext context, String accountId,
    String money,String reason, date, image, storeId, int type, bool isCustomer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status ;
  if (isCustomer) {
    // 1 is create request advance, 2 is accept advance
    if (type == 1) {
      ImageService imageService = ImageService();
       status = await imageService.postCreateAdvance(
          prefs.get("access_token"), prefs.get("accountId"), storeId ,money, reason, getDateTime(date, dateFormat: 'yyyy-MM-dd HH:mm:ss'), image);
    } else if (type == 2) {
      //Call API
    }
    if (status == 200) {
      showStatusAlertDialog(
          context,
          showMessage("", MSG012),
          HomeCustomerPage(
            index: 1,
          ),
          true);
    } else {
      showStatusAlertDialog(context, showMessage(MSG025, MSG027), null, false);
    }
  } else {
    //call api tao invoice cua manager
    switch (type) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}

Future getDataCustomerFromPhone(String phone) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
    return await getAPIProfileCustomer.getProfileCustomer(
        prefs.get('access_token'), phone);
  } catch (_) {
    print('Customer infomation is empty !!!');
  }
}

Future doDeleteInvoice(BuildContext context, String invoiceId,
    {Widget widgetToNavigator}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DeleteInvoice deleteInvoice = DeleteInvoice();
  int status =
      await deleteInvoice.deleteInvoice(prefs.get('access_token'), invoiceId);
  status == 200
      ? showCustomDialog(context,
          isSuccess: true,
          content: "Đã từ chối hoá đơn",
          widgetToNavigator: widgetToNavigator)
      : showCustomDialog(context,
          isSuccess: false,
          content: "Từ chối hoá đơn thất bại",
          doPopNavigate: true);
}

///Dùng để tạo hoá đơn và tạo yêu cầu giữ giá ( Request Invoice )
Future doCreateInvoice(BuildContext context,
    {String customerId,
    String productId,
    String storeId,
    String sellDate,
    String quantity,
    String degree,
    String invoiceRequestId,
    bool isCustomer,
    Widget widgetToNavigator}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  if (isCustomer) {
    PostCreateRequestInvoice createRequestInvoice = PostCreateRequestInvoice();
    status = await createRequestInvoice.createRequestInvoice(
        prefs.get("access_token"), productId, getDateTime(sellDate, dateFormat: "yyyy-MM-dd HH:mm:ss"), storeId);
  } else {
    PostCreateInvoice createInvoice = PostCreateInvoice();
    status = await createInvoice.createInvoice(prefs.get('access_token'),
        customerId, productId, storeId, quantity, degree, invoiceRequestId);
  }

  status == 200
      ? isCustomer
          ? showCustomDialog(context,
              isSuccess: true,
              content: "Đã gửi yêu cầu bán hàng",
              widgetToNavigator: HomeCustomerPage(
                index: 0,
              ))
          : showCustomDialog(context,
              isSuccess: true,
              content: "Tạo hoá đơn thành công",
              widgetToNavigator: widgetToNavigator)
      : showCustomDialog(context,
          isSuccess: false,
          content: "Tạo hoá đơn thất bại",
          doPopNavigate: true);
}
Future<void> putReturnAdvance(BuildContext context, List<String> invoiceId) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutReturnAdvance putReturnAdvance = PutReturnAdvance();
  status = await putReturnAdvance.putReturnAdvance(
      prefs.get("access_token"), invoiceId);
  if (status == 200) {
    showStatusAlertDialog(
        context,
        showMessage("", MSG019),
        HomeCustomerPage(
          index: 1,
        ),
        true);
  } else
    showCustomDialog(
      context,
      isSuccess: false,
      content: showMessage("", MSG025),
    );
}