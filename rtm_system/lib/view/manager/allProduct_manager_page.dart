import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
class AllProduct extends StatefulWidget {
  const AllProduct({Key key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Quản lý sản phẩm",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
        bottom: PreferredSize(
            child: btnMain(context, "Cập nhật giá", Icon(Icons.update)),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            card(context, "Mủ nước", "Mủ lỏng", "100000", "17-05-2021"),
            card(context, "Mủ dây", "Mủ đặc", "165323", "17-05-2021"),
            card(context, "Mủ ké", "Mủ đặc", "90776", "17-05-2021"),
            card(context, "Mủ đất", "Mủ đặc", "100000", "17-05-2021"),
            card(context, "Mủ chén", "Mủ đặc", "265378", "17-05-2021"),
            card(context, "Mủ đông", "Mủ đặc", "1000", "17-05-2021"),
            card(context, "Mủ nước", "Mủ đặc", "10000", "17-05-2021"),
          ],
        )),
      ),
    );
  }
}
