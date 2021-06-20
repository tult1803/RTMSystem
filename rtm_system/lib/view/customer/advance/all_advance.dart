import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class AdvancePage extends StatefulWidget {
  const AdvancePage({Key key, this.money}) : super(key: key);
  final String money;

  @override
  _AdvancePageState createState() => _AdvancePageState();
}
DateTime fromDate;
DateTime toDate;
class _AdvancePageState extends State<AdvancePage> {
  final PageController _pageController = PageController();
  String getFromDate, getToDate, search;
  int index ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    getFromDate =
    "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Text(
            "Ứng tiền",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, top: 12, right: 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: size.height * 0.01),
                height: size.height * 0.045,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: _wrapToShowTittleBar(),
              ),
              SizedBox(
                height: 12,
              ),
              rowButtonDatetime(),
              Expanded(child: pageViewInvocie()),
            ],
          ),
        ));
  }

  Widget rowButtonDatetime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        btnDateTimeForCustomer(
            context,
            "${getDateTime("$fromDate", dateFormat: "dd-MM-yyyy")}",
            Icon(Icons.date_range),
            datePick()),
        SizedBox(
          child: Center(
              child: Container(
                  alignment: Alignment.topCenter,
                  height: 20,
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ))),
        ),
        btnDateTimeForCustomer(
            context,
            "${getDateTime("$toDate", dateFormat: "dd-MM-yyyy")}",
            Icon(Icons.date_range),
            datePick()),
      ],
    );
  }

  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
      child: null,
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              //Dùng cho nút "X" của lịch
                appBarTheme: AppBarTheme(
                  iconTheme:
                  theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //Dùng cho nút chọn ngày và background
                colorScheme: ColorScheme.light(
                  primary: welcome_color,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end.add(Duration(days: 1));
        getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
        getToDate =
        "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      });
    }
  }
  Widget _wrapToShowTittleBar() {
    return Container(
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            if(index == 0)
              tittleBarForInvoice("Yêu cầu ứng tiền", isChoose: index == 0 ? true : null),
            if(index == 1)
              tittleBarForInvoice("Hoá đơn ứng tiền", isChoose: index == 1 ? true : null),
          ]),
    );
  }
  Widget tittleBarForInvoice(String tittle, {bool isChoose}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (tittle) {
            case "Yêu cầu ứng tiền":
              _pageController.jumpToPage(0);
              break;
            case "Hoá đơn ứng tiền":
              _pageController.jumpToPage(1);
              break;

          }
        });
      },
      child: Text(tittle,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: welcome_color,
          )),

    );
  }


  //Để show các hóa đơn dựa trên _wrapToShowTittleBar tương ứng
  Widget pageViewInvocie() {
    return Container(
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        children: [
          new showAllInvoicePage(4, fromDate: getFromDate, toDate: getToDate),
          new showAllInvoicePage(1, fromDate: getFromDate, toDate: getToDate),
        ],
      ),
    );
  }

  Widget _txtFormField(String value, bool obscureText, String hintText,
      int maxLines, TextInputType txtType) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width:size.width * 0.9,
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        onChanged: (value) {
          setState(() {
            this.search = value.trim();
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
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
