import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailAdvancePage extends StatefulWidget {
  const DetailAdvancePage({Key key, this.status}) : super(key: key);
  final String status;
  @override
  _DetailAdvancePageState createState() => _DetailAdvancePageState();
}

class _DetailAdvancePageState extends State<DetailAdvancePage> {
  // String status = 'Da tra';
  String header1, header2;

  void _showHeader() {
    if (widget.status == 'Đã huy') {
      setState(() {
        header1 = 'Giao dịch that bai';
        header2 = 'Don da bi huy';
      });
    } else if (widget.status == 'Dang cho') {
      setState(() {
        header1 = 'Quý khách đã tạo yêu cầu ứng tiền thành công';
        header2 = 'So tien';
      });
    } else if (widget.status == 'Chờ xác nhận') {
      setState(() {
        header1 = 'Xác nhận thông tin giao dịch';
        header2 = 'Số tiền';
      });
    } else if (widget.status == 'Da tra') {
      setState(() {
        header1 = 'Quy khach da tra tien thanh cong';
        header2 = 'Số tiền';
      });
    } else if (widget.status == 'active') {
      setState(() {
        header1 = 'Số tiền quý khách cần trả là';
        header2 = '';
      });
    } else {
      setState(() {
        header1 = 'Giao dịch thành công';
        header2 = 'Quý khách đã mượn tiền thành công';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._showHeader();
    print(widget.status);
  }

  // Chờ xác nhận
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0BB791),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          elevation: 0,
          leading: leadingAppbar(context),
        ),
      ),
      body: widgetContentAdvance(context, widget.status, header1, header2),
    );
  }
}
