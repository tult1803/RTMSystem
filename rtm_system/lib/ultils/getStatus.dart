
import 'package:flutter/material.dart';
//Chuyển trạng thái từ số thành chữ
getStatus({int status}) {
  String txtStatus = "";
  if (status == 1) {
    txtStatus = "Hoạt động";
  } else if (status == 2) {
    txtStatus = "Không hoạt động";
  } else if (status == 3) {
    txtStatus = "Hoàn thành";
  } else if (status == 4) {
    txtStatus = "Đang xử lý";
  } else if (status == 5) {
    txtStatus = "Từ chối";
  } else if (status == 6) {
    txtStatus = "Chấp nhận";
  }
  return txtStatus;
}

//Tạo màu cho trạng thái tương ứng với số
getColorStatus({int status}){
  Color color = Colors.black54;
  if (status == 1 || status == 3 || status == 6) {
    color = Colors.green;
  } else if (status == 2 || status == 5) {
    color = Colors.redAccent;
  } else if (status == 4) {
    color = Colors.orangeAccent;
  }
  return color;
}