import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class updateProfile extends StatefulWidget {
  const updateProfile({Key key}) : super(key: key);

  @override
  _updateProfileState createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Cập nhật thông tin",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
      ),
      body: new Container(),
    );
  }
}
