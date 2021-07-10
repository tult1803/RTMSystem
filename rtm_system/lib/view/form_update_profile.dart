import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'manager/profile/confirm_create_customer.dart';

//check: true là cho customer còn false là cho manager

// ignore: must_be_immutable, camel_case_types
class formUpdateProfile extends StatefulWidget {
  String fullname, phone, cmnd, address, password, accountId;
  int gender;
  DateTime birthday;
  final bool check, isCreate;
  final int typeOfUpdate;

  // True là sẽ gọi api update, false là gọi api createCustomer
  final bool isUpdate, isCustomer;
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
      this.isCreate,
      this.isUpdate,
      this.typeOfUpdate,
      this.accountId,
      this.isCustomer,
      this.list});

  @override
  _formUpdateProfileState createState() => _formUpdateProfileState();
}

enum GenderCharacter { women, men }

// ignore: camel_case_types
class _formUpdateProfileState extends State<formUpdateProfile> {
  String errFullName, errPhone, errCMND, errAddress, errUser, errPass, errBirth;
  GenderCharacter character;
  bool checkClick = false;
  String messageCancel = '';
  int indexOfBottomBar = 0;

  @override
  void initState() {
    super.initState();

    if (this.widget.gender == 0) {
      character = GenderCharacter.women;
    } else
      character = GenderCharacter.men;
    if (this.widget.isUpdate) {
      messageCancel = 'Bạn muốn huỷ cập nhật thông tin?';
    } else
      messageCancel = 'Bạn muốn huỷ tạo khách hàng?';
    if (widget.check) {
      indexOfBottomBar = 3;
    } else {
      indexOfBottomBar = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              _txtFormField(this.widget.fullname, false, "Nhập họ tên",
                  "Họ và tên", errFullName, 1, TextInputType.text),
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
              btnSubmitOrCancel(
                  context,
                  120,
                  40,
                  Colors.redAccent,
                  "Hủy",
                  "",
                  "",
                  null,
                  false,
                  indexOfBottomBar,
                  this.widget.isCustomer,
                  messageCancel),
              SizedBox(width: 20),
              btnSubmitValidate(context, 120, 40, welcome_color, "Kiểm tra",
                  this.widget.list, this.widget.check,
                  isCreate: this.widget.isCreate),
            ],
          ),
        ],
      ),
    );
  }

  //Dùng để chặn nhập khoản cách
  TextEditingController getDataTextField(String txt) {
    final TextEditingController _controller = TextEditingController();
    if (txt != null) {
      _controller.value = _controller.value.copyWith(
        text: txt,
        selection:
            TextSelection(baseOffset: txt.length, extentOffset: txt.length),
        composing: TextRange.empty,
      );
    }
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
                    checkClick = true;
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
                    '${getDateTime("${this.widget.birthday}", dateFormat: "dd/MM/yyyy")}',
                    style: TextStyle(fontSize: 16),
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

  Widget _txtFormField(String value, bool obscureText, String hintText,
      String tittle, String error, int maxLines, TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        initialValue: value,
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
                      checkClick = true;
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
                        this.checkClick = true;
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

  Widget btnSubmitValidate(
      BuildContext context,
      double width,
      double height,
      Color color,
      String tittleButtonAlertDialog,
      List listCustomer,
      bool checkProfile,
      {bool isCreate}) {
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
              if (checkClick) {
                if (check) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmCreateCustomer(
                            listCustomer: listCustomer,
                            check: checkProfile,
                            isCustomer: this.widget.isCustomer,
                            account_id: this.widget.accountId,
                            isUpdate: this.widget.isUpdate,
                            typeOfUpdate: this.widget.typeOfUpdate,
                            isCreate: isCreate,
                          )));
                }
              } else {
                showStatusAlertDialog(
                    context, "Thông tin chưa thay đổi !!!", null, false);
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
      errFullName = "Họ và tên trống";
    } else {
      errFullName = null;
    }
    if (this.widget.phone == null || this.widget.phone == "") {
      errPhone = "Số điện thoại trống";
    } else {
      try {
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
    if (this.widget.check == true) {
      if (this.widget.cmnd == null || this.widget.cmnd == "") {
        errCMND = "CMND/CCCD trống";
      } else {
        //Lỗi RegExp nên không dùng nó mà dùng try-catch
        try {
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
    }
    if (widget.isUpdate) {
      errPass = null;
    } else {
      if (this.widget.password == null || this.widget.password == "") {
        errPass = "Mật khẩu trống";
        print("Mật khẩu trống");
      } else {
        if (!checkFormatPassword.hasMatch(this.widget.password)) {
          errPass = "Mật khẩu ít nhất 6 kí tự (chữ và số)";
          print("Mật khẩu ít nhất 6 kí tự (chữ và số)");
        } else {
          errPass = null;
        }
      }
    }
    if (errFullName == null &&
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
    return this.widget.check
        ? _txtfield(getDataTextField(this.widget.cmnd), false, "Nhập CMND/CCCD",
            "CMND/CCCD", errCMND, 1, TextInputType.phone)
        : Container();
  }

  Widget _checkAddress() {
    return this.widget.check
        ? _txtFormField(this.widget.address, false, "Nhập địa chỉ", "Địa chỉ",
            errAddress, 1, TextInputType.streetAddress)
        : Container();
  }

  Widget _checkPassword() {
    return this.widget.isUpdate
        ? Container()
        : _txtfield(getDataTextField(this.widget.password), true,
            "Nhập mật khẩu", "Mật khẩu", errPass, 1, TextInputType.text);
  }
}
