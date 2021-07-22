import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/verification/back_identity_card.dart';
import 'package:rtm_system/presenter/Customer/verification/front_identity_card.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';

import '../../form_update_profile.dart';

// ignore: must_be_immutable
class UpgradeAccount extends StatefulWidget {
  InfomationCustomer informationCustomer;

  UpgradeAccount({this.informationCustomer});

  @override
  _UpgradeAccountState createState() => _UpgradeAccountState();
}

File imageBack;
File imageFront;
List dataCustomer = [];
List errorData = [];

class _UpgradeAccountState extends State<UpgradeAccount> {
  int currentStep = 0;
  bool complete = false;
  List<Step> steps;
  static InfomationCustomer informationCustomer;
  bool checkErrorData;

  @override
  void initState() {
    super.initState();
    dataCustomer = ["null", "null", "null", "null", "null"];
    errorData = ["null", "null", "null", "null", "null"];
    if (imageBack != null) imageBack = null;
    if (imageFront != null) imageFront = null;
    getData();
  }

  Future getData() async {
    setState(() {
      informationCustomer = widget.informationCustomer;
      if (informationCustomer != null) {
        getDataCustomer(0, informationCustomer.fullname);
        getDataCustomer(1, informationCustomer.gender);
        getDataCustomer(2, "${informationCustomer.birthday}");
        getDataCustomer(3, "${informationCustomer.cmnd}");
        getDataCustomer(4, "${informationCustomer.address}");
      }
    });
  }

  void getDataCustomer(int index, value) {
    dataCustomer.removeAt(index);
    dataCustomer.insert(index, value);
  }

  // ignore: missing_return
  List<Step> _createSteps(BuildContext context) {
    steps = [
      Step(
        title: const Text('Cập nhật thông tin'),
        isActive: currentStep == 0 ? true : false,
        state: StepState.indexed,
        content: Container(
          child: formUpdateProfile(
            fullname: dataCustomer.elementAt(0) == "null"
                ? null
                : dataCustomer.elementAt(0),
            cmnd: dataCustomer.elementAt(3) == "null"
                ? null
                : dataCustomer.elementAt(3),
            address: dataCustomer.elementAt(4) == "null"
                ? null
                : dataCustomer.elementAt(4),
            birthday: dataCustomer.elementAt(2) == "null"
                ? null
                : DateTime.parse(getDateTime("${dataCustomer.elementAt(2)}",
                    dateFormat: "yyyy-MM-dd")),
            gender: dataCustomer.elementAt(1) == "null"
                ? null
                : dataCustomer.elementAt(1),
            check: true,
            isUpdate: true,
            isUpgrade: true,
            typeOfUpdate: 1,
            accountId: informationCustomer.accountId,
            isCustomer: true,
            isCreate: false,
          ),
        ),
      ),
      Step(
        isActive: currentStep == 1 ? true : false,
        state: StepState.indexed,
        title: const Text('Chụp mặt trước CMND/CCCD'),
        content: Column(
          children: <Widget>[
            FrontIdentifyCard(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      Step(
        isActive: currentStep == 2 ? true : false,
        state: StepState.indexed,
        title: const Text('Chụp mặt sau CMND/CCCD'),
        content: Column(
          children: <Widget>[
            BackIdentifyCard(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      Step(
        isActive: currentStep == 3 ? true : false,
        state: StepState.indexed,
        title: const Text('Xử lý thông tin'),
        content: Column(
          children: <Widget>[],
        ),
      ),
    ];
  }

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  void dispose() {
    super.dispose();
    informationCustomer = null;
    if (imageBack != null) imageBack = null;
    if (imageFront != null) imageFront = null;
    if (dataCustomer != null) dataCustomer.clear();
    if (errorData != null) errorData.clear();
  }

  @override
  Widget build(BuildContext context) {
    _createSteps(context);
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: leadingAppbar(context, colorIcon: Colors.white),
        title: titleAppBar('Xác thực tài khoản'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(primary: welcome_color),
            ),
            child: Stepper(
              type: StepperType.vertical,
              steps: steps,
              currentStep: currentStep,
              onStepContinue: next,
              onStepTapped: (step) {
                goTo(step);
              },
              onStepCancel: cancel,
              controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                return Row(
                  children: [
                    btnStep(
                      currentStep == 3 ? "Xác nhận" : "Tiếp tục",
                      colorContainer: welcome_color,
                      colorText: Colors.white,
                      borderRadius: 20,
                      function: currentStep == 3 ? checkData : onStepContinue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    btnStep(
                      "Quay lại",
                      colorContainer: Colors.white10,
                      colorBoxShadow: Colors.white10,
                      function: onStepCancel,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  void checkData() async {
    checkErrorData = await _checkErrorData();
    setState(() {
      if (dataCustomer.contains("null") || !checkErrorData) {
        currentStep = 0;
        EasyLoading.showError(showMessage("", MSG050),
            duration: Duration(seconds: 1),
            maskType: EasyLoadingMaskType.black);
      } else if (imageFront == null) {
        currentStep = 1;
        EasyLoading.showError(showMessage(MSG051, "mặt trước CMND/CCCD"),
            duration: Duration(seconds: 1),
            maskType: EasyLoadingMaskType.black);
      } else if (imageBack == null) {
        currentStep = 2;
        EasyLoading.showError(showMessage(MSG051, "mặt sau CMND/CCCD"),
            duration: Duration(seconds: 1),
            maskType: EasyLoadingMaskType.black);
      } else {
        doUpgradeCustomer(context,
            cmndFront: imageFront, cmndBack: imageBack, data: dataCustomer);
      }
    });
  }

  Future _checkErrorData() async {
    bool check = true;
    errorData.forEach((element) {
      if (element != "null") {
        check = false;
      }
    });
    return check;
  }

  Widget btnStep(String tittle,
      {double borderRadius,
      Color colorContainer,
      Color colorBoxShadow,
      Color colorText,
      function}) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(borderRadius == null ? 0 : borderRadius),
        color: colorContainer,
        boxShadow: [
          BoxShadow(
            color: colorBoxShadow == null ? Colors.black54 : colorBoxShadow,
            blurRadius: 3,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
          onPressed: function,
          child: Text(
            tittle,
            style: GoogleFonts.roboto(
                color: colorText == null ? Colors.black87 : colorText,
                fontSize: 16),
          )),
    );
  }
}
