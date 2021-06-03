
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailProduct extends StatefulWidget {
  final int id;
  final String name, description, type, date_time, price;

  DetailProduct({this.id, this.name, this.description, this.type, this.date_time, this.price});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('${this.widget.id} - ${this.widget.name} - ${this.widget.description} - ${this.widget.type} - ${this.widget.price} - ${this.widget.date_time}');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: containerDetail(context,
      componentContainerDetailProduct(context, this.widget.id, this.widget.name, this.widget.description, this.widget.type, this.widget.price, this.widget.date_time),
      ));
  }
}

Widget componentContainerDetailProduct(BuildContext context, int id, String name, String description, String type, String price, String dateTime){
  final oCcy = new NumberFormat("#,##0", "en_US");
  DateTime _date = DateTime.parse(dateTime);
  final fBirthday = new DateFormat('dd/MM/yyyy hh:mm');
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "Mã sản phẩm", "$id"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Tên sản phẩm", name),
        SizedBox(height: 10,),
        txtItemDetail(context, "Mô tả", description),
        SizedBox(height: 10,),
        txtItemDetail(context, "Loại", type),
        SizedBox(height: 10,),
        txtItemDetail(context, "Giá (1kg)", "${oCcy.format(double.parse(price))}đ"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Ngày cập nhật", "${fBirthday.format(_date)}"),
        SizedBox(height: 5,),
      ],
    ),
  );
}