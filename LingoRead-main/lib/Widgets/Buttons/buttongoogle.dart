import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/constants.dart';

import '../../Utils/size_config.dart';
import '../text_widget_heading.dart';
import 'authServices.dart';

class ButtonGoogle extends StatelessWidget {
  ButtonGoogle({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(
            color: !ThemeController.to.isDark.isTrue
                ? Theme.of(context).primaryColorDark
                : Colors.transparent,
            width: 2,
          ),
          // elevation: 4,
          padding: EdgeInsets.all(10),
          foregroundColor: Theme.of(context).primaryColorDark,
          backgroundColor: ThemeController.to.isDark.isTrue
              ? Colors.black
              : Colors.transparent,
        ),
        onPressed: onPressed as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(25),
              child: Image.asset("assets/images/google.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            TextWidgetHeading(
              //   textAlignment: TextAlign.center,
              titleHeading: 'Google',
              textStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  letterSpacing: 2,
                  fontSize: getProportionateScreenHeight(16),
                  // letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: kTextColorSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
