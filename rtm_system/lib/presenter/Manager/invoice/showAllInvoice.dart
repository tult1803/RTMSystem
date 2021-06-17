import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showInvoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';

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
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd hh:mm:ss")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd hh:mm:ss")}";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              btnMain(
                  context,
                  120,
                  "Tạo hóa đơn",
                  Icon(Icons.post_add),
                  //Đây là trang create invoice
                  AddProductPage(
                    tittle: "Tạo hóa đơn",
                    isCustomer: false,
                  )),
              rowButtonDatetime(),
              _wrapToShowTittleBar(),
              Expanded(child:pageViewInvocie()),
            ],
          ),
        ),
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
        new showInvoiceManager(4, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(5, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(3, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(2, fromDate: getFromDate, toDate: getToDate),
        new showInvoiceManager(1, fromDate: getFromDate, toDate: getToDate),
      ],
    ));
  }

  //Để show thanh hiển thị tên các loại hóa đơn
  Widget _wrapToShowTittleBar() {
    return Container(
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,

          children: [
        tittleBarForInvoice("Đang xử lý", isChoose: index == 0 ? true : null),
        spaceTittleBarForInvoice(),
        tittleBarForInvoice("Ký gửi", isChoose: index == 1 ? true : null),
        spaceTittleBarForInvoice(),
        tittleBarForInvoice("Hoàn thành", isChoose: index == 2 ? true : null),
        spaceTittleBarForInvoice(),
        tittleBarForInvoice("Từ chối", isChoose: index == 3 ? true : null),
        spaceTittleBarForInvoice(),
        tittleBarForInvoice("Có hiệu lực", isChoose: index == 4 ? true : null),
      ]),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget loadingPage(){
    return Container(
      child: Center(child: Container(width: 35,height: 35,child: CircularProgressIndicator(color: welcome_color))),
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
            "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd hh:mm:ss")}";
        getToDate =
            "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd hh:mm:ss")}";
        _pageController.jumpToPage(index+1);
       Future.delayed(Duration(milliseconds: 100), (){
         _pageController.jumpToPage(index-1);
       });
      });
    }
  }

  Widget tittleBarForInvoice(String tittle, {bool isChoose}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (tittle) {
            case "Đang xử lý":
              _pageController.jumpToPage(0);
              break;
            case "Ký gửi":
              _pageController.jumpToPage(1);
              break;
            case "Hoàn thành":
              _pageController.jumpToPage(2);
              break;
            case "Từ chối":
              _pageController.jumpToPage(3);
              break;
            case "Có hiệu lực":
              _pageController.jumpToPage(4);
              break;
          }
        });
      },
      child: Text(
        tittle,
        style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.none,
            color: isChoose == null ? Colors.black54 : welcome_color),
      ),
    );
  }

  Widget spaceTittleBarForInvoice() {
    return SizedBox(
      width: 15,
      child: Text(
        " |",
        style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.none,
            color: Colors.black54),
      ),
    );
  }
}
