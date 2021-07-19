import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/view/form_update_profile.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    Key key,
    this.fullname,
    this.gender,
    this.password,
    this.cmnd,
    this.address,
    this.birthday,
    this.check,
    this.accountId,
  }) : super(key: key);
  final String cmnd;
  final String fullname;
  final int gender;
  final String password;
  final DateTime birthday;
  final String address;
  final bool check;
  final String accountId;


  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String title = "Thay đổi thông tin";
  String password, errPassword;
  int selectedRadio;
  bool checkShow = true, checkClick = false, checkPasswordSuccess = false;
  @override
  void initState() {
    super.initState();
    //set value nam or nu
    selectedRadio = widget.gender;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: Color(0xFF0BB791),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nhập mật khẩu : ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0BB791),
                  ),
                ),
                btnShowOrHide(),
              ],
            ),
          ),
          Column(
            children: [
              _txtfield(
                  getDataTextField(this.password),
                  "Nhập mật khẩu hiện tại",
                  "Mật khẩu hiện tại",
                  errPassword,
                  1,
                  TextInputType.text),
            ],
          ),
          // sau khi nhập mật khẩu xong thì có thể update thông tin. 
          if(checkPasswordSuccess || widget.check == true)
            // formUpdateProfile(
            //   fullname: widget.fullname,
            //   cmnd: widget.cmnd,
            //   phone: "",
            //   address: widget.address,
            //   password: widget.password,
            //   birthday: widget.birthday,
            //   gender: widget.gender,
            //   check: true,
            //   isUpdate: true,
            //   typeOfUpdate: 1,
            //   accountId: widget.accountId,
            //   isCustomer: true,
            // ),
            Text('Form update'),
            SizedBox(height: 15,),
            if(checkPasswordSuccess == false)
            btnSubmitValidate(context, size.width * 0.3, size.height * 0.05, Color(0xFF0BB791), "Kiểm tra"),
          ],
        ),
      ),
    );
  }
Widget btnSubmitValidate(BuildContext context, double width, double height,
      Color color, String tittleButtonAlertDialog) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              bool check = _validateData();
              if (check) {
                checkPasswordSuccess = true;
              }
            });
          },
          child: Center(
            child: Text(
              tittleButtonAlertDialog,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }
  Widget _txtfield(TextEditingController _controller, String hintText,
      String tittle, String error, int maxLines, TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        obscureText: checkShow ? true : false,
        onChanged: (value) {
          if (tittle == 'Mật khẩu hiện tại') {
            this.password = value.trim();
          }
          setState(() {
            checkClick = true;
          });
        },
        maxLines: maxLines,
        keyboardType: txtType,
        style: TextStyle(fontSize: 15),
        cursorColor: Color(0xFF0BB791),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '$hintText',
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF0BB791),
            ),
          ),
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.create,
            color: Colors.black54,
          ),

          //Hiển thị lỗi
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          //Nhận thông báo lỗi
          errorText: error,

          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  TextEditingController getDataTextField(String txt) {
    if (txt == null) {
      txt = "";
    }
    final TextEditingController _controller = TextEditingController();
    _controller.value = _controller.value.copyWith(
      text: txt,
      selection: TextSelection.collapsed(offset: txt.length),
    );
    return _controller;
  }
   bool _validateData() {
    bool check = false;
    if (this.password == null || this.password == "") {
      errPassword = "Mật khẩu trống";
    } else {
      if (this.widget.password!= this.password) {
        errPassword = "Mật khẩu sai";
      } else {
        errPassword = null;
      }
    }
    if (errPassword == null) {
      check = true;
    }
    return check;
  }
  Widget btnShowOrHide() {
    return checkShow
        ? GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 0),
              width: 80,
              child: Center(
                child: Text(
                  "Hiển thị",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                checkShow = false;
              });
            },
          )
        : GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 0),
              width: 80,
              child: Center(
                child: Text(
                  "Ẩn",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                checkShow = true;
              });
            },
          );
  }
}
