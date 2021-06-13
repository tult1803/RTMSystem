import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/view/customer/invoice/invoice_by_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showProductInInvoice extends StatefulWidget {
  const showProductInInvoice({Key key}) : super(key: key);

  @override
  _showAdvanceState createState() => _showAdvanceState();
}

class _showAdvanceState extends State<showProductInInvoice> {
  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  String token;
  List<DataProduct> dataListProduct = [];
  bool isVip= false;

  Future _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
  }

  Future _getProduct() async {
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, 0);
      //Parse dữ liệu
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });
      return dataListProduct;
    }
  }
  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
    await getAPIProfileCustomer.getProfileCustomer(token, phone);
    this.isVip = infomationCustomer.vip;
    return infomationCustomer;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    this.getAPIProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: new FutureBuilder(
        future: _getProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _cardItem(
                    snapshot.data[index].id, snapshot.data[index].name, this.isVip);
              },
            );
          }
          return Container(
              height: size.height * 0.7,
              child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  Widget _cardItem(int id, String product, bool isVip) {
    return FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InvoiceByProductPage(
              isVip: isVip, nameProduct: product, idProduct: id.toString(),)),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(
                  '${product}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,),
                ),
                subtitle: Text(
                  'Ấn vào để xem chi tiết các hoá đơn',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ));
  }
}
