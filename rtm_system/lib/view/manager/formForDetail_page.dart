import 'dart:ui';

import 'package:flutter/material.dart';

//Đang dùng cho tran chi tiết sản phẩm, và sẽ dùng cho trang chi tiết ứng tiền, hóa đơn, khách hàng
class FormForDetailPage extends StatefulWidget {
  final Widget bodyPage;
  final String tittle;
  FormForDetailPage({this.tittle, this.bodyPage});

  @override
  _FormForDetailPageState createState() => _FormForDetailPageState();
}

class _FormForDetailPageState extends State<FormForDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0BB791),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          elevation: 0,
          centerTitle: true,
          title: Text("${this.widget.tittle}", style: TextStyle(color:Colors.white),),
        ),
      ),
      body: this.widget.bodyPage,
    );
  }
}
