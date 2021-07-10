import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_advance_return_detail.dart';
class DetailInvoiceInAdvance extends StatefulWidget {
  final InvoiceInAdvanceReturn invoice;
  DetailInvoiceInAdvance({this.invoice,});
  @override
  _DetailInvoiceInAdvanceState createState() => _DetailInvoiceInAdvanceState();
}

class _DetailInvoiceInAdvanceState extends State<DetailInvoiceInAdvance> {
  @override
  void initState() {
    super.initState();
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
              id: "${widget.invoice.id}",
              customerName: widget.invoice.customerName,
              managerName: widget.invoice.managerName,
              managerPhone: widget.invoice.managerPhone,
              customerPhone: widget.invoice.customerPhone,
              createTime: widget.invoice.createTime,
              productId: widget.invoice.productId,
              productName: widget.invoice.productName,
              storeName: widget.invoice.storeName,
              price: "${widget.invoice.price}",
              degree: widget.invoice.degree,
              quantity: widget.invoice.quantity,
              customerConfirmDate: widget.invoice.customerSignDate,
              statusId: widget.invoice.statusId,
              customerId: widget.invoice.customerId,
              managerId: widget.invoice.managerId,
              activeDate: widget.invoice.activeDate,
              isCustomer: true,
          ),
        ),
      ),
    );
  }
}
