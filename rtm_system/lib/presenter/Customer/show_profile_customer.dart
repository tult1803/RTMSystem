import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/Profile/account_verification.dart';
import 'package:rtm_system/view/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class showProfile extends StatefulWidget {
  const showProfile({Key key}) : super(key: key);

  @override
  _showProfileState createState() => _showProfileState();
}

// ignore: camel_case_types
class _showProfileState extends State<showProfile> {
  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getAPIProfile() async{
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString('access_token');
      String phone = sharedPreferences.getString('phone');
      password = sharedPreferences.getString('password');
      infomationCustomer =
          await getAPIProfileCustomer.getProfileCustomer(token, phone);
      return infomationCustomer;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _getAPIProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: size.width * 0.5,
                      height: size.height * 0.16,
                      child: Center(
                        child: Image(
                          image: AssetImage("images/avt.png"),
                        ),
                      ),
                    ),
                    btnChooseOption(context, size.width * 0.45, infomationCustomer.level),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                //data infor show here
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        _item(context, 'Họ và tên',
                            infomationCustomer.fullName),
                        _item(
                            context,
                            'Ngày sinh',
                            getDateTime(infomationCustomer.birthday.toString(),
                                dateFormat: 'dd-MM-yyyy')),
                        _item(
                            context, 'Số điện thoại', infomationCustomer.phone),
                        _item(context, 'Giới tính',
                            getGender(infomationCustomer.gender)),
                        _item(context, 'CMND', infomationCustomer.cmnd),
                        _item(context, 'Địa chỉ',
                            infomationCustomer.address.toString()),
                        _item(context, 'Loại tài khoản',
                            getLevel(level: infomationCustomer.level)),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                btnLogout(context),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.all(12),
            child: Center(
              child: Column(
                children: [
                  AutoSizeText(showMessage("", MSG008),
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: size.height,
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  btnLogout(context),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget btnChooseOption(context, width, int level) {
    return Container(
      width: width,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePasswordPage(
                    password: password,
                    account_id: infomationCustomer.accountId,
                    isCustomer: true,
                  ),
                ),
              );
            },
            child: Center(
              child: AutoSizeText(
                "Thay đổi mật khẩu",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          level == 0
              ? TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AccountVerification()));
                  },
                  child: Center(
                    child: AutoSizeText(
                      "Xác thực ảnh CMND",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
  //Show thông tin của người dùng
  Widget _item(context, header, value) {
    // Khi giá trị get lên là rỗng thì set '' để load tránh lỗi trang
    if (value == null) {
      value = '';
    }
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(header),
              Container(
                width: size.width * 0.5,
                child: AutoSizeText(
                  value,
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 1,
            width: size.width,
            child: Container(
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}
