import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/Profile/account_verification.dart';
import 'package:rtm_system/view/customer/Profile/update_profile.dart';
import 'package:rtm_system/view/update_password.dart';
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
    super.initState();
    this.getAPIProfile();
  }

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    password = sharedPreferences.getString('password');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    return infomationCustomer;
  }

// // show option choice update profile
  void showPicker(
      context,
      String cmnd,
      String password,
      String fullname,
      int gender,
      String phone,
      DateTime birthday,
      String address,
      bool check,
      String accountId,
      bool isCustomer) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            // title: Text('Chỉnh sửa thông tin'),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Cập nhật thông tin'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(
                              cmnd: cmnd,
                              password: password,
                              fullname: fullname,
                              gender: gender,
                              phone: phone,
                              birthday: birthday,
                              address: address,
                              check: check,
                              account_id: accountId,
                            )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.password),
                title: Text('Thay đổi mật khẩu'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePasswordPage(
                              password: password,
                              account_id: accountId,
                              isCustomer: isCustomer,
                            )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.perm_media_outlined),
                title: Text('Xác thực ảnh CMND'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AccountVerification()));
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new FutureBuilder(
      future: getAPIProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
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
                btnLogout(context),
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
                            infomationCustomer.fullname),
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
                btnChooseOption(context, size.width * 0.9, size.height * 0.1),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        }
        return Container(
            height: size.height,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget btnChooseOption(context, width, height) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              showPicker(
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
                  true);
            },
            child: Center(
              child: AutoSizeText(
                "Chỉnh sửa thông tin",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
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
        ));
  }

  //Show thông tin của người dùng
  Widget _item(context, header, value) {
    // Khi giá trị get lên là rỗng thì set '' để load tránh lỗi trang
    if (value == null) {
      value = '';
    }
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
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
