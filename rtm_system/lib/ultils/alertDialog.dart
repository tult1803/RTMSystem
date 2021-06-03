import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

//show khi nhấn các nút "Hủy" hoặc "Tạo"
showAlertDialog(BuildContext context, String tittle, Widget widget) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color, bool checkCreate){
    return FlatButton(
      child: Text(tittleA, style: TextStyle(color: color),),
      onPressed: () {
        if(checkCreate){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => widget),
                  (route) => false);
        }else{
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
showStatusAlertDialog(BuildContext context, String tittle, Widget widget, bool checkStatus) {
  // Tạo button trong AlertDialog
  Widget btnAlert(String tittleA, Color color){
    return FlatButton(
      child: Text(tittleA, style: TextStyle(color: color),),
      onPressed: () {
          if(checkStatus){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => widget),
                    (route) => false);
          }else{
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