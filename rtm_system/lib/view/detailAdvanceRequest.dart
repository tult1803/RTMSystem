import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_AdvanceRequest.dart';
import 'package:rtm_system/model/getAdvanceDetail.dart';
import 'package:rtm_system/model/model_AdvanceDetail.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAdvancePage extends StatefulWidget {
  final String id;
  int status;
  final bool isCustomer;
  final bool isRequest;
  final Widget widgetToNavigator;

  DetailAdvancePage(
      {this.id, this.status, this.isCustomer, this.isRequest, this.widgetToNavigator});

  @override
  _DetailAdvancePageState createState() => _DetailAdvancePageState();
}

class _DetailAdvancePageState extends State<DetailAdvancePage> {
  AdvanceDetail advanceDetail = AdvanceDetail();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future getDetail() async {
    GetAdvanceDetail getAdvanceDetail = GetAdvanceDetail();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    // Đỗ dữ liệu lấy từ api
    advanceDetail = await getAdvanceDetail.getAdvanceDetail(token, widget.id, widget.status);
    return advanceDetail;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new FutureBuilder(
      future: getDetail(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: containerDetail(
              context,
              componentContainerDetailAdvanceRequest(
                context,
                id: advanceDetail.id,
                storeName: advanceDetail.storeName,
                storeId: advanceDetail.storeId,
                customerName: advanceDetail.customerName,
                customerPhone: '0912222-phone',
                createDate: advanceDetail.createDate,
                activeDate: advanceDetail.processDate,
                amount: advanceDetail.amount,
                managerName: advanceDetail.managerName,
                managerPhone: '0912222-phone',
                statusId: advanceDetail.statusId,
                isCustomer: widget.isCustomer,
                description: advanceDetail.description,
                reason: '',
                widgetToNavigator: this.widget.widgetToNavigator,
              ),
            ),
          );
        }
        return Container(
            height: size.height,
            child: Center(child: CircularProgressIndicator(color: Colors.white,)));
      },
    );
  }
}
