import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_Notice.dart';
import 'package:rtm_system/view/customer/advance/detail_advance.dart';
import 'package:rtm_system/view/customer/invoice/detail_invoice.dart';

class ProcessAllPage extends StatefulWidget {
  const ProcessAllPage({Key key, this.indexPage}) : super(key: key);
  final int indexPage;
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
    print('Page number: ');
    print(widget.indexPage);
    setState(() {
      index = widget.indexPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        title: Text(title),
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
    return Expanded(
      child: IndexedStack(
        index: index,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Text('Thong bao invoice'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Text('Thong bao advance'),
          ),
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
          //
          child: Text('Hóa đơn mua', style: TextStyle(fontSize: 15.0),),
          onPressed: () {
            //call api to get all notice mua ban
            setState(() {
              index = 0;
              _hasBeenPressed = true;
            });
          },
        ),
        RaisedButton(
          child: Text('Hóa đơn ứng tiền', style: TextStyle(fontSize: 15.0),),
          // 2
          color: _hasBeenPressed ? Color(0xffEEEEEE) : Color(0xFF0BB791),
          // 3
          onPressed: () => {
            //call api to get all notice ung tien

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