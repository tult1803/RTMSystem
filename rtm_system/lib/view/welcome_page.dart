import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/login_page.dart';
import 'package:rtm_system/view/maintain_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    _Timer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: welcome_color,
        child: Image(image: AssetImage("images/rtmLogo.png"), )
    );
  }

  Future _Timer(){
    Timer _timer = new Timer.periodic(Duration(seconds: 3), (Timer timer) async{
      int status = await doCheckMaintain();
      Navigator.pushAndRemoveUntil(
          this.context,
          MaterialPageRoute(builder: (context) => status == 200 ? LoginPage() : MaintainPage()),
          (route) => false);
      // Dừng timer
      timer.cancel();
    });
  }


}
