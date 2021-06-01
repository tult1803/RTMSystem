import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/customer/invoice/detail_invoice.dart';

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
            fontWeight: FontWeight.w200,
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
                fontWeight: FontWeight.w200,
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            AutoSizeText(
              "${detailType}",
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w200,
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
Widget txtItemDetail(context, String title, String content) {
  var size = MediaQuery.of(context).size;
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
        content,
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
                txtPersonInvoice(context, 'Người mua', 'Nguyen Van A', '0123456789'),
                SizedBox(
                  height: 10,
                ),
                txtPersonInvoice(context, 'Người bán', 'Nguyen Van A', '087654322'),
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
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {},
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
                txtItemDetail(context, 'Ngày mượn', 'Nguyen Van A'),
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
                        btnAcceptOrReject(context, 150, Colors.redAccent,
                            'Từ chối', false, 0),
                        SizedBox(width: 20),
                        btnAcceptOrReject(context, 150, Color(0xFF0BB791),
                            'Chấp nhận', true, 0),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),

        //button "Nhận tiền" show if status is "chưa trả", để hoàn thành đơn giao dịch
        if (status == 'Dang cho')
          Center(
            child: SizedBox(
              width: 150,
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeCustomerPage(index: 0,)),
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

Widget leadingAppbar(BuildContext context){
  return IconButton(
    icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  );
}
//Dùng cho trang notice để hiện thỉ các notice
Widget btnProcess(
    BuildContext context, int id, String tittle, String content, String date, bool isInvoice) {
  var size = MediaQuery.of(context).size;
  //Format lại ngày
  DateTime _date = DateTime.parse(date);
  final fBirthday = new DateFormat('dd/MM/yyyy hh:mm');

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
            if(isInvoice){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailInvoicePage()),
              );
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailInvoicePage( )),
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
                "${fBirthday.format(_date)}",
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