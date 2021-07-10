import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class DetailInvoiceRequest extends StatefulWidget {
  final InvoiceRequestElement invoiceRequestElement;
  final bool isCustomer;
  final isRequest;
  final Widget widgetToNavigator;

  DetailInvoiceRequest(
      {this.invoiceRequestElement, this.isCustomer, this.isRequest, this.widgetToNavigator});

  @override
  _DetailInvoiceRequestState createState() => _DetailInvoiceRequestState();
}

class _DetailInvoiceRequestState extends State<DetailInvoiceRequest> {
  @override
  void initState() {
    super.initState();
  }

  String reasonInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
          child: Column(
        children: [
          containerDetail(
            context,
            componentContainerInvoiceRequest(
              context,
              id: "${widget.invoiceRequestElement.id}",
              storeName: widget.invoiceRequestElement.storeName,
              customerName: widget.invoiceRequestElement.customerName,
              customerPhone: widget.invoiceRequestElement.customerPhone,
              createDate: widget.invoiceRequestElement.createDate,
              sellDate: widget.invoiceRequestElement.sellDate,
              productName: widget.invoiceRequestElement.productName,
              price: "${widget.invoiceRequestElement.price}",
              element: this.widget.invoiceRequestElement,
              isCustomer: widget.isCustomer,
              isRequest: widget.isRequest,
              widgetToNavigator: this.widget.widgetToNavigator,
            ),
          ),
            //dùng dialog có setState cho xoá yêu cầu của customer nên thêm ở đây
          if (widget.isCustomer)
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.redAccent,
              onPressed: () {
                _displayTextInputDialog(context, "${widget.invoiceRequestElement.id}");
              },
              child: Text(
                'Xoá yêu cầu',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
        ],
      )),
    );
  }

  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context, id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Lý do'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  reasonInput = value;
                });
              },
              controller: _textFieldController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Nhập lý do (không bắt buộc)",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Không',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  doConfirmOrAcceptOrRejectInvoice(context, id, 3, true,
                      reason: reasonInput);
                },
                child: Text(
                  'Có',
                  style: TextStyle(
                    color: welcome_color,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
