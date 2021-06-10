import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key key, this.isNew, this.listProduct})
      : super(key: key);

  //false will show btn 'Sửa lại sản phẩm'
  final bool isNew;
  final List listProduct;

  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
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
      dataList = await getProduct.getProduct(token, 0);
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
        print(data);
      });
      setState(() {
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
            if (item.id.toString() == widget.listProduct[0]) {
              name = item.name;
              print('Name' + name);
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
      body: widgetCreateInvoice(
          context, widget.isNew, widget.listProduct, nameProduct,date),
    );
  }
}
