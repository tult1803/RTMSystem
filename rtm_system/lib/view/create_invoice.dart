import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key key, this.isNew, this.idProduct}) : super(key: key);
  //false will show btn 'Sửa lại sản phẩm'
  final bool isNew;
  final String idProduct;

  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        leading: leadingAppbar(context),
        title: Text(
          "Tạo yêu cầu bán hàng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: widgetCreateInvoice(context, widget.isNew, widget.idProduct),
    );
  }
}
