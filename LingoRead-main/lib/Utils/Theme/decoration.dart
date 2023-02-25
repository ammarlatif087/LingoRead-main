import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../app_constants.dart';

class CustomeDecoration {
  static final boxDecorationBGContainer = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Get.isDarkMode
              ? [AppConst.colorPrimaryLight, AppConst.colorPrimaryDark]
              : [AppConst.colorPrimaryLight, AppConst.colorPrimaryDark]));
}
