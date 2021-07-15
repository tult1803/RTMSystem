import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/dialog.dart';

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
