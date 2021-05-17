import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/login_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Timer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: welcome_color,
        child: Image(image: AssetImage("images/rtmLogo.png"), )
    );
  }

  Future _Timer(){
    Timer _timer = new Timer.periodic(Duration(seconds: 3), (Timer timer){
      Navigator.pushAndRemoveUntil(
          this.context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
      // Dừng timer
      timer.cancel();
    });
  }
}
