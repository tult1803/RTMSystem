import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/view/manager/profile/confirmCreateCustomer.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/regExp.dart';

class showCreateCustomer extends StatefulWidget {
  const showCreateCustomer({Key key}) : super(key: key);

  @override
  _showCreateCustomerState createState() => _showCreateCustomerState();
}

enum GenderCharacter { women, men }

class _showCreateCustomerState extends State<showCreateCustomer> {
  final f = new DateFormat('dd/MM/yyyy');
  DateTime birthday = DateTime.parse("${DateTime.now()}");
  String fullname, phone, cmnd, address, password;
  String errFulname, errPhone, errCMND, errAddress, errUser, errPass, errBirth;
  GenderCharacter _character = GenderCharacter.men;
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _txtfield(false, "Nhập họ tên", "Họ và tên", errFulname, 1,
              TextInputType.text),
          _txtfield(false, "Nhập số điện thoại", "Số điện thoại", errPhone, 1,
              TextInputType.phone),
          _txtfield(true, "Nhập mật khẩu", "Mật khẩu", errPass, 1,
              TextInputType.text),
          radioButton(context),
          btnBirthday(context),
          _txtfield(false, "Nhập CMND/CCCD", "CMND/CCCD", errCMND, 1,
              TextInputType.phone),
          _txtfield(false, "Nhập địa chỉ", "Địa chỉ", errAddress, 1,
              TextInputType.streetAddress),
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
                  context, 120, 40, welcome_color, "Kiểm tra", list),
            ],
          ),
        ],
      ),
    );
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
                    birthday = date;
                    list = [
                      fullname,
                      _character.index,
                      phone,
                      cmnd,
                      address,
                      password,
                      birthday
                    ];
                  });
                },
                currentTime: birthday,
                maxTime: DateTime(DateTime.now().year, 12, 31),
                minTime: DateTime(DateTime.now().year-111),
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
                    '${f.format(birthday)}',
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

  Widget _txtfield(bool obscureText, String hintText, String tittle,
      String error, int maxLines, TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        obscureText: obscureText,
        onChanged: (value) {
          if (tittle == "Họ và tên") {
            fullname = value.trim();
          } else if (tittle == "Số điện thoại") {
            phone = value.trim();
          } else if (tittle == "CMND/CCCD") {
            cmnd = value.trim();
          } else if (tittle == "Địa chỉ") {
            address = value.trim();
          } else if (tittle == "Mật khẩu") {
            password = value.trim();
          }
          setState(() {
            list = [
              fullname,
              _character.index,
              phone,
              cmnd,
              address,
              password,
              birthday
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
                  groupValue: _character,
                  onChanged: (GenderCharacter value) {
                    setState(() {
                      _character = value;
                      list = [
                        fullname,
                        _character.index,
                        phone,
                        cmnd,
                        address,
                        password,
                        birthday
                      ];
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: RadioListTile<GenderCharacter>(
                    title: const AutoSizeText('Nữ'),
                    value: GenderCharacter.women,
                    groupValue: _character,
                    onChanged: (GenderCharacter value) {
                      setState(() {
                        _character = value;
                        list = [
                          fullname,
                          _character.index,
                          phone,
                          cmnd,
                          address,
                          password,
                          birthday
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
      Color color, String tittleButtonAlertDialog, List listCustomer) {
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
              // if (!check) {}
              if (check) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ConfirmCreateCustomer(listCustomer = listCustomer)));
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
    if (fullname == null || fullname == "") {
      errFulname = "Họ và tên trống";
    } else {
      // if (!checkFormatFullname.hasMatch(fullname)) {
      //   errFulname = "Họ tên chỉ nhập chữ";
      // } else {
      errFulname = null;
      // }
    }
    if (phone == null || phone == "") {
      errPhone = "Số điện thoại trống";
    } else {
      try {
        int parseInt = int.parse(phone);
        if (!checkFormatPhone.hasMatch(phone) || phone.length > 11) {
          errPhone = "Số điện thoại sai (10-11 só)";
        } else {
          errPhone = null;
        }
      } catch (_) {
        errPhone = "Số điện thoại chỉ nhập số";
      }
    }
    if (cmnd == null || cmnd == "") {
      errCMND = "CMND/CCCD trống";
    } else {
      //Lỗi RegExp nên không dùng nó mà dùng try-catch
      try {
        int parseInt = int.parse(cmnd);
        if (cmnd.length < 9 || cmnd.length > 12) {
          errCMND = "CMND/CCCD sai";
        } else {
          errCMND = null;
        }
      } catch (_) {
        errCMND = "CMND/CCCD chỉ nhập số";
      }
    }
    if (address == null || address == "") {
      errAddress = "Địa chỉ trống";
    } else {
      errAddress = null;
    }
    if (password == null || password == "") {
      errPass = "Mật khẩu trống";
    } else {
      if (!checkFormatPassword.hasMatch(password)) {
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
}
