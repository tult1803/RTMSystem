import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/product/showProduct_manager.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/product/updatePriceProduct_manager.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: welcome_color,
          title: Center(
            child: AutoSizeText(
              "Quản lý sản phẩm",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
          ),
          bottom: PreferredSize(
              child: btnMain(context, 150, "Cập nhật giá", Icon(Icons.update),
                  updatePriceProduct()),
              preferredSize: Size.fromHeight(60.0)),
        ),
        body: new showAllProduct());
  }
}
