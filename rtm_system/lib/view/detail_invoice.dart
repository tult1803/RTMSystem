import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_invoice.dart';
class DetailInvoice extends StatefulWidget {
  final InvoiceElement invoiceElement;
  final bool isCustomer;
  final Widget widgetToNavigator;
  DetailInvoice({this.invoiceElement, this.isCustomer, this.widgetToNavigator});
  @override
  _DetailInvoiceState createState() => _DetailInvoiceState();
}

class _DetailInvoiceState extends State<DetailInvoice> {
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
              id: "${widget.invoiceElement.id}",
              customerName: widget.invoiceElement.customerName,
              managerName: widget.invoiceElement.managerName,
              managerPhone: widget.invoiceElement.managerPhone,
              customerPhone: widget.invoiceElement.customerPhone,
              createTime: widget.invoiceElement.createTime,
              productId: widget.invoiceElement.productId,
              productName: widget.invoiceElement.productName,
              storeName: widget.invoiceElement.storeName,
              price: "${widget.invoiceElement.price}",
              degree: widget.invoiceElement.degree,
              quantity: widget.invoiceElement.quantity,
              customerConfirmDate: widget.invoiceElement.customerSignDate,
              statusId: widget.invoiceElement.statusId,
              customerId: widget.invoiceElement.customerId,
              managerId: widget.invoiceElement.managerId,
              activeDate: widget.invoiceElement.activeDate,
              isCustomer: widget.isCustomer,
              widgetToNavigator: this.widget.widgetToNavigator,
          ),
        ),
      ),
    );
  }
}
