import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/product/updatePriceProduct_manager.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
import 'component.dart';
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
    BuildContext context, String tittle, Icon icon, Widget widget,
    {Color colorBoxShadow}) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: colorBoxShadow == null ? Colors.black54 : colorBoxShadow,
              blurRadius: 2,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
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

//Dùng cho trang Quản lý hóa đơn và để show các hóa đơn. Dùng cho cả show yêu cầu bán hàng.
// isRequest: true là yêu cầu bán hàng. Thay đổi chữ Tổng cộng thành Giá ( giá này là giá sản phẩm )
//isCustomer : true is customer. Used to show infor need
Widget boxForInvoice(
    {BuildContext context,
    String id,
    String name,
    String product,
    int price,
    double quantity,
    double degree,
    String createDate,
    String activeDate,
    int status,
    Widget widget,
    bool isCustomer,
    bool isRequest}) {
  String dateAfterFormat, dateSellAfterFormat,
      priceAfterFormat, totalAfterFormat;
  double totalAmount = getPriceTotal(double.parse(price.toString()), degree, quantity);
  try {
    priceAfterFormat = "${getFormatPrice("$price")} đ";
    totalAfterFormat = "${getFormatPrice("$totalAmount")} đ";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateSellAfterFormat = "${getDateTime(activeDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {
    priceAfterFormat = "$price";
    dateAfterFormat = "$createDate";
    dateSellAfterFormat = "$activeDate";
  }
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
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
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Mã: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrangeAccent),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  // tittle: status == 2 ? "Đã huỷ" : "Đã gửi",
                  tittle: getStatus(status: status),
                  fontWeight: FontWeight.w600,
                  color: getColorStatus(status: status),
                  // color: status == 2 ? Colors.redAccent : primaryColor,
                ),
              ),
            ],
          ),
          if (!isCustomer)
            SizedBox(
              height: 10,
            ),
          if (!isCustomer)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                containerTextInvoice(
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Khách hàng: ",
                ),
                containerTextInvoice(
                    alignment: Alignment.topRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "$name",
                    fontWeight: FontWeight.w700),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              containerTextInvoice(
                alignment: Alignment.topLeft,
                paddingLeftOfText: 10,
                paddingRightOfText: 10,
                tittle: "Sản phẩm: ",
              ),
              containerTextInvoice(
                  alignment: Alignment.topRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "$product",
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Giá sản phẩm ",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                        alignment: Alignment.topLeft,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "$priceAfterFormat",
                        color: primaryColor),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Thành tiền",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                        alignment: Alignment.centerRight,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "$totalAfterFormat",
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        containerTextInvoice(
                          alignment: Alignment.centerRight,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "Ngày tạo:",
                        ),
                        activeDate != null
                            ? containerTextInvoice(
                                alignment: Alignment.topLeft,
                                paddingLeftOfText: 10,
                                paddingRightOfText: 10,
                                tittle: "$dateSellAfterFormat",
                                fontWeight: FontWeight.w600,
                              )
                            : containerTextInvoice(
                                alignment: Alignment.centerRight,
                                paddingLeftOfText: 10,
                                paddingRightOfText: 10,
                                tittle: "$dateAfterFormat",
                                fontWeight: FontWeight.w600,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              containerTextInvoice(
                  marginTop: 2,
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Xem chi tiết >>",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)
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

//show các yêu cầu ứng tiền
Widget boxForAdvanceRequest(
    {BuildContext context,
    String id,
    String name,
    String storeId,
    String amount,
    String createDate,
    String receiveDate,
    String imageUrl,
    String reason,
    int status,
    Widget widget,
    bool isCustomer}) {
  String dateAfterFormat, dateReceiveAfterFormat, totalAfterFormat;
  try {
    totalAfterFormat = "${getFormatPrice(amount)} đ";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateReceiveAfterFormat =
        "${getDateTime(receiveDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {
    totalAfterFormat = "$amount";
    dateAfterFormat = "$createDate";
    dateReceiveAfterFormat = "$receiveDate";
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
                tittle: id,
                marginRight: 5,
                marginBottom: 5,
                marginLeft: 10,
                marginTop: 10,
                borderRadius: 5,
                height: 30,
                colorContainer: idColor,
                paddingRightOfText: 10,
                paddingLeftOfText: 10,
              ),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Ngày tạo: $dateAfterFormat",
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
          if (isCustomer)
            containerTextInvoice(
              alignment: Alignment.topLeft,
              paddingLeftOfText: 10,
              paddingRightOfText: 10,
              tittle: "Số tiền: $totalAfterFormat",
              fontWeight: FontWeight.w700,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hoá đơn bị từ chối thì show lý do ra thay vì ngày tới
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Ngày tới: $dateReceiveAfterFormat",
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              miniContainer(
                context: context,
                // tittle: "${getStatus(status: status)}",
                tittle: "${getFormatPrice(amount)}đ",
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

//show các yêu cầu ứng tiền
Widget boxForAdvanceOfCustomer({
  BuildContext context,
  String id,
  String name,
  String storeId,
  String amount,
  String createDate,
  String receiveDate,
  String imageUrl,
  String reason,
  int status,
  Widget widget,
}) {
  String dateAfterFormat, dateReceiveAfterFormat, totalAfterFormat;
  try {
    totalAfterFormat = "${getFormatPrice(amount)} đ";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateReceiveAfterFormat =
        "${getDateTime(receiveDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {
    totalAfterFormat = "$amount";
    dateAfterFormat = "$createDate";
    dateReceiveAfterFormat = "$receiveDate";
  }
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
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
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              containerTextInvoice(
                alignment: Alignment.centerRight,
                paddingLeftOfText: 10,
                paddingRightOfText: 10,
                tittle: "Mã: $id",
                fontWeight: FontWeight.w700,
              ),
              Flexible(
                child: containerTextInvoice(
                    alignment: Alignment.centerRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "${getStatus(status: status)}",
                    fontWeight: FontWeight.w600,
                    color: getColorStatus(status: status)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Số tiền vay",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                        alignment: Alignment.topLeft,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "$totalAfterFormat",
                        color: primaryColor),
                  ],
                ),
              ),
              Column(
                children: [
                  containerTextInvoice(
                    alignment: Alignment.centerRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "Ngày tới",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "$dateReceiveAfterFormat",
                      color: primaryColor),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Ngày tạo",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "$dateAfterFormat",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hoá đơn bị từ chối thì show lý do ra thay vì ngày tới
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hiển thị hoá đơn",
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              containerTextInvoice(
                  marginTop: 2,
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Xem chi tiết >>",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    ),
  );
}

//Dùng cho trang Quản lý hóa đơn và để show các hóa đơn
Widget boxForProduct(
    {BuildContext context,
    String id,
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
                tittle: "$id",
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
                  tittle: " ${getDateTime(date, dateFormat: "dd/MM/yyyy")}",
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
                context: context,
                tittle: "${getFormatPrice(price)}đ",
                colorText: Colors.black87,
                fontWeightText: FontWeight.w500,
                fontSize: 16,
                height: 30,
                width: 100,
                colorContainer: Colors.white,
                borderRadius: 5,
                marginRight: 10,
                widget: updatePriceProduct(
                  chosenValue: productName,
                  widgetToNavigate: HomeAdminPage(index: 0),
                ),
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

//Đang dùng cho nút hủy kích hoạt tài khoản khách hàng
Widget btnDeactivateCustomer(
    {String status,
    String deactivateId,
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

Widget containerStores(BuildContext context, String name, String address,
    String phone, String email) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black, // foreground
        textStyle: TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.93,
                child: AutoSizeText(
                  "$name",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            "$address",
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
            "$phone",
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
            "$email",
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
  );
}

//show lịch sử giao dịch của ứng tiền, hiện tại show như này trước
Widget boxForAdvanceHistory({
  BuildContext context,
  String id,
  int amount,
  String customerId,
  int returnCash,
  bool isAdvance,
  String date,
  Widget widget,
}) {
  String amountAfterFormat, cashAfterFormat;
  date = "20-06-2021";
  try {
    amountAfterFormat = "${getFormatPrice(amount.toString())} đ";
    cashAfterFormat = "${getFormatPrice(returnCash.toString())} đ";
  } catch (_) {
    amountAfterFormat = "$amount";
    cashAfterFormat = "$returnCash";
  }
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
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
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              containerTextInvoice(
                alignment: Alignment.centerRight,
                paddingLeftOfText: 10,
                paddingRightOfText: 10,
                tittle: "Mã: $id",
                fontWeight: FontWeight.w700,
              ),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: isAdvance ? "Chờ trả nợ" : "Đã trả nợ",
                  fontWeight: FontWeight.w600,
                  color: isAdvance ? getColorStatus(status: 4) : primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Số tiền vay",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                        alignment: Alignment.topLeft,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "$amountAfterFormat",
                        color: primaryColor),
                  ],
                ),
              ),
              returnCash != 0
                  ? Column(
                      children: [
                        containerTextInvoice(
                          alignment: Alignment.topLeft,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "Số tiền trả lại",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        containerTextInvoice(
                            alignment: Alignment.topLeft,
                            paddingLeftOfText: 10,
                            paddingRightOfText: 10,
                            tittle: "$cashAfterFormat",
                            color: primaryColor),
                      ],
                    )
                  : Column(
                      children: [
                        containerTextInvoice(
                          alignment: Alignment.topLeft,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "Ngày nhận tiền",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        containerTextInvoice(
                            alignment: Alignment.topLeft,
                            paddingLeftOfText: 10,
                            paddingRightOfText: 10,
                            tittle: "$date",
                            color: primaryColor),
                      ],
                    ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hoá đơn bị từ chối thì show lý do ra thay vì ngày tới
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hiển thị hoá đơn",
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              containerTextInvoice(
                  marginTop: 2,
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Xem chi tiết >>",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    ),
  );
}

//show các yêu cầu bán hàng
Widget boxForInvoiceRequest(
    {BuildContext context,
    String id,
    String name,
    String product,
    String price,
    String createDate,
    String sellDate,
    int status,
    Widget widget,
    bool isCustomer}) {
  String dateAfterFormat, dateSellAfterFormat, totalAfterFormat;
  try {
    totalAfterFormat = "${getFormatPrice(price)} đ";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateSellAfterFormat = "${getDateTime(sellDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {
    totalAfterFormat = "$price";
    dateAfterFormat = "$createDate";
    dateSellAfterFormat = "$sellDate";
  }
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
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
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Mã: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrangeAccent),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: !isCustomer ? "Yêu cầu" : "Đã gửi",
                  fontWeight: FontWeight.w600,
                  color: !isCustomer ? Colors.deepOrangeAccent : primaryColor,
                ),
              ),
            ],
          ),
          if (!isCustomer)
            SizedBox(
              height: 10,
            ),
          if (!isCustomer)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                containerTextInvoice(
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Khách hàng: ",
                ),
                containerTextInvoice(
                    alignment: Alignment.topRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "$name",
                    fontWeight: FontWeight.w700),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              containerTextInvoice(
                alignment: Alignment.topLeft,
                paddingLeftOfText: 10,
                paddingRightOfText: 10,
                tittle: "Sản phẩm: ",
              ),
              containerTextInvoice(
                  alignment: Alignment.topRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "$product",
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Giá sản phẩm",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                        alignment: Alignment.topLeft,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "$totalAfterFormat",
                        color: primaryColor),
                  ],
                ),
              ),
              Column(
                children: [
                  containerTextInvoice(
                    alignment: Alignment.topLeft,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "Ngày tới",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "$dateSellAfterFormat",
                      color: primaryColor),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Ngày tạo",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    containerTextInvoice(
                      alignment: Alignment.centerRight,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "$dateAfterFormat",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hoá đơn bị từ chối thì show lý do ra thay vì ngày tới
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hiển thị hoá đơn",
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              containerTextInvoice(
                  marginTop: 2,
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "Xem chi tiết >>",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    ),
  );
}
