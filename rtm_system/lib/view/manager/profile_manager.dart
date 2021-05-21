import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profileM_manager.dart';

class ProfileManager extends StatefulWidget {
  const ProfileManager({Key key}) : super(key: key);

  @override
  _ProfileManagerState createState() => _ProfileManagerState();
}

class _ProfileManagerState extends State<ProfileManager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: profilePage(),
    );
  }
}
