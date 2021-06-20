import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}
DateTime fromDate;
DateTime toDate;
class _InvoicePageState extends State<InvoicePage> {
  final PageController _pageController = PageController();
  String getFromDate, getToDate;
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
            "Hóa đơn",
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
            tittleBarForInvoice("Yêu cầu bán hàng", isChoose: index == 0 ? true : null),
            if(index == 1)
            tittleBarForInvoice("Hoá đơn chờ xử lý", isChoose: index == 1 ? true : null),
            if(index == 2)
            tittleBarForInvoice("Hoá đơn ký gửi", isChoose: index == 2 ? true : null),
            if(index == 3)
            tittleBarForInvoice("Hoá đơn bán hàng", isChoose: index == 3 ? true : null),
            if(index == 4)
            tittleBarForInvoice("Hoá đơn hoàn trả", isChoose: index == 4 ? true : null),
          ]),
    );
  }
  Widget tittleBarForInvoice(String tittle, {bool isChoose}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (tittle) {
            case "Yêu cầu bán hàng":
              _pageController.jumpToPage(0);
              break;
            case "Hoá đơn chờ xử lý":
              _pageController.jumpToPage(1);
              break;
            case "Hoá đơn ký gửi":
              _pageController.jumpToPage(2);
              break;
            case "Hoá đơn bán hàng":
              _pageController.jumpToPage(3);
              break;
            case "Hoá đơn hoàn trả":
              _pageController.jumpToPage(4);
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
          new showAllInvoicePage(4, fromDate: getFromDate, toDate: getToDate),
          new showAllInvoicePage(5, fromDate: getFromDate, toDate: getToDate),
          new showAllInvoicePage(-1, fromDate: getFromDate, toDate: getToDate),
          new showAllInvoicePage(1, fromDate: getFromDate, toDate: getToDate),
        ],
      ),
    );
  }

  // Widget _showBottomButton() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       btnWaitingProcess(context, true),
  //       SizedBox(
  //         width: 200,
  //         child: RaisedButton(
  //             color: Color(0xFF0BB791),
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => AddProductPage(
  //                           isCustomer: true,
  //                           tittle: "Tạo yêu cầu bán hàng",
  //                         )),
  //               );
  //             },
  //             child: Text(
  //               'Gửi yêu cầu bán hàng',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //             elevation: 10),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _showProcessButton() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           SizedBox(
  //             width: 150,
  //             child: RaisedButton(
  //               color: Colors.white70,
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => GetMoneyOrPayDebt(
  //                             isPay: true,
  //                           )),
  //                 );
  //               },
  //               child: Text('Trả nợ'),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               elevation: 10,
  //             ),
  //           ),
  //           Text(' '),
  //           SizedBox(
  //             width: 150,
  //             child: RaisedButton(
  //               color: Color(0xFF0BB791),
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => GetMoneyOrPayDebt(
  //                             isPay: false,
  //                           )),
  //                 );
  //               },
  //               child: Text(
  //                 'Lấy tiền',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               elevation: 10,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
