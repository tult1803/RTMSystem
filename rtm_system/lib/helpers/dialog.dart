import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/model/delete/deleteAPI_deactivateNotice.dart';
import 'package:rtm_system/model/delete/deleteAPI_deactivateCustomer.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import 'component.dart';
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
            int status = isDeactivateNotice == null
                ? await deactivateCustomer.deactivateCustomer(
                    token, deactivateId)
                : await deactivateNotice.deactivateNotice(token, deactivateId);
            if (status == 200) {
              Navigator.of(context).pop();
              showCustomDialog(context,
                  isSuccess: true,
                  content:
                      "${isDeactivateNotice == null ? "Hủy kích hoạt thành công" : "Ẩn thông báo thành công"}",
                  widgetToNavigator: widget);
            } else {
              Navigator.of(context).pop();
              showCustomDialog(context,
                  isSuccess: false, content: "Có lỗi xảy ra. Thử lại");
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

Future showCupertinoAlertDialog(BuildContext context, String content) {
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
                  Navigator.of(context).pop();
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

//Đang thử nghiệm
//Nếu muốn sử dụng navigator.pop thì trạng thái " doNavigate " không được null phải true hoặc false
//isSuccess là thể hiện hành động đã thành công hay thất bại
Future<Dialog> showCustomDialog(BuildContext context,
    {bool isSuccess,
    String content,
    bool doPopNavigate,
    double fontSize,
    Widget widgetToNavigator}) {
  return showDialog(
      context: context,
      builder: (context) {
        var size = MediaQuery.of(context).size;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            child: Container(
              height: 280,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        isSuccess
                            ? "images/iconSmile.png"
                            : "images/iconSad.png",
                        height: 100,
                        width: 100,
                      )),
                  Expanded(
                      child: Container(
                    width: size.width,
                    color: isSuccess ? welcome_color : Colors.redAccent,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          isSuccess ? "Thành công" : "Thất bại",
                          style: GoogleFonts.roboto(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          content,
                          style: GoogleFonts.roboto(
                              fontSize: fontSize == null ? 20 : fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        miniContainer(
                          context: context,
                          marginTop: 20,
                          height: 40,
                          width: 150,
                          tittle: "Xác nhận",
                          colorContainer: Colors.white,
                          borderRadius: 10,
                          fontSize: 18,
                          doPopNavigate:
                              doPopNavigate == null ? false : doPopNavigate,
                          widget: widgetToNavigator == null
                              ? null
                              : widgetToNavigator,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ));
      });
}

Future showTextFieldDialog(BuildContext context, {bool isDegree, String id}) async {
  double quantity = 0, degree = 0;
  return await showDialog(
    context: context,
    builder: (context) {
      return new AlertDialog(
        contentPadding: const EdgeInsets.all(15.0),
        content: Container(
          height: !isDegree ? 80 : 140,
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
                  quantity = double.tryParse(value);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: !isDegree
                    ? null
                    : TextFormField(
                        autofocus: true,
                        cursorColor: welcome_color,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[.[0-9]')),
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
                          degree = double.tryParse(value1);
                        },
                      ),
              ),
            ],
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
                  // Navigator.pop(context);
                doUpdateInvoice(context,id: id, degree: degree, quantity: quantity);
              })
        ],
      );
    },
  );
}

