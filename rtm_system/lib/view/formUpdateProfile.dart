import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/regExp.dart';

import 'manager/profile/confirmCreateCustomer.dart';

//check: true là cho customer còn false là cho manager

class formUpdateProfile extends StatefulWidget {
  String fullname, phone, cmnd, address, password;
  int gender;
  DateTime birthday;
  final bool check;
  List list;
  formUpdateProfile(
      {this.fullname,
      this.phone,
      this.cmnd,
      this.address,
      this.password,
      this.birthday,
      this.gender,
      this.check,
      this.list});

  @override
  _formUpdateProfileState createState() => _formUpdateProfileState();
}

enum GenderCharacter { women, men }

class _formUpdateProfileState extends State<formUpdateProfile> {
  final f = new DateFormat('dd/MM/yyyy');
  String errFulname, errPhone, errCMND, errAddress, errUser, errPass, errBirth;
  GenderCharacter character;
  bool checkClick = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (this.widget.gender == 0) {
      character = GenderCharacter.women;
    } else
      character = GenderCharacter.men;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              _txtfield(
                  getDataTextField(this.widget.fullname),
                  false,
                  "Nhập họ tên",
                  "Họ và tên",
                  errFulname,
                  1,
                  TextInputType.text),
              _txtfield(
                  getDataTextField(this.widget.phone),
                  false,
                  "Nhập số điện thoại",
                  "Số điện thoại",
                  errPhone,
                  1,
                  TextInputType.phone),
              _checkPassword(),
              radioButton(context),
              btnBirthday(context),
              _checkCMND(),
              _checkAddress(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btnSubmitOrCancel(context, 120, 40, Colors.redAccent, "Hủy", "",
                  "", null, false, 4),
              SizedBox(width: 20),
              btnSubmitValidate(
                  context, 120, 40, welcome_color, "Kiểm tra", this.widget.list, this.widget.check),
            ],
          ),
        ],
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

  Widget btnBirthday(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    this.widget.birthday = date;
                    this.widget.list = [
                      this.widget.fullname,
                      character.index,
                      this.widget.phone,
                      this.widget.cmnd,
                      this.widget.address,
                      this.widget.password,
                      this.widget.birthday
                    ];
                  });
                },
                currentTime: this.widget.birthday,
                maxTime: DateTime(DateTime.now().year, 12, 31),
                minTime: DateTime(DateTime.now().year - 111),
                locale: LocaleType.vi,
              );
            },
            child: Row(
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  child: AutoSizeText(
                    "Ngày sinh",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${f.format(this.widget.birthday)}',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
                Container(
                  width: 70,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 1,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: size.width,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _txtfield(
      TextEditingController _controller,
      bool obscureText,
      String hintText,
      String tittle,
      String error,
      int maxLines,
      TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        obscureText: obscureText,
        onChanged: (value) {
          if (tittle == "Họ và tên") {
            this.widget.fullname = value.trim();
          } else if (tittle == "Số điện thoại") {
            this.widget.phone = value.trim();
          } else if (tittle == "CMND/CCCD") {
            this.widget.cmnd = value.trim();
          } else if (tittle == "Địa chỉ") {
            this.widget.address = value.trim();
          } else if (tittle == "Mật khẩu") {
            this.widget.password = value.trim();
          }
          setState(() {
            checkClick = true;
            this.widget.list = [
              this.widget.fullname,
              character.index,
              this.widget.phone,
              this.widget.cmnd,
              this.widget.address,
              this.widget.password,
              this.widget.birthday
            ];
          });
        },
        maxLines: maxLines,
        keyboardType: txtType,
        style: TextStyle(fontSize: 15),
        cursorColor: welcome_color,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '$hintText',

          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: welcome_color),
          ),

          //Hiển thị text góc phải
          prefixIcon: Container(
              margin: EdgeInsets.only(top: 15, left: 5),
              width: 100,
              child: AutoSizeText(
                "${tittle}",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),

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

  // Chọn giới tính
  Widget radioButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 10),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 0),
                width: 85,
                height: 50,
                child: Center(
                    child: Text("Giới tính",
                        style: TextStyle(fontWeight: FontWeight.w500))),
              ),
              Container(
                height: 50,
                width: 130,
                child: RadioListTile<GenderCharacter>(
                  activeColor: welcome_color,
                  title: const AutoSizeText(
                    'Nam',
                    style: TextStyle(fontSize: 15),
                  ),
                  value: GenderCharacter.men,
                  groupValue: character,
                  onChanged: (GenderCharacter value) {
                    setState(() {
                      character = value;
                      this.widget.list = [
                        this.widget.fullname,
                        character.index,
                        this.widget.phone,
                        this.widget.cmnd,
                        this.widget.address,
                        this.widget.password,
                        this.widget.birthday
                      ];
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: RadioListTile<GenderCharacter>(
                    activeColor: welcome_color,
                    title: const AutoSizeText('Nữ'),
                    value: GenderCharacter.women,
                    groupValue: character,
                    onChanged: (GenderCharacter value) {
                      setState(() {
                        character = value;
                        this.widget.list = [
                          this.widget.fullname,
                          character.index,
                          this.widget.phone,
                          this.widget.cmnd,
                          this.widget.address,
                          this.widget.password,
                          this.widget.birthday
                        ];
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 0),
              width: size.width,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget btnSubmitValidate(BuildContext context, double width, double height,
      Color color, String tittleButtonAlertDialog, List listCustomer, bool checkProfile) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              bool check = _validateData();
              if (checkClick) {
              if (check) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ConfirmCreateCustomer(listCustomer: listCustomer, check: checkProfile,)));
              }}else{
                if(checkProfile == false){
                  showStatusAlertDialog(
                      context, "Thông tin chưa thay đổi !!!", null, false);
                }
              }
            });
          },
          child: Center(
            child: Text(
              tittleButtonAlertDialog,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }

  bool _validateData() {
    bool check = false;
    if (this.widget.fullname == null || this.widget.fullname == "") {
      errFulname = "Họ và tên trống";
    } else {
      // if (!checkFormatFullname.hasMatch(fullname)) {
      //   errFulname = "Họ tên chỉ nhập chữ";
      // } else {
      errFulname = null;
      // }
    }
    if (this.widget.phone == null || this.widget.phone == "") {
      errPhone = "Số điện thoại trống";
    } else {
      try {
        int parseInt = int.parse(this.widget.phone);
        if (!checkFormatPhone.hasMatch(this.widget.phone) ||
            this.widget.phone.length > 11) {
          errPhone = "Số điện thoại sai (10-11 só)";
        } else {
          errPhone = null;
        }
      } catch (_) {
        errPhone = "Số điện thoại chỉ nhập số";
      }
    }
    if (this.widget.cmnd == null || this.widget.cmnd == "") {
      errCMND = "CMND/CCCD trống";
    } else {
      //Lỗi RegExp nên không dùng nó mà dùng try-catch
      try {
        int parseInt = int.parse(this.widget.cmnd);
        if (this.widget.cmnd.length < 9 || this.widget.cmnd.length > 12) {
          errCMND = "CMND/CCCD sai";
        } else {
          errCMND = null;
        }
      } catch (_) {
        errCMND = "CMND/CCCD chỉ nhập số";
      }
    }
    if (this.widget.address == null || this.widget.address == "") {
      errAddress = "Địa chỉ trống";
    } else {
      errAddress = null;
    }
    if (this.widget.password == null || this.widget.password == "") {
      errPass = "Mật khẩu trống";
    } else {
      if (!checkFormatPassword.hasMatch(this.widget.password)) {
        errPass = "Mật khẩu ít nhất 6 kí tự (chữ và số)";
      } else {
        errPass = null;
      }
    }
    if (errFulname == null &&
        errPhone == null &&
        errPass == null &&
        errBirth == null &&
        errCMND == null &&
        errAddress == null &&
        errUser == null) {
      check = true;
    }
    return check;
  }

  Widget _checkCMND() {
    if (this.widget.check) {
      return _txtfield(getDataTextField(this.widget.cmnd), false,
          "Nhập CMND/CCCD", "CMND/CCCD", errCMND, 1, TextInputType.phone);
    } else
      return Container();
  }

  Widget _checkAddress() {
    if (this.widget.check) {
      return _txtfield(
          getDataTextField(this.widget.address),
          false,
          "Nhập địa chỉ",
          "Địa chỉ",
          errAddress,
          1,
          TextInputType.streetAddress);
    } else
      return Container();
  }

  Widget _checkPassword() {
    if (this.widget.check) {
      return _txtfield(getDataTextField(this.widget.password), true,
          "Nhập mật khẩu", "Mật khẩu", errPass, 1, TextInputType.text);
    } else
      return Container();
  }
}
