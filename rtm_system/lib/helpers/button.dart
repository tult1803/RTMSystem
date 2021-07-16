import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/detail_notice.dart';
import 'package:rtm_system/view/form_reason.dart';
import 'package:rtm_system/view/login_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialog.dart';
import '../ultils/get_data.dart';

Widget btnConfirmDetailInvoice(BuildContext context,
    {String customerId,
    String productId,
    String storeId,
    String quantity,
    String sellDate,
    String degree,
    String invoiceRequestId,
    bool isCustomer,
    Widget widgetToNavigator}) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 15),
    width: 200,
    height: 40,
    decoration: BoxDecoration(
      color: welcome_color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
        onPressed: () {
          doCreateInvoice(context,
              sellDate: sellDate,
              storeId: storeId,
              customerId: customerId,
              productId: productId,
              invoiceRequestId: invoiceRequestId,
              quantity: quantity,
              degree: degree,
              isCustomer: isCustomer,
              widgetToNavigator: widgetToNavigator);
        },
        child: Text(
          "Xác nhận",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        )),
  );
}

Widget btnDateTimeForCustomer(
    BuildContext context, String tittle, Icon icon, Widget widget) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      SizedBox(
        width: size.width * 0.35,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {},
          child: Text(
            '$tittle',
            style: TextStyle(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Color(0xFFcccccc), width: 1),
          ),
          elevation: 5,
        ),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(color: Colors.black, width: 0.5),
          ),
          height: size.height * 0.05,
          width: size.width * 0.35,
          child: widget),
    ],
  );
}

//Dùng cho trang notice để hiện thỉ các notice
//isCustomer: true is Customer. Used to hide the button  in page of manager.
Widget containerButton(BuildContext context, String id, String tittle,
    String content, String date, bool isCustomer) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black, // foreground
        textStyle: TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailOfNotice(
                    noticeId: id,
                    titleNotice: tittle,
                    contentNotice: content,
                    isCustomer: isCustomer,
                  )),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.93,
                child: AutoSizeText(
                  "$tittle",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            "$content",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            "${getDateTime(date)}",
            style: TextStyle(
              fontSize: 12,
              color: welcome_color,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 9,
          ),
          SizedBox(
            height: 0.5,
            child: Container(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}

//Hiện tại đang dùng cho trang "Profile"
Widget buttonProfile(BuildContext context, double left, double right,
    double top, double bottom, String tittle, Widget widget) {
  return Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    //Nếu dùng "GestureDetector" thì click sẽ không tạo ra hiệu ứng button
    //Nếu muốn tạo hiệu ứng button có thể dùng FlatButton hoặc RaiseButton
    child: GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget)),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  tittle,
                  style: TextStyle(color: Colors.black54),
                )),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black54,
                  size: 15,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.black45,
            height: 1,
          ),
        ],
      ),
    ),
  );
}
// design Notice bên customer, giống containerButton

// Dùng cho đăng xuất, xóa thông tin.
Widget btnLogout(context) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 10),
    width: size.width * 0.4,
    child: Center(
      child: TextButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage("images/exit.png"),
                  width: size.width * 0.06,
                  height: size.height * 0.03,
                ),
              ],
            ),
            Column(
              children: [
                AutoSizeText(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget btnConfirmAdvanceOfCustomer(context, id, int status) {
  var size = MediaQuery.of(context).size;
  if (status == 8) {
    return Center(
      child: SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            put_API_ConfirmAdvance(context, id);
          },
          child: AutoSizeText(
            'Xác nhận',
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
        ),
      ),
    );
  } else {
    return Container();
  }
}
//Widget này dùng cho các button "Tạo" hoặc "Hủy" vd: ở Trang Tạo thông báo
//bool action = flase khi nhấn nút "Hủy" và bằng true khi nhấn "Tạo"

Widget btnSubmitOrCancel(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    String mainTittle,
    String content,
    String txtError,
    bool action,
    int indexOfBottomBar,
    bool isCustomer,
    String messageShow,
    {Widget widgetToNavigator}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    // ignore: deprecated_member_use
    child: FlatButton(
        onPressed: () async {
          if (action) {
            if (mainTittle == "") {
              showStatusAlertDialog(context, txtError, null, false);
            } else {
              int status = await postAPINotice(mainTittle, content);
              if (status == 200) {
                showCustomDialog(context,
                    isSuccess: true,
                    content: "Tạo thành công",
                    doPopNavigate: true,
                    widgetToNavigator: widgetToNavigator);
              } else
                showCustomDialog(context,
                    isSuccess: false,
                    content: "Tạo thất bại. Xin thử lại",
                    doPopNavigate: true);
            }
          } else {
            if (isCustomer) {
              showAlertDialog(
                  context,
                  messageShow,
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ));
            } else {
              showAlertDialog(
                  context,
                  messageShow,
                  HomeAdminPage(
                    index: indexOfBottomBar,
                  ));
            }
          }
        },
        child: Center(
            child: Text(
          tittleButtonAlertDialog,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ))),
  );
}

Widget btnDeleteRequestPage(BuildContext context, double width, double height,
    Color color, String tittleButtonAlertDialog, bool isCustomer,
    {Widget widgetToNavigator,
    bool isInvoice,
    String reason,
    String id,
    bool isAdvanceBill}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    // ignore: deprecated_member_use
    child: FlatButton(
        onPressed: () async {
          tittleButtonAlertDialog == "Hủy"
              ? showAlertDialog(
                  context,
                  isAdvanceBill == null
                      ? "Bạn muốn hủy xoá ${isInvoice == true ? "yêu cầu" : "hoá đơn"}"
                      : "Bạn muốn hủy từ chối ứng tiền",
                  HomeAdminPage(
                    index: isAdvanceBill == null ? 1 : 2,
                  ))
              : showAlertDialog(
                  context,
                  isAdvanceBill == null
                      ? "Bạn muốn xoá ${isInvoice == true ? "yêu cầu" : "hoá đơn"}"
                      : "Bạn muốn từ chối ứng tiền",
                  HomeAdminPage(
                    index: isAdvanceBill == null ? 1 : 2,
                  ),
                  isInvoice: isInvoice,
                  reason: reason,
                  isCustomer: isCustomer,
                  isAdvanceBill: isAdvanceBill,
                  id: id,
                );
        },
        child: Center(
            child: Text(
          tittleButtonAlertDialog,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ))),
  );
}

// chấp nhận hoặc từ chối hóa đơn
Widget btnAcceptOrReject(BuildContext context, double width, Color color,
    String tittleButtonAlertDialog, bool action, int indexOfBottomBar) {
  return Container(
      child: SizedBox(
    width: width,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () async {
        if (action) {
          int status = 200;
          // await postAPINotice(mainTittle, content);
          // gọi api trả lại gì đó khi chấp nhận hoặc từ chối
          if (status == 200) {
            //chở lại trang all invoice
            if (tittleButtonAlertDialog == 'Từ chối') {
              showStatusAlertDialog(
                  context,
                  "Đã từ chối thông tin.",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ),
                  true);
            } else {
              showStatusAlertDialog(
                  context,
                  "Đã xác nhận thông tin.",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ),
                  true);
            }
          } else
            showStatusAlertDialog(context, "Xác nhận thất bại", null, false);
        } else {
          //chở lại trang all invoice
          showAlertDialog(
              context,
              "Từ chối xác nhận thông tin?",
              HomeCustomerPage(
                index: indexOfBottomBar,
              ));
        }
      },
      child: Center(
        child: Text(
          tittleButtonAlertDialog,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    ),
  ));
}

Widget btnProcessAdvanceBill(BuildContext context,
    {String idAdvanceBill, bool isCustomer, Widget widgetToNavigator}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Flexible(
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReasonToDelete(
                      invoiceId: idAdvanceBill,
                      isCustomer: isCustomer,
                      widgetToNavigator: widgetToNavigator,
                      isAdvanceBill: true,
                    )));
          },
          child: Text(
            "Từ chối",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      ),
      Flexible(
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xFF0BB791),
          onPressed: () {
            doProcessAdvanceBill(context, idAdvanceBill, 8,
                widgetToNavigator: HomeAdminPage(
                  index: 2,
                ));
          },
          child: Text(
            "Xác nhận",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      ),
    ],
  );
}

Widget btnProcessInvoice(context, int statusId, String id, bool isCustomer,
    {bool isRequest, Widget widgetToNavigator, bool isDegree,InvoiceRequestElement element}) {
  var size = MediaQuery.of(context).size;
  //show button để xử lý hoàn thành đơn
  //status = 0 là cho customer xoá hoá đơn gửi yêu cầu.
  //status = 5 là cho customer sign invoice
  // status = 1 là manager confirm
  // status = 4 là accept or delete invoice. Customer: only accept NOT Reject.
  List<String> invoiceIdToSign = [];
  invoiceIdToSign.add(id);
  if (statusId == 5 || statusId == 1) {
    if (statusId == 5 && isCustomer == true) {
      return SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            doConfirmOrAcceptOrRejectInvoice(context, "", invoiceIdToSign, 1, isCustomer);
          },
          child: Text(
            'Nhận tiền',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      );
    } else
      return Container();
  } else if (statusId == 4) {
    if (isCustomer) {
      return SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            doConfirmOrAcceptOrRejectInvoice(context, id, [], 2, isCustomer);
          },
          child: Text(
            'Chấp nhận',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReasonToDelete(
                          invoiceId: id,
                          isRequest: isRequest != null ? true : false,
                          isCustomer: isCustomer,
                          widgetToNavigator: widgetToNavigator,
                        )));
              },
              child: Text(
                '${isRequest != null ? "Từ chối" : "Xóa"}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
          ),
          Flexible(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Color(0xFF0BB791),
                    onPressed: () {
                      isRequest != null ? doConfirmOrAcceptOrRejectInvoice(
                          context, id,  [],2, isCustomer,
                          isRequest: isRequest,
                          element: element,
                          widgetToNavigator: widgetToNavigator)
                      : showTextFieldDialog(context, isDegree:isDegree, id: id);
                    },
                    child: Text(
                      '${isRequest != null ? "Tạo" : "Cập nhật"}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                  ),
                )
        ],
      );
    }
  } else {
    return Container();
  }
} //btn in detail advance return

Widget btnConfirmAdvanceReturn(
  BuildContext context, {
  String id,
}) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 12, bottom: 12),
    width: size.width * 0.5,
    height: size.height * 0.05,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Thông báo'),
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(showMessage('', MSG032)),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Không',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      doReceiveReturnCash(context,id: id);
                    },
                    child: Text(
                      'Có',
                      style: TextStyle(
                        color: welcome_color,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: AutoSizeText(
          "Nhận tiền hoàn trả",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        )),
  );
}

Widget showHiddenFloatBtn() {
  return Container(
    width: 1,
    height: 1,
    child: FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: () {},
    ),
  );
}
