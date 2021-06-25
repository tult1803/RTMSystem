import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'helpers.dart';

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
          tittle,
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
            content,
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

//nội dung của bill, đang dùng: create invoice/ request
Widget widgetCreateInvoice(context, bool isNew, List product,
    String nameProduct, String nameStore, String name, String phone, bool isCustomer) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
      child: Container(
    height: size.height,
    margin: EdgeInsets.only(
      bottom: 12,
    ),
    color: Color(0xFF0BB791),
    child: Column(
      children: [
        //show data detail invoice
        Container(
          margin: EdgeInsets.fromLTRB(12, 24, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          // height: 96,
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Column(
              children: [
                txtPersonInvoice(context, 'Người tạo', '${name}', '${phone}'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Sản phẩm', '${nameProduct}'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Cửa hàng', '${nameStore}'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Ngày đến bán', '${product[3]}'),
                _showComponetCreateInvoice(
                    context, 'Số ký', product[1], isCustomer),
                if (product[0] == '3')
                  _showComponetCreateInvoice(
                      context, 'Số độ', product[2], isCustomer),
                _showComponetCreateInvoice(
                    context, 'Thành tiền', '100', isCustomer),
              ],
            ),
          ),
        ),
        if (!isNew)
          Center(
            child: SizedBox(
              width: 150,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {
                  //den page to update sp
                },
                child: Text('Sửa lại sản phẩm'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
          ),
        Center(
          child: SizedBox(
            width: 150,
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Color(0xffEEEEEE),
              onPressed: () {
                doCreateRequestInvoiceOrInvoice(context, product[0],
                    product[3], 0,product[4], 0, 0, 0, isCustomer);
              },
              child: Text('Xác nhận'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
          ),
        ),
      ],
    ),
  ));
}

Widget _showComponetCreateInvoice(context, title, value, isCustomer) {
  if (!isCustomer) {
    return txtItemDetail(context, '$titlé', '$value');
  } else {
    return Container();
  }
}

///Hàm này đang bị dư không dùng thi xoá đi
// ignore: missing_return
Widget _showBtnInAdvanceDetail(context, String status) {
  if (status == 'active') {
    return Center(
      child: SizedBox(
        width: 150,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xffEEEEEE),
          onPressed: () {
            put_API_PayAdvance(context);
          },
          child: Text('Xac nhan'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Ngày tra', '20-05-2021 now()'),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Tiền nợ còn lại', '1,000,000 VND'),
      ],
    );
  }
}

///Hàm này đang bị dư không dùng thi xoá đi
Widget _showContentInAdvance(context, String status) {
  if (status == 'active') {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Ngày tra', '20-05-2021 now()'),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Tiền nợ còn lại', '1,000,000 VND'),
      ],
    );
  } else {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Trạng thái', 'Nguyen Van A'),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, 'Mã giao dịch', 'Nguyen Van A'),
        SizedBox(
          height: 10,
        ),
        if (status == 'Đã huy') txtItemDetail(context, 'Ly do', 'abc'),
        if (status == 'Đã huy')
          SizedBox(
            height: 10,
          ),
        if (status == 'Chờ xác nhận')
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnAcceptOrReject(
                    context, 130, Colors.redAccent, 'Từ chối', false, 0),
                SizedBox(width: 20),
                btnAcceptOrReject(
                    context, 130, Color(0xFF0BB791), 'Chấp nhận', true, 0),
              ],
            ),
          ),
      ],
    );
  }
}

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
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "$content",
          style: TextStyle(fontSize: 18),
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
    String managerConfirmDate,
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
        txtItemDetail(context, "Tên khách hàng", "$customerName",
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
              : txtItemDetail(context, "Độ", "$degree"),
        ),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Khối lượng", "$quantity kg"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tổng hóa đơn",
            "${getFormatPrice("${getPriceTotal(double.parse(price), degree, quantity)}")} đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày xác nhận của khách hàng",
            "${getDateTime(customerConfirmDate)}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày xác nhận của quản lý",
            "${getDateTime(managerConfirmDate)}"),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Ngày hoá đơn có hiệu lực", "${getDateTime(activeDate)}"),
        txtItemDetail(context, "Trạng thái", "${getStatus(status: statusId)}",
            colorContent: getColorStatus(status: statusId)),
        SizedBox(
          height: 5,
        ),
        // chỗ này show btn accpet or reject của customer
        _showBtnProcessInvoice(context, statusId, id, isCustomer,
            widgetToNavigator: widgetToNavigator),
      ],
    ),
  );
}

Widget _showBtnProcessInvoice(context, int statusId, String id, bool isCustomer,
    {bool isRequest, Widget widgetToNavigator, Map<String, dynamic> map}) {
  var size = MediaQuery.of(context).size;
  //show button để xử lý hoàn thành đơn
  //status = 0 là cho customer xoá hoá đơn gửi yêu cầu.
  //status = 5 là cho customer sign invoice
  // status = 1 là manager confirm
  // status = 4 là accept or delete invoice. Customer: only accept NOT Reject.
  if (statusId == 5 || statusId == 1) {
    if (statusId == 5 && isCustomer == true) {
      return SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            doConfirmOrAcceptOrRejectInvoice(context, id, 1, isCustomer);
          },
          child: Text(
            'Nhận tiền',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      );
    } else if (statusId == 1 && isCustomer == false) {
      return SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            doConfirmOrAcceptOrRejectInvoice(context, id, 1, isCustomer);
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      );
    } else {
      return Container();
    }
  } else if (statusId == 4) {
    if (isCustomer) {
      return SizedBox(
        width: size.width * 0.5,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: primaryColor,
          onPressed: () {
            doConfirmOrAcceptOrRejectInvoice(context, id, 2, isCustomer);
          },
          child: Text(
            'Chấp nhận',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Colors.redAccent,
              onPressed: () {
                doConfirmOrAcceptOrRejectInvoice(context, id, 3, isCustomer,
                    widgetToNavigator: widgetToNavigator);
              },
              child: Text(
                'Từ chối',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
          ),
          Flexible(
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {
                doConfirmOrAcceptOrRejectInvoice(context, id, 2, isCustomer,
                    isRequest: isRequest, map: map);
              },
              child: Text(
                '${isRequest != null ? "Tạo" : "Chấp nhận"}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
          ),
        ],
      );
    }
  } else if(statusId == 0){
    return SizedBox(
      width: size.width * 0.5,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.redAccent,
        onPressed: () {
          //call api xoa yeu cau
        },
        child: Text(
          'Xoá yêu cầu',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
      ),
    );
  }else  {
    return Container();
  }
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
        txtItemDetail(context, "Loại", "${item["type"]}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Giá (1kg)",
            "${getFormatPrice("${item["update_price"]}")} đ"),
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

//Dùng cho trang chi tiết khách hàng
// Là các dòng trong trang chi tiết khách hàng
Widget componentContainerDetailCustomer(BuildContext context,
    {String status,
    String token,
    String account_id,
    int statusId,
    int advance,
    String fullname,
    String cmnd,
    String phone,
    String address,
    String birthday,
    String gender,
    String vip}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID khách hàng", "$account_id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Họ và tên", "$fullname"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Giới tính", "$gender"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Điện thoại", "$phone"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "CMND/CCCD", "$cmnd"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày sinh",
            "${getDateTime(birthday, dateFormat: 'dd/MM/yyyy')}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Địa chỉ", "$address"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Tổng nợ", "$advance"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Loại tài khoản", "$vip"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Trạng thái", "$status",
            colorContent: getColorStatus(status: statusId)),
        SizedBox(
          height: 10,
        ),
        btnDeactivateCustomer(
            token: token,
            context: context,
            status: status,
            deactivateId: account_id),
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
          height: height,
          width: width,
          child: Center(
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
        style: GoogleFonts.roboto(fontWeight: fontWeight),
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
    Map<String, dynamic> map}) {
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
            ? _showBtnProcessInvoice(context, 0, id, isCustomer,
            isRequest: isRequest, widgetToNavigator: widgetToNavigator, map: map)
            : _showBtnProcessInvoice(context, 4, id, isCustomer,
                isRequest: isRequest, widgetToNavigator: widgetToNavigator, map: map),
      ],
    ),
  );
}

//Dùng cho trang chi tiết yêu cầu advance
Widget componentContainerDetailAdvanceRequest(BuildContext context,
    {String id,
    String storeName,
    String customerName,
    String customerPhone,
    String money,
    String image,
    String createDate,
    bool isCustomer}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        txtItemDetail(context, "ID đơn", "$id"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Ngày ứng tiền", "${getDateTime(createDate)}"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Người tạo", "$customerName",
            subContent: customerPhone),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        // _showContentInAdvance(context, status)
        // chỗ này show btn accpet or reject của manager cho request
      ],
    ),
  );
}

//nội dung của bill, đang dùng: create advance and confirm advance
Widget widgetCreateAdvance(context, List item,String storeId, String nameProduct, String name,
    String phone, int type, bool isCustomer) {
  var size = MediaQuery.of(context).size;
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
                txtPersonInvoice(context, 'Người tạo', '${name}', '${phone}'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Số tền', '${item[0]}'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Ngày ứng tiền', '${item[1]}'),
                // hình ảnh
                SizedBox(
                  height: 10,
                ),
                showImage(size.width, size.height,item[2]),
                SizedBox(
                  height: 10,
                ),
                //khi nào có api sẽ tách chỗ này ra thành 1 hàm để gọi các btn khác nhau
                SizedBox(
                  width: size.width * 0.4,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Color(0xFF0BB791),
                    onPressed: () {
                      doCreateRequestAdvance(context, 'TK-111', item[0],
                          item[1], item[2],storeId, type, true);
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