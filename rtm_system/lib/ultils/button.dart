import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

Widget btnConfirmDetailInvoice(BuildContext context,
    {String customerId,
    String productId,
    String storeId,
    String quantity,
    String sellDate,
    String degree,
    String invoiceRequestId,
    bool isCustomer,
    Widget widgetToNavigator}) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 15),
    width: 200,
    height: 40,
    decoration: BoxDecoration(
      color: welcome_color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
        onPressed: () {
          doCreateInvoice(context,
              sellDate: sellDate,
              storeId: storeId,
              customerId: customerId,
              productId: productId,
              invoiceRequestId: invoiceRequestId,
              quantity: quantity,
              degree: degree,
              isCustomer: isCustomer,
              widgetToNavigator: widgetToNavigator);
        },
        child: Text(
          "Xác nhận",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        )),
  );
}

///Mình sẽ chuyển code của các button dần sang đây cho nó gọn vs dễ tìm ======
