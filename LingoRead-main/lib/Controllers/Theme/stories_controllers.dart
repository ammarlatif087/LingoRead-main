import 'package:get/get.dart';

class StoriesControllers extends GetxController {
  var listStories = [].obs;

  

  setList(List value) => listStories.value = value;


}
