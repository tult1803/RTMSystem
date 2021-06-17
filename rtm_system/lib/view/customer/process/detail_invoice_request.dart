import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
class DetailInvoiceRequest extends StatefulWidget {
  final Map<String, dynamic> map;
  final bool isCustomer;
  DetailInvoiceRequest({this.map, this.isCustomer});
  @override
  _DetailInvoiceRequestState createState() => _DetailInvoiceRequestState();
}

class _DetailInvoiceRequestState extends State<DetailInvoiceRequest> {
  @override
  void initState() {
    print(widget.isCustomer);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: containerDetail(
          context,
          componentContainerInvoiceRequest(
              context,
              id: this.widget.map["id"],
              customerName: this.widget.map["customer_name"],
              customerPhone: this.widget.map["customer_phone"],
              createDate: this.widget.map["create_date"],
              productId: this.widget.map["product_id"],
              productName: this.widget.map["product_name"],
              price: "${this.widget.map["price"]}",
              statusId: this.widget.map["status_id"],
              customerId: this.widget.map["customer_id"],
              sellDate: this.widget.map["sell_date"],
              isCustomer: widget.isCustomer
          ),
        ),
      ),
    );
  }
}
