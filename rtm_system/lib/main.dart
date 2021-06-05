import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/search_snackbar/character_sliver_list.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/welcome_page.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MaterialApp(
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
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      // home:(),
    ),
  );
}
