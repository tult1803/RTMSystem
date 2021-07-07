import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_information_store.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Liên hệ', style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: new showStore(),
      ),
    );
  }
}
