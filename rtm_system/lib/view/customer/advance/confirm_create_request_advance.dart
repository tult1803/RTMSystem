import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmRequestAdvance extends StatefulWidget {
  const ConfirmRequestAdvance({Key key, this.listInfor,
    this.isCustomer}): super(key: key);
  final List listInfor;
  final bool isCustomer;
  @override
  _ConfirmRequestAdvanceState createState() => _ConfirmRequestAdvanceState();
}

class _ConfirmRequestAdvanceState extends State<ConfirmRequestAdvance> {
  String token, personSale = '', phoneSale = '', nameProduct;
  DateTime date = DateTime.now();
  List<DataProduct> dataListProduct = [];
  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
      personSale = prefs.getString("fullname");
      phoneSale = prefs.getString("phone");
    });
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, "");
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });
      setState(() {
        // ignore: unnecessary_statements
        dataListProduct;
        nameProduct = _nameProduct();
      });
      return dataListProduct;
    }
  }

  String _nameProduct() {
    String name;
    if (dataListProduct != null) {
      dataListProduct?.map((item) {
        if (item.id== widget.listInfor[0]) {
          name = item.name;
        }
      })?.toList() ??
          [];
    }
    return name;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        leading: leadingAppbar(context),
        title: Text(
          "Tạo yêu cầu bán hàng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: widgetCreateAdvance( context, widget.listInfor, nameProduct,
          personSale, phoneSale, widget.isCustomer),
    );
  }
}
