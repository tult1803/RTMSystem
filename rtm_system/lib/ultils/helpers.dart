import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

//Chuyển trạng thái từ số thành chữ
getStatus({int status}) {
  // 1,Active
  // 2,Inactive
  // 3,Done
  // 4,Processing
  // 5,Undone
  // 6,Cancel
  // 7,Expired
  // 8,Accept

  switch (status) {
    case 1:
      return "Hoạt động";
      break;
    case 2:
      return "Huỷ bỏ";
      break;
    case 3:
      return "Hoàn thành";
      break;
    case 4:
      return "Đang xử lý";
      break;
    case 5:
      return "Ký gửi";
      break;
    case 6:
      return "Từ chối";
      break;
    case 7:
      return "Hết hạn";
      break;
    case 8:
      return "Chấp nhận";
      break;
  }
}

getStatusUpdatePrice({String date}) {
  DateTime toDay = DateTime.now();
  return toDay
              .difference(
                  DateTime.parse(getDateTime(date, dateFormat: "yyyy-MM-dd")))
              .inDays ==
          0
      ? "Giá mới"
      : "Giá cũ";
}

getColorStatusUpdatePrice({String date}) {
  Color color = Colors.black54;
  DateTime toDay = DateTime.now();
   toDay
      .difference(
      DateTime.parse(getDateTime(date, dateFormat: "yyyy-MM-dd")))
      .inDays ==
      0
      ? color = Colors.green
      : color = Colors.redAccent;
  return color;
}

//Tạo màu cho trạng thái tương ứng với số
getColorStatus({int status}) {
  Color color = Colors.black54;
  if (status == 1) {
    color = Colors.green;
  } else if (status == 2) {
    color = Colors.redAccent;
  } else if (status == 4) {
    color = Colors.orangeAccent;
  } else if (status == 5) {
    color = colorHexa("#FF6F3D");
  } else if (status == 3) {
    color = primaryColor;
  } else if (status == 6) {
    color = Colors.redAccent;
  } else if (status == 8) {
    color = primaryColor;
  } else if (status == 7) {
    color = Colors.blueGrey;
  }

  return color;
}

//Chuyển giới tính từ số thành chữ
getGender(int gender) {
  switch (gender) {
    case 0:
      return "Nữ";
      break;
    case 1:
      return "Nam";
      break;
  }
}

//Kiểm tra trạng thái Vip
getVip(bool vip) {
  switch (vip) {
    case true:
      return "VIP";
      break;
    case false:
      return "Thường";
      break;
  }
}

//Tính tổng giá tiền
getPriceTotal(double price, double degree, double quantity) {
  if (degree != 0) {
    return price * degree * quantity;
  } else
    return price * quantity;
}

//Parse dateTime ra chuỗi String
//nếu ko truyền dateFormat thì mặc định sẽ là 'dd/MM/yyyy hh:mm'
getDateTime(String date, {String dateFormat}) {
  final fDay =
      new DateFormat(dateFormat == null ? 'dd/MM/yyyy HH:mm' : dateFormat);
  if (date != null) {
    return "${fDay.format(DateTime.parse(date))}";
  } else
    return "-----";
}

//Format giá 100.000.000
getFormatPrice(String price) {
  final oCcy = new NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse("${price}"));
}
