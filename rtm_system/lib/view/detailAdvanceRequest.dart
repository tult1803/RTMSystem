import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
class DetailAdvanceRequest extends StatefulWidget {
  final Map<String, dynamic> map;
  final bool isCustomer;
  DetailAdvanceRequest({this.map, this.isCustomer});
  @override
  _DetailAdvanceRequestState createState() => _DetailAdvanceRequestState();
}

class _DetailAdvanceRequestState extends State<DetailAdvanceRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: containerDetail(
          context,
          componentContainerDetailAdvanceRequest(
            context,
            id: "${this.widget.map["id"]}",
            storeName: this.widget.map["store_name"],
            customerName: this.widget.map["customer_name"],
            customerPhone: this.widget.map["customer_phone"],
            createDate: this.widget.map["create_date"],
            money: "${this.widget.map["price"]}",
            isCustomer: widget.isCustomer,
          ),
        ),
      ),
    );
  }
}
