import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';

class ButtonIntro extends StatelessWidget {
  ButtonIntro({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        style: TextButton.styleFrom(
          primary: ThemeController.to.isDark.isTrue
              ? Colors.white
              : AppConst.colorPrimaryDark,
          backgroundColor: ThemeController.to.isDark.isTrue
              ? AppConst.colorPrimaryLight
              : AppConst.colorWhite,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
