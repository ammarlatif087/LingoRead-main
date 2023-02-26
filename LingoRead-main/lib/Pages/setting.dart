import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Setting/setting_widget.dart';

import '../Routes/routes_names.dart';
import '../Utils/app_constants.dart';
import '../Widgets/text_widget_heading.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  bool isSwitch = false;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final ThemeController themeControllers = Get.put(ThemeController());

  bool forAndroid = false;

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: AppConst.padding * 3),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(18),
                  horizontal: getProportionateScreenWidth(21)),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getProportionateScreenHeight(45),
                    width: getProportionateScreenWidth(45),
                    decoration: BoxDecoration(
                      color: kButtonColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: getProportionateScreenHeight(20),
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : kButtonColor,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: TextWidgetHeading(
                        textAlignment: TextAlign.center,
                        titleHeading: 'Settings',
                        textStyle: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            // letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: kTextColorSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(44),
                ),
                Obx(
                  () => SettingWidget(
                    'assets/images/darkart.png',
                    ThemeController.to.isDark.isTrue
                        ? const Color(0XFF3E4044)
                        : Colors.white,
                    ThemeController.to.isDark.value
                        ? 'Light Theme'
                        : "Dark Theme",
                    ThemeController.to.isDark.isTrue
                        ? AppConst.colorWhite
                        : kTextColorSecondary,
                    kButtonColor,
                    // () async {
                    //   if (ThemeController.to.isDark.value) {
                    //     final prefs =
                    //         await SharedPreferences.getInstance();
                    //     prefs.setBool('isDark', false);
                    //     Get.changeTheme(CustomThemeData.themeLight());

                    //     Get.changeThemeMode(ThemeMode.light);
                    //     ThemeController.to.setThemeIsDark(false);
                    //   } else {
                    //     final prefs =
                    //         await SharedPreferences.getInstance();
                    //     prefs.setBool('isDark', true);
                    //     Get.changeTheme(CustomThemeData.themeDark());
                    //     Get.changeThemeMode(ThemeMode.dark);
                    //     ThemeController.to.setThemeIsDark(true);
                    //   }
                    // },

                    null,
                    Obx(
                      () => SizedBox(
                        width: getProportionateScreenWidth(40),
                        child: Switch(
                          // thumb color (round icon)
                          activeColor: kButtonColor,
                          activeTrackColor: Colors.cyan,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: ThemeController.to.isDark.value,
                          // changes the state of the switch
                          onChanged: (value) {
                            ThemeController.to.isDark.value = value;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SettingWidget(
                    'assets/images/education.png',
                    ThemeController.to.isDark.isTrue
                        ? const Color(0XFF3E4044)
                        : const Color(0xffffffff),
                    'Education Voucher',
                    ThemeController.to.isDark.isTrue
                        ? AppConst.colorWhite
                        : kTextColorSecondary,
                    kButtonColor,
                    () {
                      Get.toNamed(Routes.setting_voucher);
                    },
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: ThemeController.to.isDark.isTrue
                          ? AppConst.colorWhite
                          : const Color(0xff000000).withOpacity(.6),
                    ),
                  ),
                ),
                Obx(
                  () => SettingWidget(
                    'assets/images/highlighted.png',
                    ThemeController.to.isDark.isTrue
                        ? const Color(0xff3E4044)
                        : const Color(0xffffffff),
                    'Highligth Text',
                    ThemeController.to.isDark.isTrue
                        ? AppConst.colorWhite
                        : kTextColorSecondary,
                    kButtonColor,
                    () {
                      //Get.toNamed();
                    },
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: ThemeController.to.isDark.isTrue
                          ? AppConst.colorWhite
                          : const Color(0xff000000).withOpacity(.6),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
