import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/model/putAPI_deactivateCustomer.dart';
import 'package:rtm_system/model/deleteAPI_deactivateNotice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import 'component.dart';

//show khi nhấn các nút "Hủy" hoặc "Tạo"
//Nếu muốn xóa thông báo thì truyền trạng thái vào isDeactivateNotice
showAlertDialog(BuildContext context, String tittle, Widget widget,
    {bool isDeactivate,
    String token,
    int deactivateId,
    bool isDeactivateNotice}) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color, bool checkCreate) {
    return FlatButton(
      child: Text(
        tittleA,
        style: TextStyle(color: color),
      ),
      onPressed: () async {
        if (checkCreate) {
          if (isDeactivate == true) {
            PutDeactivateCustomer deactivateCustomer = PutDeactivateCustomer();
            DeleteDeactivateNotice deactivateNotice = DeleteDeactivateNotice();
            int status = isDeactivateNotice == null
                ? await deactivateCustomer.deactivateCustomer(
                    token, deactivateId)
                : await deactivateNotice.deactivateNotice(token, deactivateId);
            if (status == 200) {
              Navigator.of(context).pop();
              showStatusAlertDialog(
                  context,
                  isDeactivateNotice == null
                      ? "Hủy kích hoạt thành công"
                      : "Ẩn thông báo thành công",
                  widget,
                  true);
            } else {
              Navigator.of(context).pop();
              showStatusAlertDialog(
                  context, "Có lỗi xảy ra. Xin thử lại", widget, false);
            }
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
                        Text(
                          content,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
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
                          doPopNavigate: doPopNavigate == null ? false : doPopNavigate,
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
