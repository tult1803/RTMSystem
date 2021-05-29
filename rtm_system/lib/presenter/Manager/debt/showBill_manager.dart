import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/debt/processBill.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';

class showAllBill extends StatefulWidget {
  const showAllBill({Key key}) : super(key: key);

  @override
  _showAllBillState createState() => _showAllBillState();
}

DateTime fromDate;
DateTime toDate;
var fDate = new DateFormat('dd-MM-yyyy');

class _showAllBillState extends State<showAllBill> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 2));
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
            children: [
              btnMain(
                  context,150, "Đơn chờ xử lý", Icon(Icons.update), processBill()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnDateTime(context, "${fDate.format(fromDate)}",
                      Icon(Icons.date_range), datePick()),
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
                  btnDateTime(context, "${fDate.format(toDate)}",
                      Icon(Icons.date_range), datePick()),
                ],
              ),
              SizedBox(height: 0.5, child: Container(color: Colors.black38,),),
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      card(
                          context,
                          "Lê Thanh Tú",
                          "Trạng thái",
                          "Hoàn thành",
                          "10000000",
                          "2021-05-20",
                          Colors.green,
                          FormForDetailPage(
                            tittle: "Chi tiết ứng tiền",
                          )),
                      card(
                          context,
                          "Nguyen Thị C",
                          "Trạng thái",
                          "Trễ",
                          "10000000",
                          "2021-05-20",
                          Colors.redAccent,
                          FormForDetailPage(
                            tittle: "Chi tiết ứng tiền",
                          )),
                      card(
                          context,
                          "Lê Thanh Tú",
                          "Trạng thái",
                          "Chờ",
                          "10000000",
                          "2021-05-20",
                          Colors.orangeAccent,
                          FormForDetailPage(
                            tittle: "Chi tiết ứng tiền",
                          )),
                      card(
                          context,
                          "Lê Thanh Tú",
                          "Trạng thái",
                          "Hoàn thành",
                          "10000000",
                          "2021-05-20",
                          Colors.green,
                          FormForDetailPage(
                            tittle: "Chi tiết ứng tiền",
                          )),
                      card(
                          context,
                          "Lê Thanh Tú",
                          "Trạng thái",
                          "Hoàn thành",
                          "10000000",
                          "2021-05-20",
                          Colors.green,
                          FormForDetailPage(
                            tittle: "Chi tiết ứng tiền",
                          )),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
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
    );

  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(
        start: fromDate,
        end: toDate);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
      saveText: "Xác nhận",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: welcome_color,)),
          child: child,
        );});
    if(dateRange != null){
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
      });
    }
  }
}
