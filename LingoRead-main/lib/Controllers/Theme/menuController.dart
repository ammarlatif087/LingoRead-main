import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController get to => Get.find();

  var selected = "Home".obs;
  setSelected(String value) => selected.value = value;
}
