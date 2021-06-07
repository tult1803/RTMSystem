
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
    return SingleChildScrollView(
      child: containerDetail(context,
      componentContainerDetailProduct(context, this.widget.itemDetailProduct),
      )
        );
  }
}

Widget componentContainerDetailProduct(BuildContext context, Map item){
  final oCcy = new NumberFormat("#,##0", "en_US");
  DateTime _date = DateTime.parse(item["updateDateTime"]);
  final fBirthday = new DateFormat('dd/MM/yyyy hh:mm');
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "Mã sản phẩm", "${item["id"]}"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Tên sản phẩm", item["name"]),
        SizedBox(height: 10,),
        txtItemDetail(context, "Mô tả", item["description"]),
        SizedBox(height: 10,),
        txtItemDetail(context, "Loại", "${item["type"]}"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Giá (1kg)", "${oCcy.format(double.parse("${item["update_price"]}"))}đ"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Ngày cập nhật", "${fBirthday.format(_date)}"),
        SizedBox(height: 5,),
      ],
    ),
  );
}