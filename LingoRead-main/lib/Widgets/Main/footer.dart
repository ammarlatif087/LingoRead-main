import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';

import '../../Utils/app_constants.dart';

class ThemeFooter extends StatelessWidget {
  ThemeFooter({Key? key}) : super(key: key);

  // final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
          bottom: 0,
          child: ThemeController.to.isDark.isTrue
              ? Image.asset('assets/images/footer_dark.png')
              : Image.asset('assets/images/footer_light.png')),
    );
  }
}
