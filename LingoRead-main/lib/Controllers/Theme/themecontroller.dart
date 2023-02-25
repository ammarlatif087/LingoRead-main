import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  var isDark = false.obs;
  setThemeIsDark(bool value) => isDark.value = value;
}
