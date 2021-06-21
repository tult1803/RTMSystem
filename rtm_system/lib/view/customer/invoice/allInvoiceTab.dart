import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/presenter/Customer/show_invoice_request.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
class InvoiceTab extends StatefulWidget {
  const InvoiceTab({Key key}) : super(key: key);

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}
DateTime fromDate;
DateTime toDate;

class _InvoiceTabState extends State<InvoiceTab>
    with TickerProviderStateMixin {
  TabController _tabController;
  final PageController _pageController = PageController();
  String getFromDate, getToDate;
  int index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        centerTitle: true,
        title: const Text('Hoá đơn', style: TextStyle( color: Colors.white),),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.5),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.post_add_outlined,),
              child: Text('Yêu cầu', style: TextStyle(),),
            ),
            Tab(
              icon: Icon(Icons.access_time_outlined),
              child: Text('Xử lý'),
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              child: Text('Ký gửi'),
            ),
            Tab(
              icon: Icon(Icons.my_library_books_outlined),
              child: Text('Bán hàng'),
            ),
            Tab(
              icon: Icon(Icons.my_library_books_outlined),
              child: Text('Hoàn trả'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
              height: size.height,
              margin: EdgeInsets.only(left: 5, top: 12, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    rowButtonDatetime(),
                    new showAllInvoiceRequestPage(fromDate: getFromDate, toDate: getToDate),
                  ],
                ),
              )
          ),
          Container(
              height: size.height,
              margin: EdgeInsets.only(left: 5, top: 12, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    rowButtonDatetime(),
                    new showAllInvoicePage(4, fromDate: getFromDate, toDate: getToDate),
                  ],
                ),
              )
          ),
          Container(
            height: size.height,
            margin: EdgeInsets.only(left: 5, top: 12, right: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  rowButtonDatetime(),
                  _showProcessButton(),
                  new showAllInvoicePage(5, fromDate: getFromDate, toDate: getToDate),
                ],
              ),
            )
          ),
          Container(
              height: size.height,
              margin: EdgeInsets.only(left: 5, top: 12, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    rowButtonDatetime(),
                    new showAllInvoicePage(-1, fromDate: getFromDate, toDate: getToDate),
                  ],
                ),
              )
          ),
          //đây sẽ show các hoá đơn hoàn trả
          Container(
              height: size.height,
              margin: EdgeInsets.only(left: 5, top: 12, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    rowButtonDatetime(),
                    new showAllInvoicePage(-1, fromDate: getFromDate, toDate: getToDate),
                  ],
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child :Icon(Icons.add, color: Colors.white, size: 20,),
        backgroundColor: welcome_color,
      ),
    );
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
    print(initialDateRange);
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
      print(dateRange.end);
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
        // vì dateRange.end lấy ngày và giờ là 00:00:00 nên + thêm 1 ngày để lấy đúng 1 ngày
        getToDate =
        "${getDateTime("${toDate.add(Duration(days: 1))}", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      });
    }
  }
  Widget _showProcessButton() {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * 0.35,
            child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => GetMoneyOrPayDebt(
                //             isPay: false,
                //           )),
                // );
              },
              child: Text(
                'Lấy tiền',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
          )
        ],
      ),
    );
  }
}
