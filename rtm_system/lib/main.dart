import 'package:flutter/material.dart';
import 'package:rtm_system/view/welcome_page.dart';
import 'view/manager/allCustomer_manager.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      // home:AllCustomer(),
    ),
  );
}
