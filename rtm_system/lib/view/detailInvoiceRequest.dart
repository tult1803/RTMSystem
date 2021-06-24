import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailInvoiceRequest extends StatefulWidget {
  final Map<String, dynamic> map;
  final bool isCustomer;
  final isRequest;
  final Widget widgetToNavigator;

  DetailInvoiceRequest(
      {this.map, this.isCustomer, this.isRequest, this.widgetToNavigator});

  @override
  _DetailInvoiceRequestState createState() => _DetailInvoiceRequestState();
}

class _DetailInvoiceRequestState extends State<DetailInvoiceRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            id: "${this.widget.map["id"]}",
            storeName: this.widget.map["store_name"],
            customerName: this.widget.map["customer_name"],
            customerPhone: this.widget.map["customer_phone"],
            createDate: this.widget.map["create_date"],
            sellDate: this.widget.map["sell_date"],
            productName: this.widget.map["product_name"],
            price: "${this.widget.map["price"]}",
            map: this.widget.map,
            isCustomer: widget.isCustomer,
            isRequest: widget.isRequest,
            widgetToNavigator: this.widget.widgetToNavigator,
          ),
        ),
      ),
    );
  }
}
