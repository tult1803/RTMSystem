import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:rtm_system/ultils/src/message_list.dart';

import '../helpers/dialog.dart';

Future checkConnectivity(BuildContext context, result) {
  switch
  (result) {
    case ConnectivityResult.none:
       return showCupertinoAlertDialog(context, showMessage("", MSG036));
      break;
  }
}