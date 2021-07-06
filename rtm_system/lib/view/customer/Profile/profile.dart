import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/verification/front_identity_card.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(imageBack != null){
      imageBack = null;
    }
    if(imageFront != null){
      imageFront = null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Thông tin cá nhân', style: TextStyle( color: Colors.white),),),
      body: showProfile(),
    );
  }
}
