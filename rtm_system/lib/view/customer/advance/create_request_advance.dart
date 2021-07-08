import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rtm_system/model/get/getAPI_allStore.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'package:rtm_system/view/customer/advance/confirm_create_request_advance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRequestAdvance extends StatefulWidget {
  @override
  _CreateRequestAdvanceState createState() => _CreateRequestAdvanceState();
}

final _formKey = GlobalKey<FormState>();

class _CreateRequestAdvanceState extends State<CreateRequestAdvance> {
  String money;
  DateTime createDate;
  List listInfor;
  Store store;
  List<StoreElement> dataListStore;
  String _myStore, reason = '';
  // File _image;

  @override
  void initState() {
    setState(() {
      createDate = DateTime.now();
    });
    _getStore();
  }

  Future _getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAPIAllStore getAPIAllStore = GetAPIAllStore();
    store = await getAPIAllStore.getStores(
      prefs.get("access_token"),
      1000,
      1,
    );
    dataListStore = store.stores;
    setState(() {
      if (dataListStore.length == 1) {
        _myStore = dataListStore[0].id;
      }
    });
    return dataListStore;
  }

  // //get image from camera
  // _imageFromCamera() async {
  //   PickedFile image = await ImagePicker()
  //       .getImage(source: ImageSource.camera, imageQuality: 50);
  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   }
  // }

  // //get image from gallery
  // _imageFromGallery() async {
  //   PickedFile image = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, imageQuality: 50);
  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   }
  // }

  // // show option choice camera or gallery
  // void showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //             child: Wrap(
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Gallery'),
  //               onTap: () {
  //                 _imageFromGallery();
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.camera_alt),
  //               title: Text('Camera'),
  //               onTap: () {
  //                 _imageFromCamera();
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         ));
  //       });
  // }

  //Hiện tại khi nhập giá tiền mà k outFocus mà chọn camera thì keyboard vẫn show,
  //và k tắt được, có lẽ nên đổi keyboard. Tuy nhiên keyboard_actions k gọi dk KeyboardActions.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          "Tạo yêu cầu ứng tiền",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 50, bottom: 24),
            child: Column(
              children: [
                _dropdownListStore(),
                SizedBox(
                  height: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: size.width,
                    color: Colors.black45,
                  ),
                ),
                Column(
                  children: [
                    _formMoney(false, "Nhập số tiền VND", "Số tiền",
                        TextInputType.number),
                    _txtFormField('', false, "Nhập lý do ứng tiền ", "Lý do", 1,
                        TextInputType.text),
                    SizedBox(
                      height: 10,
                    ),
                    btnDateSale(context),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   child: Column(
                //     children: [
                //       btnImage(context, size.width * 0.9, size.height * 0.1),
                //       showImage(size.width, size.height, _image),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmCreateRequestAdvance(
                        listInfor: listInfor,
                        storeId: _myStore,
                        isCustomer: true,
                        type: 1,
                      )),
            );
          }
        },
        label: Text(
          'Tạo mới',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 10,
      ),
    );
  }

  Widget _dropdownListStore() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            margin: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _myStore,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text('Chon cửa hàng'),
                  onChanged: (String newValue) async {
                    setState(() {
                      _myStore = newValue;
                    });
                  },
                  items: dataListStore?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          //chuyen id de create
                          value: item.id.toString(),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//show hinh anh da chon , có setState nên k tách dk
  // Widget showImage(width, height, image) {
  //   if (image != null) {
  //     setState(() {
  //       this.listInfor = [
  //         this.money,
  //         getDateTime(this.createDate.toString(),
  //             dateFormat: 'yyyy-MM-dd'),
  //         reason
  //       ];
  //     });
  //     return Container(
  //       margin: EdgeInsets.only(top: 12),
  //       width: width,
  //       height: height * 0.3,
  //       child: Image.file(image, fit: BoxFit.scaleDown),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
  // //btn load image
  // Widget btnImage(context, width, height) {
  //   return SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Container(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             AutoSizeText("Thêm hình CMND", style: TextStyle(
  //               fontWeight: FontWeight.w500,
  //             )),
  //             SizedBox(
  //               height: 12,
  //             ),
  //             Container(
  //               width: width,
  //               height: height,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   showPicker(context);

  //                 },
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.camera_alt,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(15)),
  //                     side: BorderSide(color: Color(0xFFcccccc), width: 1),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ));
  // }
  // form để nhập số tiền
  Widget _formMoney(
      bool obscureText, String hintText, String tittle, TextInputType txtType) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return showMessage(tittle, MSG001);
            } else if (!checkFormatMoney.hasMatch(value)) {
              return showMessage('', MSG026);
            } else if (value.length <= 6) {
              // số tiền phải là từ 100 trở lên
              return showMessage('', MSG006);
            }
            return null;
          },
          maxLines: 1,
          keyboardType: txtType,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          obscureText: obscureText,
          onChanged: (value) {
            this.money = value;
            this.listInfor = [
              this.money,
              getDateTime(this.createDate.toString(), dateFormat: 'yyyy-MM-dd'),
              reason
            ];
          },
          // style: TextStyle(fontSize: 16),
          cursorColor: Color(0xFF0BB791),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: '$hintText',
            //Sau khi click vào "Nhập so tien" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF0BB791),
              ),
            ),

            //Hiển thị text góc phải
            prefixIcon: Container(
                margin: EdgeInsets.only(top: 15, left: 5),
                width: size.width * 0.2,
                child: AutoSizeText(
                  "${tittle}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            //Hiển thị Icon góc phải
            suffixIcon: Icon(
              Icons.create,
              color: Colors.black54,
            ),
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }

  //Chọn ngày
  Widget btnDateSale(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    createDate = date;
                    this.listInfor = [
                      this.money,
                      getDateTime(this.createDate.toString(),
                          dateFormat: 'yyyy-MM-dd'),
                      reason
                    ];
                  });
                },
                currentTime: createDate,
                maxTime: DateTime(DateTime.now().year + 100, 12, 31),
                // yêu cầu ứng tiền chỉ từ ngày hiện tại tới tương lai chứ trong quá khứ k có
                minTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
                locale: LocaleType.vi,
              );
            },
            child: Row(
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  child: AutoSizeText(
                    "Ngày ứng tiền",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    '${getDateTime(createDate.toString(), dateFormat: 'dd-MM-yyyy')}',
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

  //form reason is can NULL
  Widget _txtFormField(String value, bool obscureText, String hintText,
      String tittle, int maxLines, TextInputType txtType) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        onChanged: (value) {
          setState(() {
            reason = value;
            this.listInfor = [
              this.money,
              getDateTime(this.createDate.toString(), dateFormat: 'yyyy-MM-dd'),
              reason
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
              width: size.width * 0.2,
              child: AutoSizeText(
                "${tittle}",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),

          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.create,
            color: Colors.black54,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
