import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rtm_system/model/delete/deleteAPI_deactivateAdvanceRequest.dart';
import 'package:rtm_system/model/delete/deleteAPI_invoice.dart';
import 'package:rtm_system/model/delete/deleteAPI_invoiceRequest.dart';
import 'package:rtm_system/model/get/getAPI_check_account.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/post/postAPI_forget_password.dart';
import 'package:rtm_system/model/get/getAPI_maintainCheck.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/model/post/postAPI_CreateRequestInvoice.dart';
import 'package:rtm_system/model/post/postAPI_Image.dart';
import 'package:rtm_system/model/post/postAPI_createCustomer.dart';
import 'package:rtm_system/model/post/postAPI_createInvoice.dart';
import 'package:rtm_system/model/post/postAPI_createNotice.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/post/postAPI_login.dart';
import 'package:rtm_system/model/post/postAPI_validateCustomer.dart';
import 'package:rtm_system/model/put/putAPI_UpdateProfile.dart';
import 'package:rtm_system/model/put/putAPI_confirmAdvanceRequest.dart';
import 'package:rtm_system/model/put/putAPI_confirmAdvanceReturn.dart';
import 'package:rtm_system/model/put/putAPI_returnAdvance.dart';
import 'package:rtm_system/model/put/putAPI_confirmInvoice.dart';
import 'package:rtm_system/model/put/putAPI_processAdvanceBill.dart';
import 'package:rtm_system/model/put/putAPI_signInvoice.dart';
import 'package:rtm_system/model/put/putAPI_updateInvoice.dart';
import 'package:rtm_system/model/put/putAPI_updatePassword.dart';
import 'package:rtm_system/model/put/putAPI_updatePrice.dart';
import 'package:rtm_system/model/put/putAPI_updateAccount.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/presenter/Manager/invoice/add_product_invoice.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/login/login_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/dialog.dart';
import 'check_data.dart';

Future doCheckMaintain() async {
  GetMaintainCheck maintainCheck = GetMaintainCheck();
  int status = await maintainCheck.getMaintainCheck();
  return status;
}

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
        showMessage("", MSG002),
        HomeAdminPage(
          index: indexOfBottomBar,
        ),
        true);
  } else
    showStatusAlertDialog(context, showMessage(MSG024, MSG027), null, false);
}

/// Hàm này chờ xử lý
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
    String accountId,
    isCustomer) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (isUpdate) {
    if (isCustomer) {
      PutUpdateProfileCustomer putUpdateProfile = PutUpdateProfileCustomer();
      status = await putUpdateProfile.updateProfileCustomer(
          prefs.get("access_token"),
          prefs.get("accountId"),
          cmnd,
          birthday,
          fullname,
          address,
          gender);
    } else {
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
    }
  } else {
    PostCreateCustomer _createCustomer = PostCreateCustomer();
    status = await _createCustomer.createCustomer(prefs.get("access_token"),
        phone, password, fullname, gender, cmnd, address, birthday);
  }
  return status;
}

Future<void> doUpdateInvoice(BuildContext context,
    {String id, double quantity, double degree}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutUpdateInvoice updateInvoice = PutUpdateInvoice();
  showEasyLoading(context, MSG052);
  int status = await updateInvoice.updateInvoice(
      prefs.get("access_token"), id, quantity, degree);
  if (status == 200) {
    showEasyLoadingSuccess(context, MSG003,
        widget: HomeAdminPage(index: 1, indexInsidePage: 1));
  } else {
    showEasyLoadingError(
      context,
      MSG025,
    );
  }
}

Future<void> doUpdatePassword(BuildContext context,
    {String accountId, String password, bool isCustomer}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutUpdatePassword putUpdatePassword = PutUpdatePassword();
  showEasyLoading(context, MSG052);
  int status = await putUpdatePassword.updatePassword(
      prefs.get("access_token"), accountId, password);
  if (status == 200) {
    prefs.setString("password", password);
    if (isCustomer) {
      showEasyLoadingSuccess(context, MSG003,
          widget: HomeCustomerPage(
            index: 3,
          ));
    } else {
      showEasyLoadingSuccess(context, MSG003,
          widget: HomeAdminPage(
            index: 4,
          ));
    }
  } else {
    showEasyLoadingError(
      context,
      MSG025,
    );
  }
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
    int typeOfUpdate,
    String accountId,
    {bool isCreate,
    bool isUpdate}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  showEasyLoading(context, MSG052);
  int status = await post_put_ApiProfile(phone, password, fullname, gender,
      cmnd, address, birthday, isUpdate, typeOfUpdate, accountId, isCustomer);
  if (status == 200) {
    if (isCustomer) {
      showEasyLoadingSuccess(context, MSG003,
          widget: HomeCustomerPage(
            index: 3,
          ));
    } else {
      if (isCreate == null) {
        if (fullname.trim().isNotEmpty) {
          prefs.setString("fullname", fullname);
          prefs.setString("phone", phone);
          prefs.setInt("gender", gender);
          prefs.setString("birthday", birthday);
        } else {
          prefs.setString("password", password);
        }
      }
      showEasyLoadingSuccess(context, MSG003,
          widget: isCreate == false ? HomeAdminPage(index: 4) : AllCustomer());
    }
  } else
    showEasyLoadingError(
      context,
      MSG025,
    );
}

// ignore: non_constant_identifier_names
Future<void> put_API_ConfirmAdvance(BuildContext context, id) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutConfirmAdvanceRequest putConfirmAdvanceRequest =
      PutConfirmAdvanceRequest();
  showEasyLoading(context, MSG052);
  status = await putConfirmAdvanceRequest.putConfirmAdvanceRequest(
      prefs.get("access_token"), id);
  status == 200
      ? showEasyLoadingSuccess(context, showMessage("", MSG012),
          widget: HomeCustomerPage(
            index: 1,
          ))
      : showEasyLoadingError(context, showMessage(MSG025, MSG027));
}

Future<void> putAPIUpdatePrice(BuildContext context, String productId,
    double price, String productName) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutUpdatePrice putUpdatePrice = PutUpdatePrice();
  showEasyLoading(context, MSG052);
  status = await putUpdatePrice.updatePrice(
      prefs.get("access_token"), prefs.get("accountId"), productId, price);

  if (status == 200) {
    prefs.setString("$productName", "$price");
    showEasyLoadingSuccess(context, showMessage("", MSG039),
        widget: HomeAdminPage(
          index: 0,
        ));
  } else
    showEasyLoadingError(context, showMessage("", MSG025));
}

// Xac nhan hoa don, cho ca manager va customer
// Customer : truyền invoice_id để xác nhận
Future<void> doConfirmOrAcceptOrRejectInvoice(BuildContext context,
    String invoiceId, List<String> invoiceIdSign, int type, bool isCustomer,
    {Widget widgetToNavigator,
    String reason,
    bool isRequest,
    InvoiceRequestElement element}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  if (isCustomer) {
    showEasyLoading(context, MSG052);
    // 1 is sign invoice, 2 is accept invoice, 3 is delete request
    if (type == 1) {
      PutSignInvoice putSignInvoiceInvoice = PutSignInvoice();
      status = await putSignInvoiceInvoice.putSignInvoice(
          prefs.get("access_token"), invoiceIdSign);
    } else if (type == 2) {
      PutConfirmInvoice putConfirmInvoice = PutConfirmInvoice();
      status = await putConfirmInvoice.putConfirmInvoice(
          prefs.get("access_token"), invoiceId);
    } else if (type == 3) {
      DeleteInvoiceRequest deleteInvoiceRequest = DeleteInvoiceRequest();
      status = await deleteInvoiceRequest.deleteInvoiceRequest(
          prefs.get('access_token'), invoiceId,
          reason: reason);
    }
    if (status == 200) {
      showEasyLoadingSuccess(context, showMessage("", MSG012),
          widget: HomeCustomerPage(
            index: 0,
          ));
    } else {
      showEasyLoadingError(context, showMessage(MSG025, MSG027),
          widget: HomeCustomerPage(
            index: 0,
          ));
    }
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
                      customerId: element.customerId,
                      invoiceRequestId: element.id,
                      phone: element.customerPhone,
                      fullName: element.customerName,
                      storeName: element.storeName,
                      productName: element.productName,
                      dateToPay: element.sellDate,
                      productId: element.productId,
                      savePrice: "${element.price}",
                      storeId: element.storeId,
                      isCustomer: false,
                      isChangeData: true,
                      widgetToNavigator: widgetToNavigator,
                    )))
            : print('Chấp nhận');
        break;
      case 3:
        doDeleteInvoice(context, invoiceId, isRequest,
            widgetToNavigator: widgetToNavigator, reason: reason);
        break;
    }
  }
}

//Tao advance request
Future<void> createRequestAdvance(BuildContext context, String accountId,
    String money, String reason, date, storeId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int status;
  showEasyLoading(context, MSG052);
  // 1 is create request advance, 2 is accept advance
  ImageService imageService = ImageService();
  status = await imageService.postCreateAdvance(
    prefs.get("access_token"),
    prefs.get("accountId"),
    storeId,
    money,
    reason,
    getDateTime(date, dateFormat: 'yyyy-MM-dd HH:mm:ss'),
  );
  status == 200
      ? showEasyLoadingSuccess(context, showMessage("", MSG002),
          widget: HomeCustomerPage(
            index: 1,
          ))
      : showEasyLoadingError(context, showMessage("", MSG024));
}

Future getDataCustomerFromPhone(String phone) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
    InfomationCustomer infomationCustomer = InfomationCustomer();
    EasyLoading.show(
      status: 'Đang xử lý...',
      maskType: EasyLoadingMaskType.black,
    );
    infomationCustomer = await getAPIProfileCustomer.getProfileCustomer(
        prefs.get('access_token'), phone);
    EasyLoading.showSuccess("Thành công");
    await Future.delayed(Duration(milliseconds: 1000));
    EasyLoading.dismiss();
    return infomationCustomer;
  } catch (_) {
    print('Customer infomation is empty !!!');
    EasyLoading.showError(showMessage("", MSG009));
    await Future.delayed(Duration(milliseconds: 1500));
    EasyLoading.dismiss();
  }
}

Future doDeleteInvoice(BuildContext context, String invoiceId, bool isRequest,
    {Widget widgetToNavigator, String reason}) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  showEasyLoading(context, MSG052);
  if (isRequest) {
    DeleteInvoiceRequest deleteInvoiceRequest = DeleteInvoiceRequest();
    status = await deleteInvoiceRequest.deleteInvoiceRequest(
        prefs.get('access_token'), invoiceId,
        reason: reason);
  } else {
    DeleteInvoice deleteInvoice = DeleteInvoice();
    status =
        await deleteInvoice.deleteInvoice(prefs.get('access_token'), invoiceId);
  }
  status == 200
      ? showEasyLoadingSuccess(context, showMessage("", MSG040),
          widget: widgetToNavigator)
      : showEasyLoadingError(context, showMessage("", MSG041));
}

Future doDeleteInvoiceRequest(BuildContext context, String invoiceId,
    {Widget widgetToNavigator, String reason}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DeleteInvoiceRequest deleteInvoiceRequest = DeleteInvoiceRequest();
  showEasyLoading(context, MSG052);
  int status = await deleteInvoiceRequest.deleteInvoiceRequest(
      prefs.get('access_token'), invoiceId,
      reason: reason);
  status == 200
      ? showEasyLoadingSuccess(context, showMessage("", MSG017),
          widget: widgetToNavigator)
      : showEasyLoadingError(context, showMessage(MSG030, MSG027));
}

Future doProcessAdvanceBill(
    BuildContext context, String invoiceId, int statusProcess,
    {Widget widgetToNavigator, String reason}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutProcessAdvanceBill processAdvanceBill = PutProcessAdvanceBill();
  showEasyLoading(context, MSG052);
  int status = await processAdvanceBill.putProcessAdvanceBill(
      prefs.get('access_token'),
      id: invoiceId,
      status: statusProcess,
      reason: reason);

  status == 200
      ? showEasyLoadingSuccess(
          context,
          statusProcess == 6
              ? "Đã từ chối ứng tiền"
              : "Xác nhận đơn thành công",
          widget: widgetToNavigator)
      : showEasyLoadingError(
          context,
          statusProcess == 6
              ? "Từ chối ứng tiền thất bại"
              : "Xác nhận đơn thất bại");
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
  showEasyLoading(context, MSG052);
  if (isCustomer) {
    PostCreateRequestInvoice createRequestInvoice = PostCreateRequestInvoice();
    status = await createRequestInvoice.createRequestInvoice(
        prefs.get("access_token"),
        productId,
        getDateTime(sellDate, dateFormat: "yyyy-MM-dd HH:mm:ss"),
        storeId);
  } else {
    PostCreateInvoice createInvoice = PostCreateInvoice();
    status = await createInvoice.createInvoice(prefs.get('access_token'),
        customerId, productId, storeId, quantity, degree, invoiceRequestId);
  }

  status == 200
      ? isCustomer
          ? showEasyLoadingSuccess(context, showMessage("", MSG002),
              widget: HomeCustomerPage(
                index: 0,
              ))
          : showEasyLoadingSuccess(context, showMessage("", MSG002),
              widget: widgetToNavigator)
      : showEasyLoadingError(context, showMessage("", MSG024));
}

Future<void> putReturnAdvance(BuildContext context, List<String> invoiceId,
    List<String> advanceId, int totalAdvance) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  showEasyLoading(context, MSG052);
  if (totalAdvance != 0) {
    PutReturnAdvance putReturnAdvance = PutReturnAdvance();
    status = await putReturnAdvance.putReturnAdvance(
        prefs.get("access_token"), invoiceId, advanceId);
    if (status == 200) {
      showEasyLoadingSuccess(context, showMessage("", MSG019),
          widget: HomeCustomerPage(index: 1));
    } else
      showEasyLoadingError(context, showMessage("", MSG025));
  } else {
    showEasyLoadingError(context, showMessage(MSG031, MSG027));
  }
}

Future<void> doUpgradeCustomer(BuildContext context,
    {File cmndFront, File cmndBack, List data}) async {
  int statusImage, statusData;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PostValidateCustomer validateCustomer = PostValidateCustomer();
  PutUpdateProfileCustomer updateData = PutUpdateProfileCustomer();
  try {
    showEasyLoading(context, MSG052);
    statusImage = await validateCustomer.createValidateCustomer(
      prefs.get("access_token"),
      cmndFront: cmndFront,
      cmndBack: cmndBack,
    );
    statusData = await updateData.updateProfileCustomer(
        prefs.get("access_token"),
        prefs.get("accountId"),
        data.elementAt(3),
        data.elementAt(2),
        data.elementAt(0),
        data.elementAt(4),
        data.elementAt(1));
    if (statusImage == 200 && statusData == 200) {
      showEasyLoadingSuccess(context, "Đã gửi",
          waitTime: 2, widget: HomeCustomerPage(index: 3));
    } else {
      showEasyLoadingError(context,
          "Gửi ${checkStatusUpgrade(statusImage, statusData)} thất bại",
          waitTime: 2);
    }
  } catch (_) {
    showEasyLoadingError(context, showMessage(MSG030, MSG027), waitTime: 2);
  }
  return true;
}

// Future doConfirmIdentifyCustomer(BuildContext context,
//     {String cmnd,
//     String birthday,
//     String fullName,
//     String address,
//     int gender}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   PutConfirmIdentifyCustomer confirmIdentifyCustomer =
//       PutConfirmIdentifyCustomer();
//   showEasyLoading(context, MSG052);
//   // showEasyLoading(context, MSG052);
//   // showEasyLoadingSuccess(context, showMessage("", MSG019),widget: HomeCustomerPage(index: 1));
//   // showEasyLoadingError(context, showMessage("", MSG025));
//   int status = await confirmIdentifyCustomer.updateCustomer(
//       prefs.get("access_token"),
//       gender: gender,
//       birthday: birthday,
//       address: address,
//       cmnd: cmnd,
//       fullName: fullName);
//
//   if (status == 200) {
//     showCustomDialog(context,
//         isSuccess: true,
//         content: "Xác minh thành công",
//         widgetToNavigator: HomeCustomerPage(
//           index: 3,
//         ));
//   } else {
//     showCustomDialog(context,
//         isSuccess: false, content: showMessage(MSG030, MSG027));
//   }
// }

//receive cash from advance return
Future doReceiveReturnCash(
  BuildContext context, {
  String id,
}) async {
  int status;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PutConfirmAdvanceReturn putConfirmAdvanceReturn = PutConfirmAdvanceReturn();
  showEasyLoading(context, MSG052);
  status = await putConfirmAdvanceReturn.putConfirmAdvanceReturn(
      prefs.get("access_token"), id);
  if (status == 200) {
    showEasyLoadingSuccess(context, showMessage("", MSG022),
        widget: HomeCustomerPage(index: 1));
  } else {
    showEasyLoadingError(context, showMessage(MSG030, MSG027));
  }
}

Future doDeleteAdvanceRequest(BuildContext context, String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DeleteAdvanceRequest deleteAdvanceRequest = DeleteAdvanceRequest();
  showEasyLoading(context, MSG052);
  int status = await deleteAdvanceRequest.deleteAdvanceRequest(
      prefs.get('access_token'), id);
  status == 200
      ? showEasyLoadingSuccess(context, showMessage("", MSG017),
          widget: HomeCustomerPage(index: 1))
      : showEasyLoadingError(context, showMessage(MSG030, MSG027));
}

Future doCheckAccount(BuildContext context,String phone) async{
  CheckAccount account = CheckAccount();
  showEasyLoading(context, "$MSG052");
  int status = await account.checkAccount(phone);
  if(status == 200){
    EasyLoading.dismiss();
    return true;
  }else{
    showEasyLoadingError(context, "$MSG009");
    return false;
  }
}

Future doForgotPassword(BuildContext context,String fbToken, String password,String confirmPassword) async{
  ChangeForgotPassword forgotPassword = ChangeForgotPassword();
  showEasyLoading(context, "$MSG052");
  int status = await forgotPassword.getPassword(fbToken, password, confirmPassword);
  if(status == 200){
    showEasyLoadingSuccess(context, "$MSG003", widget: LoginPage());
  }else{
    showEasyLoadingError(context, "$MSG025");
  }
}

Future doLoginOTP(BuildContext context,String phone, String firebaseToken) async {
  DataLogin data;
  PostLogin getAPI = PostLogin();
  showEasyLoading(context, "$MSG052");
  try {
    data = await getAPI.createLogin(phone,
        password: "", firebaseToken: firebaseToken);
    if (data != null) {
      savedInfoLogin(data.roleId, data.accountId, data.gender,
          data.accessToken, data.fullName, data.phone, data.birthday, "");
      if (data.roleId == 3) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeCustomerPage(
                  index: 0,
                )),
                (route) => false);
      } else if (data.roleId == 2) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeAdminPage(
                  index: 0,
                )),
                (route) => false);
        print('Status button: Done');
      }
    }else showEasyLoadingError(context, '$MSG030');
  } catch (_) {
    showEasyLoadingError(context, '$MSG027');
  }
}