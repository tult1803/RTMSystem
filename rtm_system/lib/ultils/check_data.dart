import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/dialog.dart';

import 'src/regExp.dart';

checkInputUpdateInvoice(BuildContext context,
    {bool isDegree, double quantity, double degree}) {
  if (isDegree) {
    if (quantity == 0 && degree == 0) {
      showCupertinoAlertDialog(context, "Chưa điền khối lượng, số độ");
      return false;
    } else if (quantity == 0) {
      showCupertinoAlertDialog(context, "Chưa điền khối lượng");
      return false;
    } else if (degree == 0) {
      showCupertinoAlertDialog(context, "Chưa điền số độ");
      return false;
    }
  } else {
    if (quantity == 0) {
      showCupertinoAlertDialog(context, "Chưa điền khối lượng");
      return false;
    }
  }
  return true;
}

checkUpdatePriceProduct(BuildContext context, {bool isClick, double price}) {
  if (isClick) {
    if (price != null) {
      if (price > 1000) {
        return true;
      } else {
        showCustomDialog(context,
            content: "Giá phải lớn hơn 1000đ", isSuccess: false);
        return false;
      }
    } else {
      showCustomDialog(context, content: "Giá đang trống", isSuccess: false);
      return false;
    }
  } else {
    showCustomDialog(context, content: "Hãy chọn sản phẩm", isSuccess: false);
    return false;
  }
}

checkPhoneNumber(String phone) {
  if (phone == null || phone == "") {
    return "Số điện thoại trống";
  } else {
    if (!checkFormatPhone.hasMatch(phone) || phone.length > 11) {
      return "Số điện thoại sai (10-11 só)";
    } else {
      return null;
    }
  }
}

checkFullName(BuildContext context, String name) {
  if (name == null || name == "") {
    return "Tên khách hàng trống";
  }
  return null;
}

checkChooseProduct(BuildContext context, String product) {
  if (product == null) {
    showCustomDialog(context, content: "Chưa chọn sản phẩm", isSuccess: false);
  }
}

checkQuantity(double quantity) {
  if (quantity == 0) {
    return "Số ký đang trống";
  }
  return null;
}

checkDegree(bool checkProduct, double degree) {
  print(degree);
  if (!checkProduct) {
    if (degree == 0) {
      return "Số độ trống";
    }
  }
  return null;
}

checkPassword(String password, int type, {String passwordCheck}) {
  ///type 0 : password
  ///type 1 : currentPassword
  ///type 2 : confirmPassword
  if (password == null || password == "") {
    switch (type) {
      case 0:
        return "Mật khẩu trống";
        break;
      case 1:
        return "Mật khẩu mới trống";
        break;
      case 2:
        return "Mật khẩu xác nhận trống";
        break;
    }
  } else
    switch (type) {
      case 0:
        if (passwordCheck != password) {
          return "Mật khẩu sai";
        } else
          return null;
        break;
      case 1:
        if (!checkFormatPassword.hasMatch(password)) {
          return "Mật khẩu ít nhất 6 kí tự (chữ và số)";
        } else return null;
          break;
      case 2:
        if (password != passwordCheck) {
          return "Mật khẩu xác nhận không khớp";
        } else return null;
        break;
    }
}
