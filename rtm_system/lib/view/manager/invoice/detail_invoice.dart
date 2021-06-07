import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/getStatus.dart';

class DetailInvoice extends StatefulWidget {
  final Map<String, dynamic> map;

  DetailInvoice({this.map});

  @override
  _DetailInvoiceState createState() => _DetailInvoiceState();
}

class _DetailInvoiceState extends State<DetailInvoice> {
  int id, product_id;
  double quantity, total, degree;
  String customer_name,
      creater_name,
      product_name,
      price,
      description,
      customer_confirm_date,
      manager_confirm_date,
      status,
      create_time;

  Future _getData() {
    setState(() {
      id = this.widget.map["id"];
      status = '${getStatus(status: this.widget.map["status_id"])}';
      customer_name = this.widget.map["customer_name"];
      creater_name = this.widget.map["creater_name"];
      product_name = this.widget.map["product_name"];
      price = "${this.widget.map["price"]}";
      description = this.widget.map["description"];
      customer_confirm_date = this.widget.map["customer_confirm_date"];
      manager_confirm_date = this.widget.map["manager_confirm_date"];
      product_id = this.widget.map["product_id"];
      create_time = this.widget.map["create_time"];
      quantity = this.widget.map["quantity"];
      total = this.widget.map["total"];
      degree = this.widget.map["degree"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
          child: containerDetail(
              context,
              componentContainerDetailInvoice(
                context,
                id: id,
                customer_name: customer_name,
                price: "$price",
                create_time: create_time,
                product_name: product_name,
                description: description,
                creater_name: creater_name,
                status: status,
                statusId: this.widget.map["status_id"],
                product_id: product_id,
                quantity: quantity,
                total: total,
                degree: degree,
                customer_confirm_date: customer_confirm_date,
                manager_confirm_date: manager_confirm_date,
              ))),
    );
  }
}
