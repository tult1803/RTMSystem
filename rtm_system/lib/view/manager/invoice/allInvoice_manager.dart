import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/invoice/showAllInvoice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';

class AllInvoice extends StatefulWidget {
  final int index;
  AllInvoice({this.index});

  @override
  _AllInvoiceState createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new showAllInvoice(index: this.widget.index,),
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
