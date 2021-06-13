import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/customer/invoice/detail_invoice.dart';

import 'helpers.dart';

// AutoSizeText chữ tự động co giãn theo kích thước mặc định
// Hiện tại dùng cho trang "Product" và "Bill"
//componentCardS là 1 phần bên phải của Card trong trang // E là End
Widget componentCardE(
    String tittle, String type, CrossAxisAlignment cross, Color color) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, top: 10),
    child: Column(
      crossAxisAlignment: cross,
      children: [
        AutoSizeText(
          tittle,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        // Expanded(
        //   child: SizedBox(),
        // ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "${type}",
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Hiện tại dùng cho trang "Product" và "Bill"
//componentCardS là 1 phần bên trái của Card trong trang // S là Start
Widget componentCardS(String tittle, String type, String detailType,
    CrossAxisAlignment cross, Color color) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, top: 10),
    child: Column(
      crossAxisAlignment: cross,
      children: [
        AutoSizeText(
          tittle,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        // Expanded(
        //   child: SizedBox(),
        // ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AutoSizeText(
              "$type: ",
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            AutoSizeText(
              "${detailType}",
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: color,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

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

//header của tất cả bill (customer đang dùng)
Widget headerInvoice(String header1, String header2, String money) {
  return Container(
    color: Color(0xFF0BB791),
    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
    child: Column(
      children: [
        Container(
          child: Center(
            child: Text(
              header1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
            child: Center(
          child: Text(
            header2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        )),
        Container(
            child: Center(
          child: Text(
            money,
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
            ),
            textAlign: TextAlign.center,
          ),
        )),
      ],
    ),
  );
}

//nội dung của bill, đang dùng: invoice detail
Widget widgetContentInvoice(context, String status, String header) {
  return SingleChildScrollView(
      child: Container(
    margin: EdgeInsets.only(
      bottom: 12,
    ),
    color: Color(0xFF0BB791),
    child: Column(
      children: [
        headerInvoice(header, 'Số tiền', '50,000,000 VND'),
        //show data detail invoice
        Container(
          margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          // height: 96,
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Column(
              children: [
                //có api chuyền thông tin cần show vô
                txtPersonInvoice(
                    context, 'Người mua', 'Nguyen Van A', '0123456789'),
                SizedBox(
                  height: 10,
                ),
                txtPersonInvoice(
                    context, 'Người bán', 'Nguyen Van A', '087654322'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Sản phẩm', 'Nguyen Van A'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Số ký', 'Nguyen Van A'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Số độ', 'Nguyen Van A'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Trạng thái', 'Nguyen Van A'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Ngày giao dịch', 'Nguyen Van A'),
                if (status == 'Chờ xác nhận')
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btnAcceptOrReject(context, 150, Colors.redAccent,
                            'Từ chối', false, 1),
                        SizedBox(width: 20),
                        btnAcceptOrReject(context, 150, Color(0xFF0BB791),
                            'Chấp nhận', true, 1),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        //button "Nhận tiền" show if status is "chưa trả", để hoàn thành đơn giao dịch
        if (status == 'Chưa trả')
          Center(
            child: SizedBox(
              width: 150,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {
                  //call api to update status hoan thanh don
                  put_API_GetMoney(context, 0);
                },
                child: Text('Nhận tiền'),
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

Widget widgetContentAdvance(context, String status, String header1, header2) {
  return SingleChildScrollView(
      child: Container(
    margin: EdgeInsets.only(
      bottom: 12,
    ),
    color: Color(0xFF0BB791),
    child: Column(
      children: [
        headerInvoice(header1, header2, '50,000,000 VND'),
        //show data detail invoice
        Container(
          margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          // height: 96,
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Column(
              children: [
                //có api chuyền thông tin cần show vô
                txtPersonInvoice(
                    context, 'Người cho mượn', 'Nguyen Van A', '0123456789'),
                SizedBox(
                  height: 10,
                ),
                txtPersonInvoice(
                    context, 'Người mượn', 'Nguyen Van A', '087654322'),
                SizedBox(
                  height: 10,
                ),
                txtItemDetail(context, 'Ngày mượn', '20-05-2021'),
                _showContentInAdvance(context, status),
              ],
            ),
          ),
        ),
        _showBtnInAdvanceDetail(context, status),
        //button "Nhận tiền" show if status is "chưa trả", để hoàn thành đơn giao dịch
        if (status == 'Dang cho')
          Center(
            child: SizedBox(
              width: 150,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeCustomerPage(
                              index: 0,
                            )),
                  );
                },
                child: Text('Trang chu'),
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

//nội dung của bill, đang dùng: create invoice/ request
Widget widgetCreateInvoice(
    context,
    bool isNew,
    List product,
    String nameProduct,
    String name,
    String phone,
    bool isCustomer) {
  var size = MediaQuery.of(context).size;
  final date = new DateFormat('yyyy-MM-dd HH:mm:ss');
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
                txtItemDetail(context, 'Ngày đến bán', '${product[3]}'),
                _showComponetCreateInvoice(context,'Số ký',product[1],
                    isCustomer),
                if (product[0] == '3')
                _showComponetCreateInvoice(context,'Số độ',product[2],
                    isCustomer),
                _showComponetCreateInvoice(context,'Thành tiền','100',
                    isCustomer),
              ],
            ),
          ),
        ),
        //button "Nhận tiền" show if status is "chưa trả", để hoàn thành đơn giao dịch
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
                print('ZOOO');
                doCreateRequestInvoiceOrInvoice( context, int.parse(product[0]),
                    date.format(product[3]) , 0,0,0,0, isCustomer );
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
  print(isCustomer);
  if (!isCustomer) {
    return txtItemDetail(context, '${title}́', '${value}');
  } else {
    return Container();
  }
}
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
Widget leadingAppbar(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
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

//Dùng cho trang notice để hiện thỉ các notice
Widget btnProcess(BuildContext context, int id, String tittle, String content,
    String date, bool isInvoice) {
  return Container(
      margin: EdgeInsets.all(5),
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
            if (isInvoice) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailInvoicePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailInvoicePage()),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
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

//Dùng cho trang chi tiết hóa đơn
Widget componentContainerDetailInvoice(
  BuildContext context, {
  int statusId,
  int id,
  int productId,
  int customerId,
  int managerId,
  double quantity,
  double degree,
  String managerName,
  managerPhone,
  String customerName,
  customerPhone,
  String productName,
  String price,
  String createTime,
  String description,
  String customerConfirmDate,
  String managerConfirmDate,
  String activeDate,
}) {
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
        txtItemDetail(context, "Mô tả", "$description"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(
            context, "Giá sản phẩm (/1kg)", "${getFormatPrice(price)}đ"),
        SizedBox(
          height: 10,
        ),
        txtItemDetail(context, "Độ", "$degree"),
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
        txtItemDetail(context, "Mã sản phẩm", "#${item["id"]}"),
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
    int account_id,
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
        txtItemDetail(context, "ID khách hàng", "#$account_id"),
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
            accountId: account_id),
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
Widget miniContainer({
  String tittle,
  double height,
  double width,
  Color colorContainer,
  Color colorText,
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
}) {
  return Container(
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
          color: Colors.black54,
          blurRadius: 3,
          offset: Offset(1, 1), // Shadow position
        ),
      ],
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: paddingLeftOfText == null ? 0 : paddingLeftOfText,
            right: paddingRightOfText == null ? 0 : paddingRightOfText,
            bottom: paddingBottomOfText == null ? 0 : paddingBottomOfText,
            top: paddingTopOfText == null ? 0 : paddingTopOfText),
        child: Text(
          tittle,
          style: GoogleFonts.roboto(
              color: colorText,
              fontWeight: fontWeightText,
              fontSize: fontSize == null ? null : fontSize),
        ),
      ),
    ),
  );
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
