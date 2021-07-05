import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/process_create_customer.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class ConfirmCreateCustomer extends StatefulWidget {
  //Chuỗi dữ liệu của list được truyền vào sẽ theo thứ tự sau:
  // fullname, gender, phone, CMND, address, password
  final List listCustomer;
  final bool check, isUpdate, isCustomer, isCreate;
  final String account_id;
  final int typeOfUpdate;
  ConfirmCreateCustomer({this.listCustomer, this.check, this.isUpdate,this.typeOfUpdate, this.account_id, this.isCustomer, this.isCreate});

  @override
  _ConfirmCreateCustomerState createState() => _ConfirmCreateCustomerState();
}

class _ConfirmCreateCustomerState extends State<ConfirmCreateCustomer> {
  String fullname, phone, cmnd, address, password, gender;
  DateTime birthday;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() {
    setState(() {
      fullname = this.widget.listCustomer[0];
      if (this.widget.listCustomer[1] == 1) {
        gender = "Nam";
      } else {
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
          leading: leadingAppbar(context),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Phiếu xác nhận",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: welcome_color,
        ),
        backgroundColor: welcome_color,
        body: Card(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _checkPhone(),
                  txtConfirm(context, "Họ và tên", fullname),
                  txtConfirm(context, "Giới tính", "$gender"),
                  txtConfirm(context, "Ngày sinh", "${getDateTime("$birthday", dateFormat: 'dd/MM/yyyy')}"),
                  _checkCMND(),
                  _checkAddress(),
                  processCreateCustomer(
                      tittle: "Xác nhận",
                      isCreate: this.widget.isCreate,
                      listCustomer:  this.widget.listCustomer,
                      isCustomer: this.widget.isCustomer,
                      isUpdate: this.widget.isUpdate,
                      typeOfUpdate: this.widget.typeOfUpdate,
                      account_id: this.widget.account_id),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _checkCMND() {
    if (this.widget.check) {
      return txtConfirm(context, "CMND/CCCD", cmnd);
    } else
      return Container();
  }

  Widget _checkAddress() {
    if (this.widget.check) {
      return txtConfirm(context, "Địa chỉ", address);
    } else
      return Container();
  }

  Widget _checkPhone() {
    if (this.widget.check) {
      return txtConfirm(context, "Số điện thoại đăng nhập", phone);
    } else
      return txtConfirm(context, "Số điện thoại", phone);
  }
}
