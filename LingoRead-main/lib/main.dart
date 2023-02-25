import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/profileController.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Pages/splash_screen.dart';
import 'package:lingoread/Routes/routes.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:lingoread/Utils/Theme/decoration.dart';
import 'package:lingoread/Utils/Theme/theme.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controllers/Theme/menuController.dart';
import 'Widgets/Main/custom_container.dart';
import 'Widgets/Main/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ThemeController themeControllers = Get.put(ThemeController());
  MenuController menuController = Get.put(MenuController());

  ProfileController profileControllers = Get.put(ProfileController());
  print(themeControllers.isDark.value);
  final prefs = await SharedPreferences.getInstance();
  bool res = prefs.getBool('isDark') ?? false;
  if (!res) {
    Get.changeTheme(CustomThemeData.themeLight());

    Get.changeThemeMode(ThemeMode.light);
    themeControllers.setThemeIsDark(false);
  } else {
    Get.changeTheme(CustomThemeData.themeDark());
    Get.changeThemeMode(ThemeMode.dark);
    themeControllers.setThemeIsDark(true);
  }
  // if (themeControllers.isDark.value) {
  //   Get.changeTheme(CustomThemeData.themeLight());

  //   Get.changeThemeMode(ThemeMode.light);
  //   themeControllers.setThemeIsDark(false);
  // } else {
  //   Get.changeTheme(CustomThemeData.themeDark());
  //   Get.changeThemeMode(ThemeMode.dark);
  //   themeControllers.setThemeIsDark(true);
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: GetMaterialApp(
        title: 'Lingo Read',
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.themeDark(),
        themeMode: ThemeMode.light,
        darkTheme: CustomThemeData.themeDark(),
        getPages: listRoutes,
        initialRoute: Routes.splash,
      ),
    );
  }
}
