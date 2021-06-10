import 'package:flutter/material.dart';

//Chuyển trạng thái từ số thành chữ
getStatus({int status}) {
  switch (status) {
    case 1:
      return "Hoạt động";
      break;
    case 2:
      return "Không hoạt động";
      break;
    case 3:
      return  "Hoàn thành";
      break;
    case 4:
      return "Đang xử lý";
      break;
    case 5:
      return "Từ chối";
      break;
    case 6:
      return "Chấp nhận";
      break;
  }
}

//Tạo màu cho trạng thái tương ứng với số
getColorStatus({int status}) {
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
