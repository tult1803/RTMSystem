import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rtm_system/model/delete/deleteAPI_deactivateNotice.dart';
import 'package:rtm_system/model/delete/deleteAPI_deactivateCustomer.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import '../ultils/get_api_data.dart';

//show khi nhấn các nút "Hủy" hoặc "Tạo"
//Nếu muốn xóa thông báo thì truyền trạng thái vào isDeactivateNotice
showAlertDialog(
  BuildContext context,
  String tittle,
  Widget widget, {
  bool isDeactivate,
  bool isInvoice,
  bool isCustomer,
  String token,
  String reason,
  String deactivateId,
  bool isDeactivateNotice,
  bool isAdvanceBill,
  String id,
}) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color, bool checkCreate) {
    // ignore: deprecated_member_use
    return FlatButton(
      child: Text(
        tittleA,
        style: TextStyle(color: color),
      ),
      onPressed: () async {
        if (checkCreate) {
          if (isDeactivate == true) {
            DeleteDeactivateCustomer deactivateCustomer =
                DeleteDeactivateCustomer();
            DeleteDeactivateNotice deactivateNotice = DeleteDeactivateNotice();
            showEasyLoading(context, MSG052);
            int status = isDeactivateNotice == null
                ? await deactivateCustomer.deactivateCustomer(
                    token, deactivateId)
                : await deactivateNotice.deactivateNotice(token, deactivateId);
            if (status == 200) {
              Navigator.of(context).pop();
              showEasyLoadingSuccess(
                  context, "${isDeactivateNotice == null ? MSG053 : MSG054}",
                  widget: widget);
            } else {
              Navigator.of(context).pop();
              showEasyLoadingError(context, MSG027);
            }
          } else if (isInvoice != null) {
            doConfirmOrAcceptOrRejectInvoice(context, id, [], 3, isCustomer,
                widgetToNavigator: widget,
                isRequest: isInvoice,
                reason: reason);
          } else if (isAdvanceBill != null) {
            doProcessAdvanceBill(context, id, 6,
                widgetToNavigator: widget, reason: reason);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => widget),
                (route) => false);
          }
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thông báo"),
    content: Text(tittle),
    actions: [
      btnAlert("Không", Colors.redAccent, false),
      btnAlert("Có", welcome_color, true),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Báo trạng thái sau khi thực hiện hành động
showStatusAlertDialog(
    BuildContext context, String tittle, Widget widget, bool checkStatus) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color) {
    return FlatButton(
      child: Text(
        tittleA,
        style: TextStyle(color: color),
      ),
      onPressed: () {
        if (checkStatus) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => widget),
              (route) => false);
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thông báo"),
    content: Text(tittle),
    actions: [
      btnAlert("Xác nhận", welcome_color),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future showCupertinoAlertDialog(BuildContext context, String content,
    {bool isPush, Widget widget}) {
  return showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
            title: new Text("Thông báo"),
            content: new Text(content),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Đóng',
                  style: TextStyle(color: welcome_color),
                ),
                onPressed: () {
                  isPush == null
                      ? Navigator.of(context).pop()
                      : Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => widget),
                          (route) => false);
                },
              )
            ],
          ));
}

//dung cho api getMoney
showAlertDialogAPI(BuildContext context, String tittle, Widget widget, status) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color, bool checkCreate) {
    // ignore: deprecated_member_use
    return FlatButton(
      child: Text(
        tittleA,
        style: TextStyle(color: color),
      ),
      onPressed: () {
        if (checkCreate) {
          if (status == 200) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => widget),
                (route) => false);
          } else {
            Navigator.of(context).pop();
          }
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thông báo"),
    content: Text(tittle),
    actions: [
      btnAlert("Không", Colors.redAccent, false),
      btnAlert("Có", Color(0xFF0BB791), true),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future showTextFieldDialog(BuildContext context,
    {bool isDegree, String id}) async {
  String quantity = "", degree = "";
  return await showDialog(
    context: context,
    builder: (context) {
      return new AlertDialog(
        contentPadding: const EdgeInsets.all(15.0),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new TextFormField(
                  autofocus: true,
                  cursorColor: welcome_color,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[.[0-9]')),
                  ],
                  maxLength: 6,
                  decoration: new InputDecoration(
                      labelText: 'Khối lượng',
                      labelStyle: TextStyle(color: Colors.black54),
                      hintText: 'Nhập khối lượng',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0BB791),
                        ),
                      )),
                  onChanged: (value) {
                      quantity = value.trim();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: !isDegree
                      ? null
                      : TextFormField(
                          autofocus: true,
                          maxLength: 6,
                          cursorColor: welcome_color,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[.[0-9]')),
                          ],
                          decoration: new InputDecoration(
                              labelText: 'Số độ',
                              labelStyle: TextStyle(color: Colors.black54),
                              hintText: 'Nhập số độ',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0BB791),
                                ),
                              )),
                          onChanged: (value1) {
                            degree = value1.trim();
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          new FlatButton(
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // ignore: deprecated_member_use
          new FlatButton(
              child: const Text(
                'Xác nhận',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                bool check = await checkInputUpdateInvoice(context,
                    isDegree: isDegree, quantity: quantity, degree: degree);
                if (!check) {
                  print('sai');
                } else
                  doUpdateInvoice(context,
                      id: id, degree: degree.isEmpty ? 0 : double.parse(degree), quantity: double.parse(quantity));
              })
        ],
      );
    },
  );
}

showEasyLoadingSuccess(BuildContext context, String status,
    {int waitTime, Widget widget}) {
  EasyLoading.showSuccess(status,
      maskType: EasyLoadingMaskType.black,
      duration: Duration(seconds: waitTime == null ? 1 : waitTime));
  if (widget != null)
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
}

showEasyLoadingError(BuildContext context, String status,
    {int waitTime, Widget widget}) {
  EasyLoading.showError(status,
      maskType: EasyLoadingMaskType.black,
      duration: Duration(seconds: waitTime == null ? 1 : waitTime));
  if (widget != null)
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
}

showEasyLoading(BuildContext context, String status) {
  EasyLoading.show(
    status: status,
    maskType: EasyLoadingMaskType.black,
  );
}
