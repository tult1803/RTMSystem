import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class InvoiceByProductPage extends StatefulWidget {
  const InvoiceByProductPage({Key key, this.isVip, this.nameProduct, this.idProduct})
      : super(key: key);
  final bool isVip;
  final String nameProduct;
  final String idProduct;

  @override
  _InvoiceByProductPageState createState() => _InvoiceByProductPageState();
}

class _InvoiceByProductPageState extends State<InvoiceByProductPage> {
  var formatter = new DateFormat('dd-MM-yyyy');
  String title = '';
  DateTime fromDate;
  DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    title = "Hóa đơn ${widget.nameProduct.toLowerCase()}";
    print(widget.idProduct+ "ne");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          leading: leadingAppbar(context),
          centerTitle: true,
          backgroundColor: Color(0xFF0BB791),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                top: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      btnDateTime(context, "${formatter.format(fromDate)}",
                          Icon(Icons.date_range), datePick()),
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
                      btnDateTime(context, "${formatter.format(toDate)}",
                          Icon(Icons.date_range), datePick()),
                    ],
                  ),

                  new showAllInvoicePage(idProduct: widget.idProduct,isAll: true,),
                ],
              )),
        ));
  }

  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
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
      });
    }
  }

  Widget btnDateTime(
      BuildContext context, String tittle, Icon icon, Widget widget) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 140,
          child: RaisedButton(
            color: Colors.white70,
            onPressed: () {},
            child: Text('$tittle'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(color: Colors.black, width: 0.5),
            ),
            height: 35.0,
            width: 120,
            child: widget),
      ],
    );
  }


}
