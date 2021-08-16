import 'package:flutter/material.dart';
import 'package:rtm_system/model/get/getAdvanceDetail.dart';
import 'package:rtm_system/model/model_AdvanceDetail.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAdvancePage extends StatefulWidget {
  final String id;
  int status;
  final bool isCustomer;
  final bool isRequest;
  final String phoneCustomer;
  final Widget widgetToNavigator;

  DetailAdvancePage(
      {this.id,
      this.status,
      this.isCustomer,
      this.isRequest,
      this.phoneCustomer,
      this.widgetToNavigator});

  @override
  _DetailAdvancePageState createState() => _DetailAdvancePageState();
}

class _DetailAdvancePageState extends State<DetailAdvancePage> {
  AdvanceDetail advanceDetail = AdvanceDetail();
  String imageUrl;
  @override
  void initState() {
    super.initState();
  }

  Future getDetail() async {
    GetAdvanceDetail getAdvanceDetail = GetAdvanceDetail();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    // Đỗ dữ liệu lấy từ api
    advanceDetail = await getAdvanceDetail.getAdvanceDetail(
        token, widget.id, widget.status);
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
                customerPhone: advanceDetail.customerPhone,
                createDate: advanceDetail.createDate,
                activeDate: advanceDetail.processDate,
                amount: advanceDetail.amount,
                statusId: advanceDetail.statusId,
                activeStatus: advanceDetail.acceptStatusId,
                receiveDate: advanceDetail.receiveDate,
                isCustomer: widget.isCustomer,
                description: advanceDetail.description,
                reason: advanceDetail.reason,
                imageUrl: imageUrl,
                widgetToNavigator: widget.widgetToNavigator,
              ),
            ),
          );
        } 
        else if(snapshot.hasError){
          return showErrorLoadData();
        }
        return Container(
            height: size.height,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )));
      },
    );
  }
}
