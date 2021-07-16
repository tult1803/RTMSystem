import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/ultils/src/message_list.dart';

import 'src/regExp.dart';

checkInputUpdateInvoice(BuildContext context,
    {bool isDegree, double quantity, double degree}) {
  if (isDegree) {
    if (quantity == 0 && degree == 0) {
      showCupertinoAlertDialog(context, showMessage("Khối lượng, số độ", MSG001));
      return false;
    } else if (quantity == 0) {
      showCupertinoAlertDialog(context, showMessage("Khối lượng", MSG001));
      return false;
    } else if (degree == 0) {
      showCupertinoAlertDialog(context, showMessage("Số độ", MSG001));
      return false;
    }
  } else {
    if (quantity == 0) {
      showCupertinoAlertDialog(context, showMessage("Khối lượng", MSG001));
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
            content: showMessage("", MSG035), isSuccess: false);
        return false;
      }
    } else {
      showCustomDialog(context, content: showMessage("Giá", MSG001), isSuccess: false);
      return false;
    }
  } else {
    showCustomDialog(context, content: showMessage("", MSG013), isSuccess: false);
    return false;
  }
}

checkPhoneNumber(String phone) {
  if (phone == null || phone == "") {
    return showMessage("Số điện thoại", MSG001);
  } else {
    if (!checkFormatPhone.hasMatch(phone) || phone.length > 11) {
      return showMessage("", MSG014);
    } else {
      return null;
    }
  }
}

checkFullName(BuildContext context, String name) {
  if (name == null || name == "") {
    return showMessage("Tên khách hàng", MSG001);
  }
  return null;
}

checkChooseProduct(BuildContext context, String product) {
  if (product == null) {
    showCustomDialog(context, content: showMessage("", MSG013), isSuccess: false);
  }
}

checkQuantity(double quantity) {
  if (quantity == 0) {
    return showMessage("Số ký", MSG001);
  }
  return null;
}

checkDegree(bool checkProduct, double degree) {
  print(degree);
  if (!checkProduct) {
    if (degree == 0) {
      return showMessage("Số độ", MSG001);
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
        return showMessage("Mật khẩu", MSG001);
        break;
      case 1:
        return showMessage("Mật khẩu mới", MSG001);
        break;
      case 2:
        return showMessage("Mật khẩu xác nhận", MSG001);
        break;
    }
  } else
    switch (type) {
      case 0:
        if (passwordCheck != password) {
          return showMessage("Mật khẩu", MSG020);
        } else
          return null;
        break;
      case 1:
        if (!checkFormatPassword.hasMatch(password)) {
          return showMessage("", MSG016);
        } else return null;
          break;
      case 2:
        if (password != passwordCheck) {
          return showMessage("", MSG021);
        } else return null;
        break;
    }
}
