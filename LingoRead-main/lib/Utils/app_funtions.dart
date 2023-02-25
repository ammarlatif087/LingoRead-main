import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Widgets/Main/logoutPopUp.dart';

import '../Widgets/Main/subcribe_plan.dart';

class AppFunctions {
  static subcribeplan(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SubcribePlan();
            }));
  }

  static logout(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return LogoutPopUp();
            }));
  }

  static showSnackBar(
    String title,
    String message,
  ) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:
            ThemeController.to.isDark.isTrue ? Colors.black : Colors.white,
        colorText:
            ThemeController.to.isDark.isTrue ? Colors.white : Colors.black,
        borderColor:
            ThemeController.to.isDark.isTrue ? Colors.black : Colors.white,
        borderWidth: 1,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        isDismissible: true);
  }
}
