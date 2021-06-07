import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailProduct extends StatefulWidget {
  final Map<String, dynamic> itemDetailProduct;

  DetailProduct({this.itemDetailProduct});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
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
        componentContainerDetailProduct(context, this.widget.itemDetailProduct),
      )),
    );
  }
}
