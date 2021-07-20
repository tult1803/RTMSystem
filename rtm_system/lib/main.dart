import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rtm_system/demo.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = welcome_color
    ..backgroundColor = Colors.white
    ..indicatorColor = welcome_color
    ..textColor = colorHexa("626D71")
    ..maskColor = Colors.black12
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        // chỉnh ngôn ngữ cho app
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('vi'),
        ],
        locale: const Locale('vi'),
        // chủ đề màu cho toàn bộ ứng dụng
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: welcome_color,
          accentColor: welcome_color,
          splashColor: Colors.white10,
          highlightColor: Colors.black12,

        ),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
        // home: SimpleAnimatedList(),
      ),
    );
  }
}
