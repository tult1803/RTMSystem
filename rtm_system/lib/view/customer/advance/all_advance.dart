import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/presenter/Customer/show_invoice_request.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/advance/create_request_advance.dart';
import 'package:rtm_system/view/customer/getMoney_or_payDebt.dart';
class AdvancePage extends StatefulWidget {
  const AdvancePage({Key key}) : super(key: key);

  @override
  State<AdvancePage> createState() => _AdvancePageState();
}
DateTime fromDate;
DateTime toDate;

class _AdvancePageState extends State<AdvancePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  final PageController _pageController = PageController();
  String getFromDate, getToDate;
  //index on Tab
  int index, _selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    //tab 1: yeu cau
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Ứng tiền', style: TextStyle( color: Colors.white),),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.5),
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'Yêu cầu',
              icon: Icon(Icons.post_add_outlined,),
            ),
            Tab(
              text: 'Chờ xử lý',
              icon: Icon(Icons.access_time_outlined),
            ),
            Tab(
              text: 'Hoàn thành',
              icon: Icon(Icons.access_time_outlined),
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
          //Show advance processing
          containerInvoice(size.height, 4),
          //Show advance done and active
          containerInvoice(size.height, 3),
        ],
      ),
      floatingActionButton: _showFloatBtn(_selectedIndex),
    );
  }
  //show invoice advance
  Widget containerInvoice(height, status){
    return  Container(
        height: height,
        margin: EdgeInsets.only(left: 5, top: 12, right: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              rowButtonDatetime(),
              new showAllInvoicePage(status, fromDate: getFromDate, toDate: getToDate),
            ],
          ),
        )
    );
  }
  Widget _showFloatBtn(index){
    if(index == 2 ){
      return  FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GetMoneyOrPayDebt(isPay: true,)),
          );
        },
        label: Text('Trả nợ', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 10,
      );
    }else{
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestAdvance()),
          );
        },
        child :Icon(Icons.post_add_outlined, color: Colors.white, size: 25,),
        backgroundColor: primaryColor,
      );
    }
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
                  primary: primaryColor,
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
}
