import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';

class DetailProduct extends StatefulWidget {
  final Map<String, dynamic> itemDetailProduct;

  DetailProduct({this.itemDetailProduct});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
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
        componentContainerDetailProduct(context, this.widget.itemDetailProduct),
      )),
    );
  }
}
