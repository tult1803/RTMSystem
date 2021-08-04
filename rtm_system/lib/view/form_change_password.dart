import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';

// ignore: camel_case_types
class formUpdatePasswordPage extends StatefulWidget {
  final String accountId;
  final bool isCustomer;

  formUpdatePasswordPage({this.accountId, this.isCustomer});

  @override
  _formUpdatePasswordPageState createState() => _formUpdatePasswordPageState();
}

// ignore: camel_case_types
class _formUpdatePasswordPageState extends State<formUpdatePasswordPage> {
  String errPassword, errNewPassword, errConfirmPassword;
  String password, newPassword, confirmPassword;
  bool checkClick = false;
  bool checkShow = true;
  int indexOfBottomBar = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isCustomer) {
      indexOfBottomBar = 4;
    } else {
      indexOfBottomBar = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mật khẩu hiện tại : ",
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
          _txtField(getDataTextField(this.password), "Nhập mật khẩu hiện tại",
              "Mật khẩu hiện tại", errPassword, 1, TextInputType.text),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Mật khẩu mới : ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0BB791),
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
            children: [
              _txtField(getDataTextField(this.newPassword), "Nhập mật khẩu mới",
                  "Mật khẩu mới", errNewPassword, 1, TextInputType.text),
              _txtField(
                  getDataTextField(this.confirmPassword),
                  "Nhập lại mật khẩu",
                  "Xác nhận mật khẩu mới",
                  errConfirmPassword,
                  1,
                  TextInputType.text),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btnSubmitOrCancel(
                  context,
                  size.width * 0.3,
                  size.height * 0.05,
                  Colors.redAccent,
                  "Hủy",
                  "",
                  "",
                  null,
                  false,
                  indexOfBottomBar,
                  widget.isCustomer,
                  'Bạn muốn huỷ thay đổi mật khẩu?'),
              SizedBox(width: 20),
              btnSubmitValidate(context, size.width * 0.3, size.height * 0.05,
                  Color(0xFF0BB791), "Lưu"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _txtField(TextEditingController _controller, String hintText,
      String tittle, String error, int maxLines, TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        obscureText: checkShow ? true : false,
        onChanged: (value) async {
          if (tittle == "Mật khẩu mới") {
            this.newPassword = value.trim();
          } else if (tittle == 'Xác nhận mật khẩu mới') {
            this.confirmPassword = value.trim();
          } else if (tittle == 'Mật khẩu hiện tại') {
            this.password = value.trim();
          }
          setState(() {
            checkClick = true;
          });
        },
        onSubmitted: (value) async {
          if (tittle == "Mật khẩu mới") {
            this.newPassword = value.trim();
            errNewPassword = await checkPassword(newPassword, 1);
          } else if (tittle == 'Xác nhận mật khẩu mới') {
            this.confirmPassword = value.trim();
            errConfirmPassword = await checkPassword(confirmPassword, 2,
                passwordCheck: newPassword);
          } else if (tittle == 'Mật khẩu hiện tại') {
            this.password = value.trim();
            errPassword = await checkPassword(password, 0);
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
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (tittle == "Mật khẩu mới") {
                this.newPassword = "";
              } else if (tittle == 'Xác nhận mật khẩu mới') {
                this.confirmPassword = "";
              } else if (tittle == 'Mật khẩu hiện tại') {
                this.password = "";
              }
              });
              _controller.clear;
            },
            icon: Icon(Icons.clear),
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
          onPressed: () async {
            bool check = await _validateData();
            setState(() {
              if (check) {
                //chỉ cần pw và account_id để change pw, những field khác truyền để đủ field theo function
                doUpdatePassword(context,
                    isCustomer: widget.isCustomer,
                    accountId: "${widget.accountId}",
                    password: password,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword);
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

  Future _validateData() async {
    errPassword = await checkPassword(password, 0);
    errNewPassword = await checkPassword(newPassword, 1);
    errConfirmPassword =
        await checkPassword(confirmPassword, 2, passwordCheck: newPassword);
    if (errPassword == null &&
        errConfirmPassword == null &&
        errNewPassword == null) {
      return true;
    }
    return false;
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
