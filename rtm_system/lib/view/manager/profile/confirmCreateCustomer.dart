import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/processCreateCustomer.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class ConfirmCreateCustomer extends StatefulWidget {
  //Chuỗi dữ liệu của list được truyền vào sẽ theo thứ tự sau:
  // fullname, gender, phone, CMND, address, password
  final List listCustomer;

  ConfirmCreateCustomer(this.listCustomer);

  @override
  _ConfirmCreateCustomerState createState() => _ConfirmCreateCustomerState();
}

class _ConfirmCreateCustomerState extends State<ConfirmCreateCustomer> {
  String fullname, phone, cmnd, address, password, birthday, gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future<void> _getData() {
    setState(() {
      fullname = this.widget.listCustomer[0];
       if(this.widget.listCustomer[1] == 1){
         gender = "Nam";
       }else{
         gender = "Nữ";
       }
      phone = this.widget.listCustomer[2];
      cmnd = this.widget.listCustomer[3];
      address = this.widget.listCustomer[4];
      password = this.widget.listCustomer[5];
      birthday = this.widget.listCustomer[6];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Phiếu xác nhận"),
          backgroundColor: welcome_color,
        ),
        backgroundColor: welcome_color,
        body: Card(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  txtConfirm(context, "Số điện thoại đăng nhập", phone),
                  txtConfirm(context, "Mật khẩu đăng nhập", password),
                  txtConfirm(context, "Họ và tên", fullname),
                  txtConfirm(context, "Giới tính", "$gender"),
                  txtConfirm(context, "Ngày sinh", birthday),
                  txtConfirm(context, "CMND/CCCD", cmnd),
                  txtConfirm(context, "Địa chỉ", address),
                  processCreateCustomer("Xác nhận", this.widget.listCustomer),
                ],
              ),
            ),
          ),
        ));
  }
}

