import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showInvoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showRequestInvoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class showAllInvoice extends StatefulWidget {
  const showAllInvoice({Key key}) : super(key: key);

  @override
  _showAllInvoiceState createState() => _showAllInvoiceState();
}

DateTime fromDate;
DateTime toDate;

class _showAllInvoiceState extends State<showAllInvoice> {
  final PageController _pageController = PageController();
  int index;
  Invoice invoice;
  List invoiceList;
  String getFromDate, getToDate;

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
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomBar(),
            rowButtonDatetime(),
            Expanded(child: pageViewInvocie()),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(bottom: 20),
      color: welcome_color,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconBottom(Icon(Icons.assignment_outlined), "Yêu cầu", isChoose: index == 0 ? true : null),
          iconBottom(Icon(Icons.update), "Xử lý", isChoose: index == 1 ? true : null),
          iconBottom(Icon(Icons.description), "Hiệu lực", isChoose: index == 2 ? true : null),
          iconBottom(Icon(Icons.attach_money), "Ký gửi", isChoose: index == 3 ? true : null),
          iconBottom(Icon(Icons.check), "Hoàn thành", isChoose: index == 4 ? true : null),
          // iconBottom(Icon(Icons.clear), "Từ chối", isChoose: index == 5 ? true : null),
        ],
      ),
    );
  }

  Widget iconBottom(Icon icon, String tittle, {bool isChoose}) {
    return Expanded(
      child: GestureDetector(
          onTap: () {
              switch (tittle) {
                case "Yêu cầu":
                  _pageController.jumpToPage(0);
                  break;
                case "Xử lý":
                  _pageController.jumpToPage(1);
                  break;
                case "Hiệu lực":
                  _pageController.jumpToPage(2);
                  break;
                case "Ký gửi":
                  _pageController.jumpToPage(3);
                  break;
                case "Hoàn thành":
                  _pageController.jumpToPage(4);
                  break;
                // case "Từ chối":
                //   _pageController.jumpToPage(5);
                //   break;
              }
          },
          child: Container(
            color: welcome_color,
            child: Column(
              children: [
                Icon(icon.icon,
                    color: isChoose == null ? Colors.white54 : Colors.white),
                SizedBox(height: 10,),
                tittleOfIconBottom(tittle, isChoose: isChoose),
                SizedBox(height: 13,),
                Container(height: 3, color: isChoose == null ? welcome_color : Colors.white)
              ],
            ),
          )),
    );
  }

  Widget tittleOfIconBottom(String tittle, {bool isChoose}) {
    return Container(
      height: 20,
      child: AutoSizeText(
        tittle,
        style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.none,
            color: isChoose == null ? Colors.white54 : Colors.white),
      ),
    );
  }

  //Dùng để show 2 cái nút để chọn ngày
  Widget rowButtonDatetime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        btnDateTime(
            context,
            "${getDateTime("$fromDate", dateFormat: "dd/MM/yyyy")}",
            Icon(Icons.date_range),
            datePick()),
        SizedBox(
          width: 20,
          child: Center(
              child: Container(
                  alignment: Alignment.topCenter,
                  height: 45,
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ))),
        ),
        btnDateTime(
            context,
            "${getDateTime("$toDate", dateFormat: "dd/MM/yyyy")}",
            Icon(Icons.date_range),
            datePick()),
      ],
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
        new showInvoiceRequestManager(),
        new showInvoiceManager(4, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(1, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(5, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(3, fromDate: getFromDate, toDate: getToDate),
        // new showInvoiceManager(2, fromDate: getFromDate, toDate: getToDate),
      ],
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget loadingPage() {
    return Container(
      child: Center(
          child: Container(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(color: welcome_color))),
    );
  }

//Copy nó để tái sử dụng cho các trang khác nếu cần
// Không thể tách vì nó có hàm setState
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
        toDate = dateRange.end;
        getFromDate =
            "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
        getToDate =
            "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      });
    }
  }

}
