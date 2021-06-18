import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
class DetailInvoice extends StatefulWidget {
  final Map<String, dynamic> map;
  final bool isCustomer;
  DetailInvoice({this.map, this.isCustomer});
  @override
  _DetailInvoiceState createState() => _DetailInvoiceState();
}

class _DetailInvoiceState extends State<DetailInvoice> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: containerDetail(
          context,
          componentContainerDetailInvoice(
              context,
              id: this.widget.map["id"],
              customerName: this.widget.map["customer_name"],
              managerName: this.widget.map["manager_name"],
              managerPhone: this.widget.map["manager_phone"],
              customerPhone: this.widget.map["customer_phone"],
              createTime: this.widget.map["create_time"],
              productId: this.widget.map["product_id"],
              productName: this.widget.map["product_name"],
              description: this.widget.map["description"],
              price: "${this.widget.map["price"]}",
              degree: this.widget.map["degree"],
              quantity: this.widget.map["quantity"],
              customerConfirmDate: this.widget.map["customer_sign_date"],
              managerConfirmDate: this.widget.map["manager_sign_date"],
              statusId: this.widget.map["status_id"],
              customerId: this.widget.map["customer_id"],
              managerId: this.widget.map["manager_id"],
              activeDate: this.widget.map["active_date"],
              isCustomer: widget.isCustomer
          ),
        ),
      ),
    );
  }
}