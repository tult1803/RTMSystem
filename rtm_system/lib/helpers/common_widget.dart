import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
import 'component.dart';
import '../ultils/get_data.dart';
import '../ultils/src/color_ultils.dart';

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
          // Container(
          //     padding: EdgeInsets.only(left: 5),
          //     height: size.height,
          //     child: icon),
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

//D??ng cho show All customer
Widget boxForCustomer(
    {BuildContext context,
    String name,
    String phone,
    int level,
    int status,
    int advance,
    Widget widget}) {
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget)),
    child: Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
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
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: Row(
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
                        SizedBox(height: 5,),
                        Container(
                          child: Text(
                            phone,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              containerTextInvoice(
                    alignment: Alignment.centerRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: "${getStatus(status: status)}",
                    fontWeight: FontWeight.w600,
                    color: getColorStatus(status: status)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 15,
                      paddingRightOfText: 10,
                      tittle: "S??? n???:",
                      fontWeight: FontWeight.w400,
                    ),
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 0,
                      paddingRightOfText: 10,
                      tittle: "${getFormatPrice(advance.toString())} ??",
                      fontWeight: FontWeight.w500,
                      color: primaryColor
                    )
                  ],
                ),
              ),
              containerIconCustomer(
                  marginTop: 2,
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  icon: level == 0? null : level == 1? Icons.star_border: Icons.star,
                  fontWeight: FontWeight.w400,
                  color: level == 0? Colors.grey: level ==1? Colors.grey: Colors.orangeAccent)
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    ),
  );
}

//D??ng cho trang Qu???n l?? h??a ????n v?? ????? show c??c h??a ????n. D??ng cho c??? show y??u c???u b??n h??ng.
// isRequest: true l?? y??u c???u b??n h??ng. Thay ?????i ch??? T???ng c???ng th??nh Gi?? ( gi?? n??y l?? gi?? s???n ph???m )
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
  String dateAfterFormat,
      dateSellAfterFormat,
      priceAfterFormat,
      totalAfterFormat;
  double totalAmount =
      getPriceTotal(double.parse(price.toString()), degree, quantity);
  try {
    priceAfterFormat = "${getFormatPrice("$price")} ??";
    totalAfterFormat = "${getFormatPrice("$totalAmount")} ??";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateSellAfterFormat =
        "${getDateTime(activeDate, dateFormat: 'dd-MM-yyyy')}";
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
                  tittle: "M??: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: getStatus(status: status),
                  fontWeight: FontWeight.w600,
                  color: getColorStatus(status: status),
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
                  tittle: "Kh??ch h??ng: ",
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
                tittle: "S???n ph???m: ",
              ),
              containerTextInvoice(
                  alignment: Alignment.topRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "$product",
                  fontWeight: FontWeight.w600,
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
                      tittle: "Gi?? s???n ph???m ",
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
                      tittle: "Th??nh ti???n",
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
                          tittle: "Ng??y t???o:",
                        ),
                        activeDate != null
                            ? containerTextInvoice(
                                alignment: Alignment.topLeft,
                                paddingLeftOfText: 10,
                                paddingRightOfText: 10,
                                tittle: "$dateAfterFormat",
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
                  tittle: "Xem chi ti???t >>",
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

//show c??c y??u c???u ???ng ti???n
Widget boxForAdvance({
  BuildContext context,
  bool isCustomer,
  String id,
  String name,
  String storeId,
  String amount,
  String createDate,
  String receiveDate,
  String imageUrl,
  int status,
  int statusAdvances,
  Widget widget,
  bool isCheck
}) {
  String dateAfterFormat, dateReceiveAfterFormat, totalAfterFormat;
  try {
    totalAfterFormat = "${getFormatPrice(amount)} ??";
    dateAfterFormat = "${getDateTime(createDate, dateFormat: 'dd-MM-yyyy')}";
    dateReceiveAfterFormat =
        "${getDateTime(receiveDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {
    totalAfterFormat = "$amount";
    dateAfterFormat = "$createDate";
    dateReceiveAfterFormat = "$receiveDate";
  }
  String titleStatus;
  Color colorStatusAdvance;
  if (isCheck) {
    titleStatus = "???? m?????n";
    colorStatusAdvance = getColorStatus(status: 8);
    
  } else {
    if(statusAdvances == 8){
    if (status == 7) {
      titleStatus = getStatus(status: status);
      colorStatusAdvance = getColorStatus(status: status);
      getColorStatus(status: status);
    } else if (status == 4) {
      titleStatus = getStatus(status: status);
      colorStatusAdvance = getColorStatus(status: status);
      getColorStatus(status: status);
    } else {
      titleStatus = "???? duy???t";
      colorStatusAdvance = Colors.orangeAccent;
      getColorStatus(status: status);
    }
    } else {
      titleStatus = getStatus(status: statusAdvances);
      colorStatusAdvance = getColorStatus(status: statusAdvances);
    }
    
  } 
  return GestureDetector(
    onTap: () {
      widget == null? print('ok') :
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
    },
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
                  tittle: "M??: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange),
              Flexible(
                child: containerTextInvoice(
                    alignment: Alignment.centerRight,
                    paddingLeftOfText: 10,
                    paddingRightOfText: 10,
                    tittle: titleStatus,
                    fontWeight: FontWeight.w600,
                    color: colorStatusAdvance),
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
                  tittle: "Kh??ch h??ng: ",
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
              Expanded(
                child: Column(
                  children: [
                    containerTextInvoice(
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "S??? ti???n vay",
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
                    tittle: "Ng??y t???i",
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
                      tittle: "Ng??y t???o",
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
                    //Ho?? ????n b??? t??? ch???i th?? show l?? do ra thay v?? ng??y t???i
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hi???n th??? ho?? ????n",
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
                  tittle: "Xem chi ti???t >>",
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

//show c??c y??u c???u ???ng ti???n
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
                  tittle: "M??: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: getStatusUpdatePrice(date: date),
                  fontWeight: FontWeight.w600,
                  color: getColorStatusUpdatePrice(date: date),
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
              containerTextInvoice(
                alignment: Alignment.topLeft,
                paddingLeftOfText: 10,
                paddingRightOfText: 10,
                tittle: "S???n ph???m: ",
              ),
              containerTextInvoice(
                  alignment: Alignment.topRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: productName,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
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
                tittle: "Gi?? s???n ph???m ",
              ),
              SizedBox(
                height: 10,
              ),
              containerTextInvoice(
                  alignment: Alignment.topLeft,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "${getFormatPrice(price)} ??",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        containerTextInvoice(
                          alignment: Alignment.centerRight,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 5,
                          tittle: "Ng??y c???p nh???t:",
                        ),
                        containerTextInvoice(
                          alignment: Alignment.centerRight,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 5,
                          tittle:
                              "${getDateTime(date, dateFormat: "dd-MM-yyyy")}",
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
                  tittle: "Xem chi ti???t >>",
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

// ??ang d??ng cho c??c trang detail "S???n ph???m", "H??a ????n", "???ng ti???n", "Kh??ch h??ng"
Widget containerDetail(BuildContext context, Widget widget,
    {double marginLeft,
    double marginRight,
    double marginBottom,
    double marginTop}) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(
        left: marginLeft == null ? 0 : marginLeft,
        right: marginRight == null ? 0 : marginRight,
        bottom: marginBottom == null ? 0 : marginBottom,
        top: marginTop == null ? 0 : marginTop),
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

//??ang d??ng cho n??t h???y k??ch ho???t t??i kho???n kh??ch h??ng
Widget btnDeactivateCustomer(
    {String status,
    String deactivateId,
    String token,
    BuildContext context,
    bool isDeactivateNotice}) {
  if (status != "Kh??ng ho???t ?????ng") {
    return Container(
      width: 160,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () {
          if (status != "Kh??ng ho???t ?????ng") {
            showAlertDialog(
                context,
                isDeactivateNotice == null
                    ? "B???n mu???n h???y k??ch ho???t kh??ch h??ng"
                    : "B???n mu???n ???n th??ng b??o ?",
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
          isDeactivateNotice == null ? "H???y k??ch ho???t" : "???n th??ng b??o",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  } else {
    return Container();
  }
}

//show l???ch s??? giao d???ch c???a ???ng ti???n, hi???n t???i show nh?? n??y tr?????c
Widget boxForAdvanceHistory({
  BuildContext context,
  String id,
  List idList,
  int amount,
  String customerId,
  int returnCash,
  bool isAdvance,
  bool isPaid,
  String dateTime,
  //ngay tra no
  String receiveDate,
  bool checkShow,
  Widget widget,
}) {
  String amountAfterFormat,
      cashAfterFormat,
      dateTimeAfterFormat,
      receiveDateAfterFormat,
      titleStatus;
  try {
    amountAfterFormat = "${getFormatPrice(amount.toString())} ??";
    cashAfterFormat = "${getFormatPrice(returnCash.toString())} ??";
    dateTimeAfterFormat = "${getDateTime(dateTime, dateFormat: 'dd-MM-yyyy')}";
    receiveDateAfterFormat =
        "${getDateTime(receiveDate, dateFormat: 'dd-MM-yyyy')}";
  } catch (_) {}
  Color statusAdvance;
  if (isAdvance && isPaid) {
    titleStatus = "???? tr??? n???";
    statusAdvance = getColorStatus(status: 7);
  } else if (!isAdvance && !isPaid) {
    titleStatus = "????n tr???";
    statusAdvance = getColorStatus(status: 9);
  } else {
    titleStatus = "???? m?????n";
    statusAdvance = Colors.orangeAccent;
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
                tittle: "M??: $id",
                fontWeight: FontWeight.w700,
                color: Colors.deepOrange,
              ),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: titleStatus,
                  fontWeight: FontWeight.w600,
                  color: statusAdvance,
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
                      tittle: isAdvance? "S??? ti???n vay": "T???ng ti???n",
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
              checkShow == true
                  ? Column(
                      children: [
                        containerTextInvoice(
                          alignment: Alignment.topLeft,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "Ti???n ho??n tr???",
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
                          alignment: Alignment.topRight,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "Ng??y nh???n ti???n",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        containerTextInvoice(
                            alignment: Alignment.topRight,
                            paddingLeftOfText: 10,
                            paddingRightOfText: 10,
                            tittle: "$dateTimeAfterFormat",
                            color: primaryColor),
                      ],
                    ),
              if (isAdvance == false)
                Flexible(
                  child: Column(
                    children: [
                      containerTextInvoice(
                        alignment: Alignment.topRight,
                        paddingLeftOfText: 10,
                        paddingRightOfText: 10,
                        tittle: "Ng??y tr???",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      containerTextInvoice(
                          alignment: Alignment.topRight,
                          paddingLeftOfText: 10,
                          paddingRightOfText: 10,
                          tittle: "$dateTimeAfterFormat",
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
                    //Ho?? ????n b??? t??? ch???i th?? show l?? do ra thay v?? ng??y t???i
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hi???n th??? ho?? ????n",
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
                  tittle: "Xem chi ti???t >>",
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

//show c??c y??u c???u b??n h??ng
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
    totalAfterFormat = "${getFormatPrice(price)} ??";
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
                  tittle: "M??: $id",
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange),
              Flexible(
                child: containerTextInvoice(
                  alignment: Alignment.centerRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: !isCustomer ? "Y??u c???u" : "???? g???i",
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
                  tittle: "Kh??ch h??ng: ",
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
                tittle: "S???n ph???m: ",
              ),
              containerTextInvoice(
                  alignment: Alignment.topRight,
                  paddingLeftOfText: 10,
                  paddingRightOfText: 10,
                  tittle: "$product",
                  fontWeight: FontWeight.w600,
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
                      tittle: "Gi?? s???n ph???m",
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
                    tittle: "Ng??y b??n",
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
                      tittle: "Ng??y t???o",
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
                    //Ho?? ????n b??? t??? ch???i th?? show l?? do ra thay v?? ng??y t???i
                    containerTextInvoice(
                      marginTop: 2,
                      alignment: Alignment.topLeft,
                      paddingLeftOfText: 10,
                      paddingRightOfText: 10,
                      tittle: "Hi???n th??? ho?? ????n",
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
                  tittle: "Xem chi ti???t >>",
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

Widget showErrorLoadData() {
  return Container(
    margin: EdgeInsets.all(12),
    child: Center(
      child: Column(
        children: [
          AutoSizeText(showMessage(MSG008, MSG027),
              style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}
