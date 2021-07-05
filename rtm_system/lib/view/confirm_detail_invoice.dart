import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';

class confirmDetailInvoice extends StatelessWidget {
  bool isCustomer;
  String customerName, phoneNumber, storeId;
  String storeName,productName, productId;
  String quantity, degree, customerId;
  String price, dateToPay, invoiceRequestId;
  Widget widgetToNavigator;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: componentDetailCreateInvoice(
            context,
            storeId: storeId,
            productId: productId,
            customerId: customerId,
            invoiceRequestId: invoiceRequestId,
            isCustomer: isCustomer,
            customerName: customerName,
            phoneNumber: phoneNumber,
            dateToPay: "$dateToPay",
            degree: "$degree",
            quantity: "$quantity",
            price: price,
            productName: productName,
            storeName: storeName,
            widgetToNavigator: widgetToNavigator,
      ),
        ),
    );
  }

  confirmDetailInvoice(
      {this.isCustomer,
      this.customerName,
      this.phoneNumber,
      this.storeId,
      this.storeName,
      this.productName,
      this.productId,
      this.quantity,
      this.degree,
      this.customerId,
      this.price,
      this.dateToPay,
      this.invoiceRequestId,
      this.widgetToNavigator});
}
