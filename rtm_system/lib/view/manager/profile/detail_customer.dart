import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_all_customer.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/view/customer/Profile/show_image_cmnd.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCustomer extends StatefulWidget {
  final CustomerList customerList;
  final String token;

  DetailCustomer({this.token, this.customerList});

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int id, advance, statusId;
  String cmnd, fullName, phone, birthday, address, gender, status, accountId;
  String imageCMNDF, imageCMNDB;
  bool needConfirm;

  // ignore: missing_return
  Future _getData() {
    setState(() {
      id = widget.customerList.id;
      statusId = widget.customerList.statusId;
      status = '${getStatus(status: widget.customerList.statusId)}';
      accountId = widget.customerList.accountId;
      advance = widget.customerList.advance;
      cmnd = widget.customerList.cmnd;
      fullName = widget.customerList.fullName;
      phone = widget.customerList.phone;
      birthday = widget.customerList.birthday;
      address = widget.customerList.address;
      imageCMNDB = widget.customerList.cmndBack;
      imageCMNDF = widget.customerList.cmndFront;
      needConfirm = widget.customerList.needConfirm;
    });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          containerDetail(
              context,
              componentContainerDetailCustomer(
                context,
                token: this.widget.token,
                accountId: accountId,
                fullName: fullName,
                address: address,
                advance: advance,
                birthday: birthday,
                cmnd: cmnd,
                gender: getGender(widget.customerList.gender),
                phone: phone,
                status: status,
                level: "${getLevel(level: widget.customerList.level)}",
                statusId: statusId,
                imageCMNDB: imageCMNDB,
                imageCMNDF: imageCMNDF,
                needConfirm: needConfirm,
              ),
              marginBottom: 50,
              marginRight: 10,
              marginLeft: 10,
              marginTop: 15),
        ],
      )),
    );
  }
  Widget componentContainerDetailCustomer(BuildContext context,
      {String status,
      String token,
      String accountId,
      int statusId,
      int advance,
      String fullName,
      String cmnd,
      String phone,
      String address,
      String birthday,
      String gender,
      String imageCMNDF,
      String imageCMNDB,
      bool needConfirm,
      String level}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          txtItemDetail(context, "ID khách hàng", accountId),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Họ và tên", fullName),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Giới tính", gender),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              txtItemDetail(context, "Điện thoại", phone),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _makePhoneCall('tel:$phone');
                      });
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, right: 10),
                        child: Text(
                          "Gọi",
                          style: TextStyle(
                              color: imageCMNDF == null
                                  ? Colors.redAccent
                                  : needConfirm
                                      ? Colors.orange
                                      : Colors.blueAccent),
                        ))),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              txtItemDetail(context, "CMND/CCCD", cmnd),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      if (imageCMNDF != null)
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageCMND(
                                  imageFCMND: imageCMNDF,
                                  imageBCMND: imageCMNDB,
                                )));
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 5, right: 10),
                        child: Text(
                          imageCMNDF == null
                              ? "Chờ cập nhật"
                              : needConfirm
                                  ? "Chờ xác nhận"
                                  : "Xem ảnh",
                          style: TextStyle(
                              color: imageCMNDF == null
                                  ? Colors.redAccent
                                  : needConfirm
                                      ? Colors.orange
                                      : Colors.blueAccent),
                        ))),
              ),
            ],
          ),
          SizedBox(
              height: 1,
              child: Container(
                color: Color(0xFFBDBDBD),
              )),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Ngày sinh",
              "${getDateTime(birthday, dateFormat: 'dd/MM/yyyy')}"),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Địa chỉ", address),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Tổng nợ", "${getFormatPrice("$advance")}đ"),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Loại tài khoản", level),
          SizedBox(
            height: 10,
          ),
          txtItemDetail(context, "Trạng thái", "$status",
              colorContent: getColorStatus(status: statusId)),
          SizedBox(
            height: 10,
          ),
          btnDeactivateCustomer(
              token: token,
              context: context,
              status: status,
              deactivateId: accountId),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
