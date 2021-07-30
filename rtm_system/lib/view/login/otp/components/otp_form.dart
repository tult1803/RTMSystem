
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import '../../check_phone.dart';


class OtpForm extends StatefulWidget {

  @override
  _OtpFormState createState() => _OtpFormState();
}


class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(int index, String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
      setState(() {
        switch(index){
          case 1: pin1 = value.trim();break;
          case 2: pin2 = value.trim();break;
          case 3: pin3 = value.trim();break;
          case 4: pin4 = value.trim();break;
          case 5: pin5 = value.trim();break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(1, value, pin2FocusNode);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(2, value, pin3FocusNode),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(3, value, pin4FocusNode),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(4, value, pin5FocusNode),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      focusNode: pin5FocusNode,
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(5, value, pin6FocusNode),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: SizedBox(
                    child: TextFormField(
                      focusNode: pin6FocusNode,
                      maxLength: 1,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value6) {
                        if (value6.length == 1) {
                          pin6FocusNode.unfocus();
                          setState(() {
                            pin6 = value6.trim();
                          });
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    counterText: "",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: welcome_color),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: welcome_color),
    ),
  );

}
