import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

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
      backgroundColor: welcome_color,
      appBar: AppBar(
        leading: leadingAppbar(context),
        backgroundColor: welcome_color,
        elevation: 0,
        centerTitle: true,
        title: Text("${this.widget.tittle}", style: TextStyle(color:Colors.white),),
      ),
      body: this.widget.bodyPage,
    );
  }
}
