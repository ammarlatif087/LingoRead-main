import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/profileController.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/routes_names.dart';
import '../Utils/constants.dart';
import '../Utils/size_config.dart';
import '../Widgets/text_widget_heading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () async {
        final prefs = await SharedPreferences.getInstance();
        bool? isNotFirstVisit = prefs.getBool('isNotFirstVisit');
        if (isNotFirstVisit == true) {
          String? userIdTemp = prefs.getString('UserId');
          ProfileController.to.loadProfile();
          // Get.offAllNamed(Routes.login);
          if (userIdTemp != null && userIdTemp != "") {
            String? autherization = prefs.getString('Authorization');
            APIsCallPost.submitRequestWithAuth("", {"action": "randomstories"})
                .then((value) {
              if (value.statusCode == 200) {
                String? level = prefs.getString("level");
                prefs.setString("Banners", jsonEncode(value.data));

                if (level != null && level != "") {
                  Get.offAllNamed(Routes.bottomNavBar);
                } else {
                  Get.offAllNamed(Routes.levelsScreen);
                }
              } else {
                Get.offAllNamed(Routes.login);
              }
            });
            // Get.offAllNamed(Routes.homeScreen);
          } else {
            Get.offAllNamed(Routes.login);
          }
        } else {
          Get.offAllNamed(Routes.introduction);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ThemeContainer(
        revese: true,
        child: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 3,
              ),
              TextWidgetHeading(
                titleHeading: 'LingoRead',
                textStyle: GoogleFonts.viga(
                  textStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(40),
                    fontWeight: FontWeight.bold,
                    color: kTextColorPrimary,
                  ),
                ),
              ),
              TextWidgetHeading(
                titleHeading: 'Your key to fluency in German',
                textStyle: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: kTextColorSecondary,
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/splashLogo.png',
                fit: BoxFit.cover,
              )
            ],
          ),
        )));
  }
}
