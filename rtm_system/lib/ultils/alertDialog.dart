import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/putAPI_deactivateCustomer.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

//show khi nhấn các nút "Hủy" hoặc "Tạo"
showAlertDialog(BuildContext context, String tittle, Widget widget,
    {bool isDeactivate, String token, int accountId}) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color, bool checkCreate) {
    return FlatButton(
      child: Text(
        tittleA,
        style: TextStyle(color: color),
      ),
      onPressed: () async{
        if (checkCreate) {
          if (isDeactivate == true) {
            PutDeactivateCustomer deactivateCustomer = PutDeactivateCustomer();
            int status =await  deactivateCustomer.deactivateCustomer(token, accountId);
            if(status == 200){
              Navigator.of(context).pop();
              showStatusAlertDialog(context, "Hủy kích hoạt thành công", widget, true);
            }else{
              Navigator.of(context).pop();
              showStatusAlertDialog(context, "Có lỗi xảy ra. Xin thử lại", widget, false);
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
