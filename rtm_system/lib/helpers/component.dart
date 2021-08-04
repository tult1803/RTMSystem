import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/model/model_advance_return_detail.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/product/update_price_product_manager.dart';
import '../ultils/get_data.dart';

// Hiện tại dùng cho trang "Profile"
Widget txtFullNameProfile(String tittle) {
  return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        tittle,
        style: TextStyle(fontSize: 23),
      ));
}

// Hiện tại dùng cho trang "Profile"
Widget txtCanClick(BuildContext context, Widget widget, String tittle) {
  return Container(
    margin: EdgeInsets.only(left: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Row(
        children: [
          Text(
            tittle,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 13,
            color: Colors.black54,
          ),
        ],
      ),
    ),
  );
}

//show infor với 3 dòng, đang dùng: invoice detail
Widget txtPersonInvoice(
    context, String title, String content1, String content2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            child: AutoSizeText(
              title,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
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
        content1,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(
        height: 10,
      ),
      AutoSizeText(
        content2,
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: 9,
      ),
      SizedBox(
        height: 1,
        child: Container(
          color: Color(0xFFBDBDBD),
        ),
      ),
    ],
  );
}

//show infor với 2 dòng, đang dùng: invoice detail
Widget txtItemDetail(context, String tittle, String content,
    {Color colorContent, String subContent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: AutoSizeText(
          tittle == null ? "-----" : tittle,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 12,
          ),
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content == null ? "-----" : content,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: colorContent,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
          ),
          subContent == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("$subContent"),
                ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 9,
      ),
      SizedBox(
        height: 1,
        child: Container(
          color: Color(0xFFBDBDBD),
        ),
      ),
    ],
  );
}
//*******Không biết là double hay có sửa gì cái trùng k nên cmt lại
//nội dung của bill, đang dùng: create invoice/ request
// Widget widgetCreateInvoice(context, bool isNew, List product,
//     String nameProduct, String nameStore, String name, String phone, bool isCustomer) {
//   var size = MediaQuery.of(context).size;
//   return SingleChildScrollView(
//       child: Container(
//     height: size.height,
//     margin: EdgeInsets.only(
//       bottom: 12,
//     ),
//     color: Color(0xFF0BB791),
//     child: Column(
//       children: [
//         //show data detail invoice
//         Container(
//           margin: EdgeInsets.fromLTRB(12, 24, 12, 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//           ),
//           // height: 96,
//           child: Container(
//             margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
//             child: Column(
//               children: [
//                 txtPersonInvoice(context, 'Người tạo', '${name}', '${phone}'),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 txtItemDetail(context, 'Sản phẩm', '${nameProduct}'),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 txtItemDetail(context, 'Cửa hàng', '${nameStore}'),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 txtItemDetail(context, 'Ngày đến bán', '${product[3]}'),
//                 _showComponetCreateInvoice(
//                     context, 'Số ký', product[1], isCustomer),
//                 if (product[0] == '3')
//                   _showComponetCreateInvoice(
//                       context, 'Số độ', product[2], isCustomer),
//                 _showComponetCreateInvoice(
//                     context, 'Thành tiền', '100', isCustomer),
//               ],
//             ),
//           ),
//         ),
//         if (!isNew)
//           Center(
//             child: SizedBox(
//               width: 150,
//               // ignore: deprecated_member_use
//               child: RaisedButton(
//                 color: Color(0xffEEEEEE),
//                 onPressed: () {
//                   //den page to update sp
//                 },
//                 child: Text('Sửa lại sản phẩm'),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 elevation: 10,
//               ),
//             ),
//           ),
//         Center(
//           child: SizedBox(
//             width: 150,
//             // ignore: deprecated_member_use
//             child: RaisedButton(
//               color: Color(0xffEEEEEE),
//               onPressed: () {
//                 doCreateRequestInvoiceOrInvoice(context, product[0],
//                     product[3], 0,product[4], 0, 0, 0, isCustomer);
//               },
//               child: Text('Xác nhận'),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               elevation: 10,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ));
// }

//Hiện tại đang dùng cho "Phiếu xác nhận" của "Tạo khách hàng" trong profile
Widget txtConfirm(BuildContext context, String tittle, String content) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          tittle,
          style: GoogleFonts.roboto(color: Colors.black54, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "$content",
          style: GoogleFonts.roboto(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: 0.5,
          color: Colors.black54,
        )
      ],
    ),
  );
}

//Đổi màu và icon cho nút back screen
Widget leadingAppbar(BuildContext context, {Widget widget, Color colorIcon}) {
  return IconButton(
    icon: Icon(Icons.arrow_back_ios_outlined,
        color: colorIcon == null ? Colors.white : colorIcon),
    onPressed: () => widget != null
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => widget), (route) => false)
        : Navigator.of(context).pop(),
  );
}

Widget newPageProgressIndicatorBuilder() {
  return Center(
    child: CircularProgressIndicator(
      color: welcome_color,
    ),
  );
}

// Dùng cho PagedChildBuilderDelegate trong PagedSliverList
Widget firstPageProgressIndicatorBuilder() {
  return Center(
    child: CircularProgressIndicator(
      color: welcome_color,
    ),
  );
}

// Dùng cho PagedChildBuilderDelegate trong PagedSliverList
Widget firstPageErrorIndicatorBuilder(BuildContext context, {String tittle}) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: 50,
    child: Center(
        child: AutoSizeText(
      "$tittle",
      style: TextStyle(color: Colors.black54, fontSize: 16),
    )),
  );
}

//Dùng cho trang chi tiết hóa đơn
Widget componentContainerDetailInvoice(BuildContext context,
    {int statusId,
    String id,
    String productId,
    String customerId,
    String managerId,
    double quantity,
    double degree,
    String managerName,
    managerPhone,
    String customerName,
    customerPhone,
    String productName,
    String price,
    String createTime,
    String storeName,
    String customerConfirmDate,
    String activeDate,
    bool isCustomer,
    Widget widgetToNavigator}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID hóa đơn", "$id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Ngày tạo hóa đơn", "${getDateTime(createTime)}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Cửa hàng", "$storeName"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Người tạo hóa đơn", "$managerName",
            subContent: managerPhone),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Khách hàng", "$customerName",
            subContent: customerPhone),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tên sản phẩm", "$productName"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Giá sản phẩm", "${getFormatPrice(price)}đ"),
        Container(
          child: degree == 0
              ? SizedBox(height: 1)
              : txtItemDetail(context, "Số độ", "$degree"),
        ),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Khối lượng sản phẩm", "$quantity kg"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tổng hóa đơn",
            "${getFormatPrice("${getPriceTotal(double.parse(price), degree, quantity)}")} đ"),
        SizedBox(
          height: 10,
        ),
        if (customerConfirmDate != null)
          txtItemDetail(context, "Ngày khách hàng xác nhận",
              "${getDateTime(customerConfirmDate)}"),
        if (customerConfirmDate != null)
          SizedBox(
            height: 10,
          ),
        if (activeDate != null)
          txtItemDetail(context, "Ngày hoá đơn có hiệu lực",
              "${getDateTime(activeDate)}"),
        if (activeDate != null)
          SizedBox(
            height: 10,
          ),
        txtItemDetail(context, "Trạng thái", "${getStatus(status: statusId)}",
            colorContent: getColorStatus(status: statusId)),
        SizedBox(
          height: 5,
        ),
        // chỗ này show btn accpet or reject của customer
        btnProcessInvoice(context, statusId, id, isCustomer,
            widgetToNavigator: widgetToNavigator,
            isDegree: degree == 0 ? false : true),
        SizedBox(
          height: 25,
        ),
      ],
    ),
  );
}

//Dùng cho chi tiết sản phẩm
Widget componentContainerDetailProduct(BuildContext context, Map item) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "Mã sản phẩm", "${item["id"]}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tên sản phẩm", item["name"]),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Mô tả", item["description"]),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Loại", "${checkTypeProduct(item["type"])}"),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            txtItemDetail(context, "Giá (1kg)",
                "${getFormatPrice("${item["update_price"]}")} đ"),
            GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => updatePriceProduct(
                          chosenValue: "${item["name"]}",
                        ))),
                child: Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    child: Icon(
                      Icons.update,
                      color: Colors.blueAccent,
                    ))),
          ],
        ),
        SizedBox(
          height: 1,
          child: Container(
            color: Color(0xFFBDBDBD),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Ngày cập nhật", "${getDateTime(item["updateDateTime"])}"),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}

//Dùng cho các container nhỏ vd như trong trang quản lý khách hàng
//Và đang dùng cho component "Mã" và "Trạng thái hóa đơn" trong quản lý hóa đơn
// là những component container nhỏ trong từng khách hàng

//Có tính năng Navigator nếu muốn navigator sang trang khác thì  widget ko được null
//Nếu muốn sử dụng navigator.pop thì widget có thể null nhưng trạng thái " doNavigate " không được null phải true hoặc false
//Nhớ phải thêm context để navigator

Widget miniContainer(
    {BuildContext context,
    String tittle,
    double height,
    double width,
    Color colorContainer,
    Color colorText,
    Color colorBoxShadow,
    double marginLeft,
    double marginRight,
    double marginTop,
    double marginBottom,
    double borderRadius,
    double paddingLeftOfText,
    double paddingRightOfText,
    double paddingTopOfText,
    double paddingBottomOfText,
    double fontSize,
    FontWeight fontWeightText,
    bool doPopNavigate,
    Alignment alignmentText,
    Widget widget}) {
  return GestureDetector(
      onTap: () => widget == null
          ? doPopNavigate == null
              ? null
              : Navigator.of(context).pop()
          : Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => widget),
              (route) => false),
      child: Container(
        margin: EdgeInsets.only(
          right: marginRight == null ? 0 : marginRight,
          top: marginTop == null ? 0 : marginTop,
          bottom: marginBottom == null ? 0 : marginBottom,
          left: marginLeft == null ? 0 : marginLeft,
        ),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(borderRadius == null ? 0 : borderRadius),
          color: colorContainer,
          boxShadow: [
            BoxShadow(
              color: colorBoxShadow == null ? Colors.black54 : colorBoxShadow,
              blurRadius: 3,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Container(
          alignment: alignmentText == null ? Alignment.center : alignmentText,
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.only(
                left: paddingLeftOfText == null ? 0 : paddingLeftOfText,
                right: paddingRightOfText == null ? 0 : paddingRightOfText,
                bottom: paddingBottomOfText == null ? 0 : paddingBottomOfText,
                top: paddingTopOfText == null ? 0 : paddingTopOfText),
            child: AutoSizeText(
              tittle,
              style: GoogleFonts.roboto(
                  color: colorText,
                  fontWeight: fontWeightText,
                  fontSize: fontSize == null ? null : fontSize),
            ),
          ),
        ),
      ));
}

//Dùng cho container chứ Text trong quản lý hóa đơn
Widget containerTextInvoice({
  String tittle,
  FontWeight fontWeight,
  Alignment alignment,
  double marginLeft,
  double marginRight,
  double marginTop,
  double marginBottom,
  double borderRadius,
  double paddingLeftOfText,
  double paddingRightOfText,
  double paddingTopOfText,
  double paddingBottomOfText,
  double height,
  double width,
  Color color,
}) {
  return Container(
    height: height,
    width: width,
    margin: EdgeInsets.only(
      right: marginRight == null ? 0 : marginRight,
      top: marginTop == null ? 0 : marginTop,
      bottom: marginBottom == null ? 0 : marginBottom,
      left: marginLeft == null ? 0 : marginLeft,
    ),
    alignment: alignment,
    child: Padding(
      padding: EdgeInsets.only(
          left: paddingLeftOfText == null ? 0 : paddingLeftOfText,
          right: paddingRightOfText == null ? 0 : paddingRightOfText,
          bottom: paddingBottomOfText == null ? 0 : paddingBottomOfText,
          top: paddingTopOfText == null ? 0 : paddingTopOfText),
      child: Text(
        tittle,
        style: GoogleFonts.roboto(
          fontWeight: fontWeight,
          color: color != null ? color : Colors.black,
        ),
      ),
    ),
  );
}

//Dùng cho trang chi tiết yêu cầu bán hàng
Widget componentContainerInvoiceRequest(BuildContext context,
    {String id,
    String customerName,
    String customerPhone,
    String productName,
    String price,
    String createDate,
    String sellDate,
    String storeName,
    bool isRequest,
    bool isCustomer,
    Widget widgetToNavigator,
    InvoiceRequestElement element}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID hóa đơn", "$id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày tạo hóa đơn",
            "${getDateTime(createDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Cửa hàng", "$storeName"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Người tạo hóa đơn", "$customerName",
            subContent: customerPhone),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tên sản phẩm", "$productName"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Giá sản phẩm", "${getFormatPrice(price)}đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày muốn đến bán",
            "${getDateTime(sellDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 5,
        ),
        isCustomer
            ? Container()
            : btnProcessInvoice(context, 4, id, isCustomer,
                isRequest: isRequest,
                widgetToNavigator: widgetToNavigator,
                element: element),
      ],
    ),
  );
}

//Dùng cho trang chi tiết or yêu cầu của advance
// hiện tại lấy detail, status = 4 k có
// isCustomer để đó để manager có khác biệt thì dùng
Widget componentContainerDetailAdvanceRequest(BuildContext context,
    {String id,
    String storeName,
    String storeId,
    String customerName,
    String customerPhone,
    String description,
    int amount,
    int statusId,
    int activeStatus,
    String createDate,
    String activeDate,
    String receiveDate,
    String reason,
    bool isCustomer,
    String imageUrl,
    Widget widgetToNavigator}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID đơn", "$id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Cửa hàng", "$storeName"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày tạo đơn",
            "${getDateTime(createDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 10,
        ),
        Container(
          child: isCustomer
              ? null
              : Column(
                  children: [
                    txtItemDetail(context, "Khách hàng", "$customerName",
                        subContent: customerPhone),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ),
        txtItemDetail(context, "Số tiền", "${getFormatPrice("$amount")}đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày sẽ đến",
            "${getDateTime(receiveDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 10,
        ),
        if (activeDate != null)
          txtItemDetail(context, "Ngày nhận tiền",
              "${getDateTime(activeDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Lý do", "${statusId == 6 ? reason : description}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Trạng thái", "${getStatus(status: statusId)}",
            colorContent: getColorStatus(status: statusId)),
        SizedBox(
          height: 10,
        ),
        if (activeStatus != null)
          txtItemDetail(context, "Tình trạng",
              activeStatus == 5 ? "Chưa nhận tiền" : "Đã nhận tiền",
              colorContent: getColorStatus(status: activeStatus)),
        SizedBox(
          height: 10,
        ),
        //hiển thị ảnh cmnd mặt trước, vì khách có thể mượn tiền phải xác thực tài khoản nên
        // không cần bắt null url.
        if (!isCustomer)
          Container(
            child: imageUrl == null ? null : Image.network(imageUrl),
          ),
        //show btn for manager and customer
        showBtnInAdvanceRequest(context, statusId, activeStatus, isCustomer, id,
            statusId, id, widgetToNavigator),
        SizedBox(
          height: 25,
        ),
      ],
    ),
  );
}

Widget showBtnInAdvanceRequest(context, status, activeStatus, bool isCustomer,
    id, statusId, idAdvanceBill, widgetToNavigator) {
  if (isCustomer) {
    if (status == 4) {
      //btn delete advance
      return ElevatedButton(
        onPressed: () {
          doDeleteAdvanceRequest(context, id);
        },
        child: AutoSizeText(
          "Xoá yêu cầu",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
    }
    if (activeStatus == 5) {
      return btnConfirmAdvanceOfCustomer(context, id, statusId);
    } else {
      return Container();
    }
  } else {
    if (statusId == 4) {
      return btnProcessAdvanceBill(context,
          isCustomer: false,
          idAdvanceBill: id,
          widgetToNavigator: widgetToNavigator);
    } else {
      return Container();
    }
  }
}

//nội dung của bill, đang dùng: create advance and confirm advance
Widget widgetCreateAdvance(context, List item, String storeId,
    String nameProduct, String name, String phone, int type, bool isCustomer) {
  var size = MediaQuery.of(context).size;
  String reason;
  if (item[2] == null || item[2] == '') {
    reason = 'Ứng tiền';
  } else {
    reason = item[2];
  }
  return SingleChildScrollView(
      child: Container(
    height: size.height,
    color: Color(0xFF0BB791),
    child: Column(
      children: [
        //show data detail invoice
        Container(
          margin: EdgeInsets.fromLTRB(12, 24, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // height: 96,
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Column(
              children: [
                txtPersonInvoice(context, 'Người tạo', '$name', '$phone'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Số tiền', '${item[0]} đ'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Ngày ứng tiền', '${item[1]}'),
                // hình ảnh
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Lý do', '${reason}'),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.4,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Color(0xFF0BB791),
                    onPressed: () {
                      createRequestAdvance(
                          context, 'TK-111', item[0], reason, item[1], storeId);
                    },
                    child: AutoSizeText(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ));
}

Widget componentDetailCreateInvoice(
  BuildContext context, {
  String storeId,
  String customerId,
  String productId,
  String invoiceRequestId,
  String customerName,
  String phoneNumber,
  String storeName,
  String productName,
  String quantity,
  String degree,
  String price,
  String dateToPay,
  bool isCustomer,
  int level,
  Widget widgetToNavigator,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        txtItemDetail(context, "Cửa hàng $storeId", storeName),
        SizedBox(
          height: 10,
        ),
        Container(
            child: isCustomer
                ? null
                : Column(children: [
                    txtItemDetail(context, "Khách hàng", customerName,
                        subContent: phoneNumber),
                    SizedBox(
                      height: 10,
                    )
                  ])),
        txtItemDetail(context, "Sản phẩm", productName),
        SizedBox(
          height: 10,
        ),
        if (level == 2)
          txtItemDetail(context, "Giá sản phẩm", "${getFormatPrice(price)} đ"),
        if (level == 2)
          SizedBox(
            height: 10,
          ),
        Container(
          child: isCustomer
              ? null
              : Column(
                  children: [
                    Container(
                        child: degree == "0.0"
                            ? null
                            : txtItemDetail(context, "Số độ", degree)),
                    SizedBox(
                      height: 10,
                    ),
                    txtItemDetail(context, "Số ký", quantity),
                    SizedBox(
                      height: 10,
                    ),
                    txtItemDetail(context, "Tổng tiền",
                        "${getFormatPrice('${getPriceTotal(double.tryParse(price), double.tryParse(degree), double.tryParse(quantity))}')} đ"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ),
        txtItemDetail(
          context,
          "Ngày đến bán",
          "${getDateTime(dateToPay, dateFormat: "dd/MM/yyyy")}",
        ),
        SizedBox(
          height: 10,
        ),

        btnConfirmDetailInvoice(context,
            storeId: storeId,
            customerId: customerId,
            productId: productId,
            sellDate: dateToPay,
            invoiceRequestId: invoiceRequestId,
            quantity: quantity,
            degree: degree,
            isCustomer: isCustomer,
            widgetToNavigator: widgetToNavigator),
        // SizedBox(
        //   height: 10,
        // ),
      ],
    ),
  );
}

//show hinh anh da chon
Widget showImage(width, height, image) {
  if (image != null) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: width,
      height: height * 0.3,
      child: Image.file(image, fit: BoxFit.scaleDown),
    );
  } else {
    return Container();
  }
}

//show advance return detail
Widget componentContainerAdvanceReturnDetail(BuildContext context,
    {String id,
    String createDate,
    int returnCash,
    int total,
    List<InvoiceInAdvanceReturn> invoices,
    bool isDone}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "Mã đơn hoàn trả", "$id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày tạo",
            "${getDateTime(createDate, dateFormat: "dd/MM/yyyy")}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Số tiền hoàn trả", "${getFormatPrice("$returnCash")} đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Tổng tiền ký gửi", "${getFormatPrice("$total")} đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Trạng thái",
            isDone ? "Đã nhận tiền hoàn trả" : "Chưa nhận tiền hoàn trả",
            colorContent: isDone ? primaryColor : Colors.redAccent),
      ],
    ),
  );
}

// this is total advance show in Ung tien screen
Widget txtItem(context, String title, String content) {
  return Container(
    margin: EdgeInsets.only(left: 12, right: 12, bottom: 14),
    padding: EdgeInsets.all(10),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                color: Color(0xFF0BB791),
                fontWeight: FontWeight.w500,
              ),
            ),
            AutoSizeText(
              content,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}

Widget titleAppBar(name) {
  return Text(
    name,
    style: TextStyle(color: Colors.white),
  );
}

Widget containerTextInProcess() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    child: Center(
      child: AutoSizeText(
        'Các hóa đơn sẽ được thanh toán:',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

// /Dùng cho container icon trong quản lý  khách hàng
Widget containerIconCustomer({
  IconData icon,
  FontWeight fontWeight,
  Alignment alignment,
  double marginLeft,
  double marginRight,
  double marginTop,
  double marginBottom,
  double borderRadius,
  double paddingLeftOfText,
  double paddingRightOfText,
  double paddingTopOfText,
  double paddingBottomOfText,
  double height,
  double width,
  Color color,
}) {
  return Container(
    height: height,
    width: width,
    margin: EdgeInsets.only(
      right: marginRight == null ? 0 : marginRight,
      top: marginTop == null ? 0 : marginTop,
      bottom: marginBottom == null ? 0 : marginBottom,
      left: marginLeft == null ? 0 : marginLeft,
    ),
    alignment: alignment,
    child: Padding(
        padding: EdgeInsets.only(
            left: paddingLeftOfText == null ? 0 : paddingLeftOfText,
            right: paddingRightOfText == null ? 0 : paddingRightOfText,
            bottom: paddingBottomOfText == null ? 0 : paddingBottomOfText,
            top: paddingTopOfText == null ? 0 : paddingTopOfText),
        child: Icon(
          icon,
          color: color,
        )),
  );
}
