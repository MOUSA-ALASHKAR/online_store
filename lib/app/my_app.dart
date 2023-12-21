import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/views/main_view/main_view.dart';
import 'package:online_store/UI/views/splash_screen_view/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 600),
      // translations: AppTranslation(),
      // locale: getLocal(),
      // fallbackLocale: getLocal(),
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(),
    );
  }
}

// Locale getLocal() {
//   if (storage.getAppLanguage() == 'ar') {
//     return Locale('ar', 'SA');
//   } else {
//     return Locale('en', 'US');
//   }
// }
