import 'package:flutter/material.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
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
    print(token);
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    return infomationCustomer;
  }

  @override
  Widget build(BuildContext context) {
    String genderShow = '';
    var size = MediaQuery.of(context).size;
    return new FutureBuilder(
      future: getAPIProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //show gender vì trong đây mới có data để set
          infomationCustomer.gender == 0
              ? genderShow = 'Nữ'
              : genderShow = 'Nam';
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
                        _item(context, 'Ngày sinh', getDateTime(infomationCustomer.birthday.toString(), dateFormat: 'dd-MM-yyyy')),
                        _item(context, 'Số điện thoại',
                            infomationCustomer.phone),
                        _item(context, 'Giới tính', genderShow),
                        _item(context, 'CMND', infomationCustomer.cmnd),
                        _item(context, 'Địa chỉ', infomationCustomer.address.toString()),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                //màn hình nhỏ hơn sẽ không bị tràn
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                      SizedBox(
                        width: size.width* 0.03,
                      ),
                      btnUpdatePw(
                          context, this.password, infomationCustomer.accountId, true),
                    ],
                  ),
                ),
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
  //Show thông tin của người dùng
  Widget _item(context, header, value) {
    // Khi giá trị get lên là rỗng thì set '' để load tránh lỗi trang
    if(value == null){
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
