import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'customer/Profile/upgrade_account.dart';
import 'manager/profile/confirm_create_customer.dart';

//check: true là cho customer còn false là cho manager

// ignore: must_be_immutable, camel_case_types
class formUpdateProfile extends StatefulWidget {
  String fullname, phone, cmnd, address, password, accountId;
  int gender;
  DateTime birthday;
  final bool check, isCreate, isUpgrade;
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
      this.isUpgrade,
      this.list});

  @override
  _formUpdateProfileState createState() => _formUpdateProfileState();
}

enum GenderCharacter { women, men }

// ignore: camel_case_types
class _formUpdateProfileState extends State<formUpdateProfile> {
  String errFullName, errPhone, errCMND, errAddress, errUser, errPass, errBirth, errConfirmPassword;
  GenderCharacter character;
  bool checkClick;
  String messageCancel = '', confirmPassword;
  int indexOfBottomBar = 0;
  @override
  void initState() {
    super.initState();
    checkClick = widget.isCreate ? true : false;
    if (this.widget.gender == 0) {
      character = GenderCharacter.women;
    } else
      character = GenderCharacter.men;
    if (this.widget.isUpdate) {
      messageCancel = 'Bạn muốn huỷ cập nhật thông tin?';
    } else
      messageCancel = 'Bạn muốn huỷ tạo khách hàng?';
    if (widget.check) {
      indexOfBottomBar = 0;
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
              if (!widget.isCustomer)
                _txtfield(
                    getDataTextField(this.widget.phone),
                    false,
                    "Nhập số điện thoại",
                    "Số điện thoại",
                    errPhone,
                    1,
                    TextInputType.phone),
              _checkPassword(),
              _checkConfirmPassword(),
              radioButton(context),
              btnBirthday(context),
              _checkCMND(),
              _checkAddress(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (!widget.isUpgrade)
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
                    getDataCustomer(2, getDateTime("$date", dateFormat: "yyyy-MM-dd"));
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
                currentTime: widget.birthday,
                maxTime: DateTime(DateTime.now().year, 12, 31),
                minTime: DateTime(DateTime.now().year - 111),
                locale: LocaleType.vi,
              );
            },
            child: Row(
              children: [
                Container(
                  width: 100,
                  margin: widget.isUpgrade
                      ? EdgeInsets.only(left: 5)
                      : EdgeInsets.only(left: 15),
                  child: AutoSizeText(
                    "Ngày sinh",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.birthday == null ? "Không bắt buộc" : getDateTime("${this.widget.birthday}", dateFormat: "dd/MM/yyyy")}',
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.birthday == null
                            ? Colors.black45
                            : Colors.black87),
                  ),
                ),
                Container(
                  child: widget.isUpgrade ? null : Container(
                    width: 70,
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.black45,
                    ),
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
              margin: widget.isUpgrade
                  ? EdgeInsets.only(left: 0)
                  : EdgeInsets.only(left: 10, right: 10),
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
      margin: widget.isUpgrade
          ? EdgeInsets.only(top: 4)
          : EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        obscureText: obscureText,
        inputFormatters: [
          if (tittle == "Số điện thoại" || tittle == "CMND/CCCD") FilteringTextInputFormatter.allow(RegExp(r'[[0-9]')),
        ],
        onChanged: (value) {
          if (tittle == "Số điện thoại") {
            this.widget.phone = value.trim();
          } else if (tittle == "CMND/CCCD") {
            this.widget.cmnd = value.trim();
            getDataCustomer(3, value.trim());
          } else if (tittle == "Mật khẩu") {
            this.widget.password = value.trim();
          }else if (tittle == "Xác nhận") {
            confirmPassword = value.trim();
            // "Xác nhận"
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
        onSubmitted: (value) {
          setState(() {
            if (tittle == "Số điện thoại") {
              errPhone = checkPhoneNumber(widget.phone);
            } else if (tittle == "CMND/CCCD" && !widget.isCreate ||
                tittle == "CMND/CCCD" && value.isNotEmpty) {
              errCMND = checkCMND(widget.cmnd);
              getErrorDataCustomer(3, errCMND);
            } else if (tittle == "Mật khẩu") {
              if (widget.isUpdate) {
                errPass = null;
              } else {
                errPass = checkPassword(widget.password, 1);
              }
            }else if (tittle == "Xác nhận") {
              if (widget.isUpdate) {
                errConfirmPassword = null;
              } else {
                errConfirmPassword = checkPassword(widget.password, 2, passwordCheck: confirmPassword);
              }
            }
            if (tittle == "CMND/CCCD" && value.isEmpty && widget.isCreate) {
              errCMND = null;
              getErrorDataCustomer(3, errCMND);
            }
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
          suffixIcon: widget.isUpgrade ? null : Icon(
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
      margin: widget.isUpgrade
          ? null
          : EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        onChanged: (value) {
          if (tittle == "Họ và tên") {
            this.widget.fullname = value.trim();
            getDataCustomer(0, value.trim());
          } else if (tittle == "Địa chỉ") {
            this.widget.address = value.trim();
            getDataCustomer(4, value.trim());
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
        onFieldSubmitted: (value) {
          setState(() {
            if (tittle == "Họ và tên") {
              errFullName = checkFullName(context, widget.fullname);
              getErrorDataCustomer(0, errFullName);
            } else if (tittle == "Địa chỉ" && !widget.isCreate ||
                tittle == "Địa chỉ" && value.isNotEmpty) {
              errAddress = checkAddress(widget.address);
              getErrorDataCustomer(4, errAddress);
            }
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
          suffixIcon: widget.isUpgrade ? null : Icon(
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
      padding: widget.isUpgrade
          ? EdgeInsets.only(top: 0)
          : EdgeInsets.only(top: 0, right: 10),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                child: widget.isUpgrade ? null : Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  margin: EdgeInsets.only(top: 10, right: 0),
                  width: 85,
                  height: 50,
                      child: AutoSizeText("Giới tính",
                          style: TextStyle(fontWeight: FontWeight.w500, )),
                ),
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
                      getDataCustomer(1, value == GenderCharacter.men ? 1: 0);
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
              Flexible(
                child: Container(
                  height: 50,
                  child: RadioListTile<GenderCharacter>(
                    activeColor: welcome_color,
                    title:  AutoSizeText('Nữ'),
                    value: GenderCharacter.women,
                    groupValue: character,
                    onChanged: (GenderCharacter value) {
                      setState(() {
                        getDataCustomer(1, value == GenderCharacter.men ? 1: 0);
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
              margin: widget.isUpgrade
                  ? EdgeInsets.only(top: 0)
                  : EdgeInsets.only(left: 10),
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
          onPressed: () async {
            bool check = await _validateData();
            setState(() {
              if (checkClick) {
                if (check) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmCreateCustomer(
                            listCustomer: listCustomer,
                            check: checkProfile,
                            isCustomer: this.widget.isCustomer,
                            accountId: this.widget.accountId,
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

  Future _validateData() async {
    errFullName = await checkFullName(context, widget.fullname);
    errPhone = await checkPhoneNumber(widget.phone);
    if (!widget.isCreate) {
      if (this.widget.check == true) {
        errCMND = await checkCMND(widget.cmnd);
        errAddress = await checkAddress(widget.address);
      }
    }
    if (widget.isUpdate) {
      errPass = null;
      errConfirmPassword = null;
    } else {
      errPass = checkPassword(widget.password, 1);
      errConfirmPassword = checkPassword(widget.password, 2, passwordCheck: confirmPassword);
    }

    if (errFullName == null &&
        errPhone == null &&
        errPass == null &&
        errConfirmPassword == null &&
        errBirth == null &&
        errCMND == null &&
        errAddress == null &&
        errUser == null) {
      return true;
    }
    return false;
  }

  Widget _checkCMND() {
    return this.widget.check
        ? _txtfield(getDataTextField(this.widget.cmnd), false, "Không bắt buộc",
            "CMND/CCCD", errCMND, 1, TextInputType.phone)
        : Container();
  }

  Widget _checkAddress() {
    return this.widget.check
        ? _txtFormField(this.widget.address, false, "Không bắt buộc", "Địa chỉ",
            errAddress, 1, TextInputType.streetAddress)
        : Container();
  }

  Widget _checkPassword() {
    return this.widget.isUpdate
        ? Container()
        : _txtfield(getDataTextField(this.widget.password), true,
            "Nhập mật khẩu", "Mật khẩu", errPass, 1, TextInputType.text);
  }

  Widget _checkConfirmPassword() {
    return this.widget.isUpdate
        ? Container()
        : _txtfield(getDataTextField(confirmPassword), true,
        "Nhập lại mật khẩu", "Xác nhận", errConfirmPassword, 1, TextInputType.text);
  }
  void getDataCustomer(int index, value){
    if(widget.isUpgrade) {
      dataCustomer.removeAt(index);
      dataCustomer.insert(index, value);
    }
  }

  void getErrorDataCustomer(int index, value){
    if(widget.isUpgrade) {
      errorData.removeAt(index);
      errorData.insert(index, "$value");
    }
  }
}
