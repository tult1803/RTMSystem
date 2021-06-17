import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_product_in_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';
import 'package:rtm_system/view/customer/getMoney_or_payDebt.dart';
class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Text("Tất cả hóa đơn", style: TextStyle(
            color:Colors.white,
          ),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                top: 12,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  _showBottomButton(),
                  _showProcessButton(),
                  SizedBox(
                    height: 12,
                  ),
                  new showProductInInvoice(),
                ],
              )),
        ));
  }



  Widget _showBottomButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        btnWaitingProcess(context, true),
        SizedBox(
          width: 200,
          child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductPage(isCustomer: true,tittle: "Tạo yêu cầu bán hàng",)),
                );
              },
              child: Text(
                'Gửi yêu cầu bán hàng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10),
        ),
      ],
    );
  }


  Widget _showProcessButton() {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              child: RaisedButton(
                color: Colors.white70,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetMoneyOrPayDebt(isPay: true, )),
                  );
                },
                child: Text('Trả nợ'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
            Text(' '),
            SizedBox(
              width: 150,
              child: RaisedButton(
                color: Color(0xFF0BB791),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetMoneyOrPayDebt(isPay: false,)),
                  );
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
            ),
          ],
        ),
      ],
    );
  }
}
