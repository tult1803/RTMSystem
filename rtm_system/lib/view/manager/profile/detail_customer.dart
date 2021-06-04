import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailCustomer extends StatefulWidget {
  final Map<String, dynamic> map;

  DetailCustomer({this.map});

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int id, status_id, account_id, advance;
  String cmnd, fullname, phone, birthday, address, gender;
  String vip;

  Future _getData(){
    setState(() {
      id = this.widget.map["id"];
      status_id = this.widget.map["status_id"];
      account_id = this.widget.map["account_id"];
      advance = this.widget.map["advance"];
      cmnd = this.widget.map["cmnd"];
      fullname = this.widget.map["fullname"];
      phone = this.widget.map["phone"];
      birthday = this.widget.map["birthday"];
      address = this.widget.map["address"];
      if(this.widget.map["vip"]){
        vip = "VIP";
      }else vip = "Thường";
      if(this.widget.map["gender"] == 0){
        gender ="Nữ";
      }else gender = "Nam";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: containerDetail(context,
          componentContainerDetailProduct(
              context,
            account_id: account_id,
            fullname: fullname,
            address: address,
            advance: advance,
            birthday: birthday,
            cmnd: cmnd,
            gender: gender,
            phone: phone,
            status_id: status_id,
            vip: vip,
          ),
        ));
  }
}

Widget componentContainerDetailProduct(BuildContext context,
    {int status_id,
    int account_id,
    int advance,
    String fullname,
    String cmnd,
    String phone,
    String address,
    String birthday,
    String gender,
    String vip}){
  // final oCcy = new NumberFormat("#,##0", "en_US");
  DateTime _date = DateTime.parse(birthday);
  final fBirthday = new DateFormat('dd/MM/yyyy');
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID khách hàng", "$account_id"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Họ và tên", "$fullname"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Giới tính", "$gender"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Điện thoại", "$phone"),
        SizedBox(height: 10,),
        txtItemDetail(context, "CMND/CCCD", "$cmnd"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Ngày sinh", "${fBirthday.format(_date)}"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Địa chỉ", "$address"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Tổng nợ", "$advance"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Loại tài khoản", "$vip"),
        SizedBox(height: 10,),
        txtItemDetail(context, "Trạng thái", "$status_id"),
        SizedBox(height: 5,),
      ],
    ),
  );
}