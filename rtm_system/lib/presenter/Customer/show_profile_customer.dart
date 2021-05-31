import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showProfile extends StatefulWidget {
  const showProfile({Key key}) : super(key: key);

  @override
  _showProfileState createState() => _showProfileState();
}

class _showProfileState extends State<showProfile> {
  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAPIProfile();
    print('_showProfileState');
  }

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    password = sharedPreferences.getString('password');
    print(token);
    // Đỗ dữ liệu lấy từ api
    print('OKla');
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    return infomationCustomer;
  }

  @override
  Widget build(BuildContext context) {
    String genderShow = '';

    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
      decoration: BoxDecoration(
        color: Color(0xffEEEEEE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: new FutureBuilder(
        future: getAPIProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DateTime date = infomationCustomer.birthday;
            final f = new DateFormat('dd-MM-yyyy');
            //show gender
            infomationCustomer.gender == 0
                ? genderShow = 'Nữ'
                : genderShow = 'Nam';
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Image(
                        image: AssetImage("images/avt.png"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                btnLogout(context),
                SizedBox(
                  height: 10,
                ),

                //data infor show here
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        _item(context, 'Họ và tên',
                            infomationCustomer.fullname),
                        _item(context, 'Ngày sinh', f.format(date)),
                        _item(
                            context, 'Số điện thoại', infomationCustomer.phone),
                        _item(context, 'Giới tính', genderShow),
                        _item(context, 'CMND', infomationCustomer.cmnd),
                        _item(context, 'Địa chỉ', infomationCustomer.address),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                btnUpdateInfo(
                  context,
                  infomationCustomer.cmnd,
                  this.password,
                  infomationCustomer.fullname,
                  infomationCustomer.gender,
                  infomationCustomer.phone,
                  infomationCustomer.birthday,
                  infomationCustomer.address,
                  false,
                  infomationCustomer.accountId,
                ),
                btnUpdatePw(context, this.password, infomationCustomer.accountId),
              ],
            );
          }
          return Container(
              height: size.height,
              child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  Widget _item(context, header, value) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: [
          ListTile(
            title: Text(header),
            trailing: Text(value),
          ),
          SizedBox(
            height: 1,
            width: size.width * 0.85,
            child: Container(
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}
