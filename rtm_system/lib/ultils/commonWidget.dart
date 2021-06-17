import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/view/customer/Profile/update_profile.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/customer/notice/all_notices.dart';
import 'package:rtm_system/view/customer/process/process_all_invoice.dart';
import 'package:rtm_system/view/detail_notice.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
import 'package:rtm_system/view/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/login_page.dart';
import 'component.dart';
import 'getData.dart';
import 'helpers.dart';
import 'src/color_ultils.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color buttonBorderColor;
  final List<Widget> children;
  final bool centered;

  StretchableButton({
    @required this.buttonColor,
    @required this.borderRadius,
    @required this.children,
    this.splashColor,
    this.buttonBorderColor,
    this.onPressed,
    this.buttonPadding,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            splashColor: splashColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

//btnMain khong biet de ten gi cho hop ly
// Dung cho 'Cap nhat gia', 'Don cho xu ly', 'Tao thong bao'
Widget btnMain(BuildContext context, double width, String tittle, Icon icon,
    Widget widget) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: button_color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 3,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        height: 35.0,
        width: width,
        child: Row(children: [
          Container(
              padding: EdgeInsets.only(left: 5),
              height: size.height,
              child: icon),
          Expanded(
              child: Container(
            height: size.height,
            child: Center(
                child: AutoSizeText(
              "$tittle",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            )),
          ))
        ]),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: width,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => widget));
          },
          child: null,
        ),
      ),
    ],
  );
}

Widget btnDateTime(
    BuildContext context, String tittle, Icon icon, Widget widget) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: buttonDate_color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: 120,
        child: Row(children: [
          Container(
              padding: EdgeInsets.only(left: 5),
              height: size.height,
              child: icon),
          Expanded(
              child: Container(
            height: size.height,
            child: Center(
                child: AutoSizeText(
              "$tittle",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
          ))
        ]),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(color: Colors.black, width: 0.5),
          ),
          height: 35.0,
          width: 120,
          child: widget),
    ],
  );
}

//Dùng cho show All customer
Widget boxForCustomer(
    {BuildContext context,
    String name,
    String phone,
    bool vip,
    int status,
    int advance,
    Widget widget}) {
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(1, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: colorHexa("AEDFD4"),
                      child: Icon(
                        Icons.person_outline_sharp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          name,
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          phone,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              miniContainer(
                context: context,
                borderRadius: 5,
                height: 30,
                width: 100,
                colorContainer: Colors.white,
                colorText: Colors.black,
                fontWeightText: FontWeight.w500,
                marginRight: 10,
                tittle: "${getVip(vip)}",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              miniContainer(
                context: context,
                borderRadius: 5,
                height: 30,
                width: 130,
                colorContainer: getColorStatus(status: status),
                colorText: Colors.white,
                fontWeightText: FontWeight.w500,
                marginLeft: 10,
                tittle: "${getStatus(status: status)}",
              ),
              Expanded(child: SizedBox()),
              miniContainer(
                context: context,
                borderRadius: 5,
                height: 30,
                width: 100,
                colorContainer: colorHexa("#FF8F84"),
                colorText: Colors.white,
                fontWeightText: FontWeight.w500,
                marginRight: 10,
                tittle: "Nợ: $advance",
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

//Dùng cho trang Quản lý hóa đơn và để show các hóa đơn
Widget boxForInvoice(
    {BuildContext context,
    int id,
    String name,
    String product,
    String total,
    String date,
    int status,
    Widget widget,
    bool isCustomer,
    bool isRequest}) {
  String totalAfterFormat;
  String dateAfterFormat;
  String titlePrice;
  isRequest ? titlePrice = 'Giá' : titlePrice = 'Tổng cộng';
  try {
    totalAfterFormat = "${getFormatPrice(total)}đ";
    dateAfterFormat = "${getDateTime(date)}";
  } catch (_) {
    totalAfterFormat = "$total";
    dateAfterFormat = "$date";
  }
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(1, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              miniContainer(
                context: context,
                tittle: "Mã #$id",
                marginRight: 5,
                marginBottom: 5,
                marginLeft: 10,
                marginTop: 10,
                borderRadius: 5,
                height: 30,
                colorContainer: colorHexa("#f9ee75"),
                paddingRightOfText: 10,
                paddingLeftOfText: 10,
              ),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "$dateAfterFormat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (!isCustomer)
            containerTextInvoice(
              alignment: Alignment.topLeft,
              paddingLeftOfText: 10,
              paddingRightOfText: 10,
              tittle: name,
              fontWeight: FontWeight.w700,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isCustomer
                        ? containerTextInvoice(
                            marginTop: 2,
                            alignment: Alignment.topLeft,
                            paddingLeftOfText: 10,
                            paddingRightOfText: 10,
                            tittle: "$product",
                            fontWeight: FontWeight.w700,
                          )
                        : containerTextInvoice(
                            marginTop: 2,
                            alignment: Alignment.topLeft,
                            paddingLeftOfText: 10,
                            paddingRightOfText: 10,
                            tittle: "Sản phẩm: $product",
                            fontWeight: FontWeight.w400,
                          ),
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "$titlePrice: $totalAfterFormat",
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              miniContainer(
                context: context,
                tittle: "${getStatus(status: status)}",
                colorText: Colors.white,
                fontWeightText: FontWeight.w500,
                height: 30,
                width: 100,
                colorContainer: getColorStatus(status: status),
                borderRadius: 5,
                marginRight: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}

//Dùng cho trang Quản lý hóa đơn và để show các hóa đơn
Widget boxForProduct(
    {BuildContext context,
    int id,
    String productName,
    String typeOfProduct,
    String price,
    String date,
    Widget widget}) {
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(1, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              miniContainer(
                context: context,
                tittle: "Mã #$id",
                marginRight: 5,
                marginBottom: 5,
                marginLeft: 10,
                marginTop: 10,
                borderRadius: 5,
                height: 30,
                colorContainer: colorHexa("#f9ee75"),
                paddingRightOfText: 10,
                paddingLeftOfText: 10,
              ),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "${getDateTime(date, dateFormat: "dd/MM/yyyy")}",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: productName,
                      fontWeight: FontWeight.w700,
                    ),
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Loại: $typeOfProduct",
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              miniContainer(
                tittle: "${getFormatPrice(price)}đ",
                colorText: Colors.black87,
                fontWeightText: FontWeight.w500,
                fontSize: 16,
                height: 30,
                width: 100,
                colorContainer: Colors.white,
                borderRadius: 5,
                marginRight: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}

//Dùng cho trang notice để hiện thỉ các notice
Widget containerButton(
    BuildContext context, int id, String tittle, String content, String date) {
  var size = MediaQuery.of(context).size;

  return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Material(
        color: Colors.white,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black, // foreground
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailOfNotice(
                        noticeId: id,
                        titleNotice: tittle,
                        contentNotice: content,
                      )),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: size.width * 0.93,
                    child: AutoSizeText(
                      "$tittle",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "$content",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "${getDateTime(date)}",
                style: TextStyle(
                  fontSize: 12,
                  color: welcome_color,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 9,
              ),
              SizedBox(
                height: 0.5,
                child: Container(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ));
}

//Hiện tại đang dùng cho trang "Profile"
Widget buttonProfile(BuildContext context, double left, double right,
    double top, double bottom, String tittle, Widget widget) {
  return Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    //Nếu dùng "GestureDetector" thì click sẽ không tạo ra hiệu ứng button
    //Nếu muốn tạo hiệu ứng button có thể dùng FlatButton hoặc RaiseButton
    child: GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget)),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  tittle,
                  style: TextStyle(color: Colors.black54),
                )),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black54,
                  size: 15,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.black45,
            height: 1,
          ),
        ],
      ),
    ),
  );
}
// design Notice bên customer, giống containerButton

// Dùng cho đăng xuất, xóa thông tin.
Widget btnLogout(context) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    width: 140,
    child: Center(
      child: TextButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          print('Data Login đã xóa');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage("images/exit.png"),
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [Text('     ')],
            ),
            Column(
              children: [
                Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget btnUpdateInfo(
    context,
    String cmnd,
    String password,
    String fullname,
    int gender,
    String phone,
    DateTime birthday,
    String address,
    bool check,
    int accountId) {
  return Container(
    width: 320,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: Color(0xFF0BB791),
      onPressed: () {
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
      child: Text(
        'Cập nhật thông tin',
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

//dung khi thay doi pw
Widget btnUpdatePw(context, String password, int accountId, bool isCustomer) {
  return Container(
    width: 320,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: Color(0xFF0BB791),
      onPressed: () {
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
      child: Text(
        'Thay đổi mật khẩu',
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

//Widget này dùng cho các button "Tạo" hoặc "Hủy" vd: ở Trang Tạo thông báo
//bool action = flase khi nhấn nút "Hủy" và bằng true khi nhấn "Tạo"

Widget btnSubmitOrCancel(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    String mainTittle,
    String content,
    String txtError,
    bool action,
    int indexOfBottomBar,
    bool isCustomer,
    String messageShow) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    // ignore: deprecated_member_use
    child: FlatButton(
        onPressed: () async {
          if (action) {
            if (mainTittle == "") {
              showStatusAlertDialog(context, txtError, null, false);
            } else {
              int status = await postAPINotice(mainTittle, content);
              if (status == 200) {
                showCustomDialog(context, isSuccess: true, content: "Tạo thành công",doPopNavigate: true);
              } else
                showCustomDialog(context, isSuccess: false, content:  "Tạo thất bại. Xin thử lại",doPopNavigate: true);
            }
          } else {
            if (isCustomer) {
              showAlertDialog(
                  context,
                  messageShow,
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ));
            } else {
              showAlertDialog(
                  context,
                  messageShow,
                  HomeAdminPage(
                    index: indexOfBottomBar,
                  ));
            }
          }
        },
        child: Center(
            child: Text(
          tittleButtonAlertDialog,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ))),
  );
}

// chấp nhận hoặc từ chối hóa đơn
Widget btnAcceptOrReject(BuildContext context, double width, Color color,
    String tittleButtonAlertDialog, bool action, int indexOfBottomBar) {
  return Container(
      child: SizedBox(
    width: width,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () async {
        if (action) {
          int status = 200;
          // await postAPINotice(mainTittle, content);
          // gọi api trả lại gì đó khi chấp nhận hoặc từ chối
          if (status == 200) {
            //chở lại trang all invoice
            if (tittleButtonAlertDialog == 'Từ chối') {
              showStatusAlertDialog(
                  context,
                  "Đã từ chối thông tin.",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ),
                  true);
            } else {
              showStatusAlertDialog(
                  context,
                  "Đã xác nhận thông tin.",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ),
                  true);
            }
          } else
            showStatusAlertDialog(context, "Xác nhận thất bại", null, false);
        } else {
          //chở lại trang all invoice
          showAlertDialog(
              context,
              "Từ chối xác nhận thông tin?",
              HomeCustomerPage(
                index: indexOfBottomBar,
              ));
        }
      },
      child: Center(
        child: Text(
          tittleButtonAlertDialog,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    ),
  ));
}

// Đang dùng cho các trang detail "Sản phẩm", "Hóa đơn", "Ứng tiền", "Khách hàng"
Widget containerDetail(BuildContext context, Widget widget) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, bottom: 50),
    width: size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 4,
          offset: Offset(1, 2), // Shadow position
        ),
      ],
    ),
    child: widget,
  );
}

Widget btnWaitingProcess(context, bool isInvoice) {
  return SizedBox(
    width: 130,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: Color(0xFFF8D375),
      onPressed: () {
        isInvoice
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProcessAllPage(
                          isInvoice: isInvoice,
                        )),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProcessAllPage(
                          isInvoice: false,
                        )),
              );
      },
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.access_time_outlined),
            ],
          ),
          Column(
            children: [Text('  ')],
          ),
          Column(
            children: [
              Text(
                'Chờ xử lý',
                style: TextStyle(),
              ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
    ),
  );
}

//Đang dùng cho nút hủy kích hoạt tài khoản khách hàng
Widget btnDeactivateCustomer(
    {String status,
    int deactivateId,
    String token,
    BuildContext context,
    bool isDeactivateNotice}) {
  if (status != "Không hoạt động") {
    return Container(
      width: 160,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          if (status != "Không hoạt động") {
            showAlertDialog(
                context,
                isDeactivateNotice == null
                    ? "Bạn muốn hủy kích hoạt khách hàng"
                    : "Bạn muốn ẩn thông báo ?",
                isDeactivateNotice == null
                    ? AllCustomer()
                    : HomeAdminPage(index: 3),
                isDeactivate: true,
                token: token,
                deactivateId: deactivateId,
                isDeactivateNotice: isDeactivateNotice);
          }
        },
        child: AutoSizeText(
          isDeactivateNotice == null ? "Hủy kích hoạt" : "Ẩn thông báo",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  } else {
    return Container();
  }
}
