import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/view/customer/process/process_invoice.dart';
import 'package:rtm_system/view/customer/process/process_invoice_processing.dart';

class ProcessAllPage extends StatefulWidget {
  const ProcessAllPage({Key key, this.isInvoice}) : super(key: key);
  final bool isInvoice;
  @override
  _ProcessAllPageState createState() => _ProcessAllPageState();
}

class _ProcessAllPageState extends State<ProcessAllPage> {
  String title = 'Thông tin cần xử lý';

  int index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      index = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        title: Text(title, style: TextStyle(
          color: Colors.white,
        ),),
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: Color(0xFF0BB791),
      ),
      body: Padding(
        child: Column(
          children: [
            _getStackedContainers(),
            _getNavigationButton(),
          ],
        ),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }

  Widget _getStackedContainers() {
    print(index);
    return Expanded(
      child: IndexedStack(
        index: index,
        children: <Widget>[
          new ProcessInvoicePage(),
          //nó đang không nhận null ở date dk nên k show dk
          new ProcessInvoiceProcessing(),
        ],
      ),
    );
  }

  Widget _getNavigationButton() {
    bool _hasBeenPressed = false;
    if(index == 0){
      _hasBeenPressed = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: _hasBeenPressed ? Color(0xFF0BB791) : Color(0xffEEEEEE),
          child: Text('Đơn yêu cầu', style: TextStyle(fontSize: 15.0),),
          onPressed: () {
            setState(() {
              index = 0;
              _hasBeenPressed = true;
            });
          },
        ),
        RaisedButton(
          child: Text('Hóa đơn ứng tiền', style: TextStyle(fontSize: 15.0),),
          color: _hasBeenPressed ? Color(0xffEEEEEE) : Color(0xFF0BB791),
          onPressed: () => {
            setState(() {
              _hasBeenPressed = true;
              index = 1;
            })
          },
        )
      ],
    );
  }
}
