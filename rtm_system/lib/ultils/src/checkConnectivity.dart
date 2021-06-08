import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

import '../alertDialog.dart';

Future checkConnectivity(BuildContext context, result) {
  switch
  (result) {
    case ConnectivityResult.none:
       return showCupertinoAlertDialog(context, "Mất kết nối internet.");
      break;
  }
}