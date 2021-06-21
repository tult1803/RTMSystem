import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/invoice/showAllInvoice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';

class AllInvoice extends StatefulWidget {
  const AllInvoice({Key key}) : super(key: key);

  @override
  _AllInvoiceState createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        elevation: 0,
        title: Center(
          child: Text(
            "Quản lý hóa đơn",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
      ),
      body: new showAllInvoice(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProductPage(
                  tittle: "Tạo hóa đơn",
                  isCustomer: false,
                ))),
        child: new Icon(
          Icons.post_add,
          color: Colors.white,
          size: 30,
        ),
        elevation: 2,
      ),
    );
  }
}
