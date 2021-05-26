import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage(
      {Key key,
      this.id,
      this.accountId,
      this.fullname,
      this.birthday,
      this.phone,
      this.gender,
      this.cmnd,
      this.address})
      : super(key: key);
  final int id;
  final String cmnd;
  final int accountId;
  final String fullname;
  final int gender;
  final String phone;
  final String birthday;
  final String address;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String title = "Thông tin cá nhân";
  int selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Container(
            margin: EdgeInsets.only(left: 34),
            child: Text(
              title,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 24, 0, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    btnFullName(context, widget.fullname),
                    radioBtn(context),
                    SizedBox(
                      height: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 40),
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                    btnPhone(context, widget.phone),
                    btnBirthday(context, widget.birthday),
                    SizedBox(
                      height: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 40),
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                    btnCMND(context, widget.cmnd),
                    btnAddress(context, widget.address),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              btnSave(),
            ],
          ),
        )));
  }

  Widget btnSave() {
    return Container(
      width: 320,
      child: RaisedButton(
        color: Color(0xFF0BB791),
        onPressed: () {
          // Gọi API để lưu thông tin
        },
        child: Text(
          'Lưu thông tin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
      ),
    );
  }

  Widget btnFullName(context, valueField) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xFF0BB791)),
      child: TextFormField(
        initialValue: valueField,
        decoration: const InputDecoration(
          focusColor: Colors.red,
          icon: Icon(Icons.person),
          fillColor: Colors.amberAccent,
          hintText: 'Họ và tên',
          labelText: 'Họ và tên',
        ),
        onChanged: (value) {
          setState(() => valueField = value);
          print('Value for field  saved as "$valueField"');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập tên';
          }
          return value;
        },
      ),
    );
  }

  Widget radioBtn(context) {
    return Row(
      children: [
        // Text('Giới tính: ', style: TextStyle( fontSize: 16),),
        ButtonBar(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage("images/gender.png"),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text('Nữ'),
            Radio(
              value: 0,
              groupValue: selectedRadio,
              activeColor: Colors.blue,
              onChanged: (val) {
                print('$val');
                setSelectedRadio(val);
              },
            ),
            SizedBox(
              width: 30,
            ),
            Text('Nam'),
            Radio(
              value: 1,
              groupValue: selectedRadio,
              activeColor: Colors.blue,
              onChanged: (val) {
                print('$val');
                setSelectedRadio(val);
              },
            )
          ],
        ),
      ],
    );
  }

  Widget btnBirthday(context, valueField) {
    DateTime dt = DateTime.parse(valueField);
    final f = new DateFormat('dd-MM-yyyy');
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.black38,
          ),
          FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    dt = date;
                  });
                },
                currentTime: dt,
                maxTime: DateTime(2050),
                minTime: DateTime(2021),
                locale: LocaleType.vi,
              );
            },
            child: Text(
              '${f.format(dt)}',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnPhone(context, valueField) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xFF0BB791)),
      child: TextFormField(
        initialValue: valueField,
        decoration: const InputDecoration(
          icon: Icon(Icons.phone),
          fillColor: Colors.amberAccent,
          hintText: 'Số điện thoại',
          labelText: 'Số điện thoại',
        ),
        onChanged: (value) {
          setState(() => valueField = value);
          print('Value for field  saved as "$valueField"');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập số điện thoại';
          }
          return value;
        },
      ),
    );
  }

  Widget btnCMND(context, valueField) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xFF0BB791)),
      child: TextFormField(
        initialValue: valueField,
        decoration: const InputDecoration(
          icon: Icon(Icons.credit_card),
          fillColor: Colors.amberAccent,
          hintText: 'CMND',
          labelText: 'CMND',
        ),
        onChanged: (value) {
          setState(() => valueField = value);
          print('Value for field  saved as "$valueField"');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập CMND';
          }
          return value;
        },
      ),
    );
  }

  Widget btnAddress(context, valueField) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xFF0BB791)),
      child: TextFormField(
        initialValue: valueField,
        decoration: const InputDecoration(
          icon: Icon(Icons.location_on),
          fillColor: Colors.amberAccent,
          hintText: 'Địa chỉ',
          labelText: 'Địa chỉ',
        ),
        onChanged: (value) {
          setState(() => valueField = value);
          print('Value for field  saved as "$valueField"');
        },
      ),
    );
  }
}
