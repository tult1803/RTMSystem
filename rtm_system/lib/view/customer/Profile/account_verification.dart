
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/presenter/Customer/verification/front_identity_card.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';

class AccountVerification extends StatefulWidget {

  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context,colorIcon: Colors.white, widget: HomeCustomerPage(index: 3,)),
        centerTitle: true,
        title: const Text('Xác thực thông tin', style: TextStyle( color: Colors.white),),),
      body: FrontIdentifyCard(),
    );
  }
}
