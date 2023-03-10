import 'package:flutter/material.dart';
import 'package:flutter_catalog/theme/theme_manager.dart';
import 'package:flutter_catalog/theme/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_catalog/Pages/home_page.dart';
import 'package:flutter_catalog/Pages/login_page.dart';
import 'package:flutter_catalog/utils/routes.dart';

void main() async {
  await GetStorage.init();

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MyApp();
  }));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final cnic = _box.read('cnic');
    final folio = _box.read('folio');

    print('CNIC: $cnic');
    print('Folio: $folio');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeManager().theme,
      initialRoute: cnic != null && folio != null
          ? MyRoutes.homeRout
          : MyRoutes.LoginRout,
      // initialRoute: "/login",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRout: (context) => HomePage(),
        MyRoutes.LoginRout: (context) => LoginPage()
      },
    );
  }
}
