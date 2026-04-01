// Developer: Dev_Siam
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/prefs_helper.dart';
import 'package:project_borla/utils/app_routes.dart';

import 'bindings/app_binding.dart';
import 'language/app_translation.dart';
import 'language/language_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Locale savedLocale = await LanguageService.getLocale();
  PrefsHelper.getAllPrefData();

  runApp(MyApp(locale: savedLocale));
}

class MyApp extends StatefulWidget {
  final Locale? locale;

  const MyApp({super.key, this.locale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp(

          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),

          //initialRoute: '/notify',
          initialRoute: AppRoute.splashScreen,
          getPages: AppRoute.pages,

          translations: AppTranslations(),
          locale: widget.locale ?? const Locale('en', 'US'), // default language
          fallbackLocale: const Locale('en', 'US'),
          // home: NavbarScreen(),

        );
      },
    );
  }
}
