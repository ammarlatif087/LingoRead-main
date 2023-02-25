import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/Theme/decoration.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Buttons/default_button.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/routes_names.dart';
import '../Utils/constants.dart';
import '../Widgets/Buttons/buttonIntro.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Image.asset(
                    'assets/images/intro.png',
                    height: getProportionateScreenHeight(244),
                    width: getProportionateScreenWidth(366),
                    fit: BoxFit.cover,
                  ),
                ),
                TextWidgetHeading(
                  textAlignment: TextAlign.center,
                  titleHeading: 'German learning made easy with LingoRead',
                  textStyle: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(28),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(26),
                ),
                TextWidgetHeading(
                  textAlignment: TextAlign.center,
                  titleHeading:
                      '"Begin your German language journey with LingoRead. Set aside just 5 minutes each day to read a short story, and then create flashcards from the words and phrases you encounter in the stories you enjoy. With LingoRead, learning German has never been more fun and engaging."',
                  textStyle: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      // letterSpacing: 1.3,
                      fontWeight: FontWeight.w400,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
                const Spacer(),
                DefaultButton(
                    text: "Get Started",
                    press: () async {
                      final prefs = await SharedPreferences.getInstance();
                      String? userIdTemp = prefs.getString('UserId');
                      await prefs.setBool('isNotFirstVisit', true);
                      print(userIdTemp);
                      // Get.offAllNamed(Routes.login);
                      Get.offAllNamed(Routes.login);
                    }),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
