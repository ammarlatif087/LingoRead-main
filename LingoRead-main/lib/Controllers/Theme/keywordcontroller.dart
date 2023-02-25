import 'package:get/get.dart';

class KeywordController extends GetxController {
  var isAdded = false.obs;

  setAddedStatus(bool value) => isAdded.value = value;
}
