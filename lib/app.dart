import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:edtech/bindings/general_bindings.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/text_strings.dart';
import 'package:edtech/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      initialBinding: GeneralBindings(),
      title: KTexts.appName,
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      home: const Scaffold(
        backgroundColor: KColors.primary,
      ),
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
    );
  }
}
