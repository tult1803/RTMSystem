import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class updatePriceProduct extends StatefulWidget {
  const updatePriceProduct({Key key}) : super(key: key);

  @override
  _updatePriceProductState createState() => _updatePriceProductState();
}

class _updatePriceProductState extends State<updatePriceProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
            "Cập nhật giá",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: new Container(),
    );
  }
}
