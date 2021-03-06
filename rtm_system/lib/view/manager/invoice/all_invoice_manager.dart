import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/invoice/show_all_invoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/add_product_invoice.dart';

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
      body: showAllInvoice(index: this.widget.index,),
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
