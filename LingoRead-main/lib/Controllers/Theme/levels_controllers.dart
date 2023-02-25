import 'package:get/get.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';

class LevelsControllers extends GetxController {
  static LevelsControllers get to => Get.find();
  var listLevels = [].obs;

  var selectedLevel = "".obs;
  setListTemp(List ls) {
    update();
  }

  setList(List value) {
    listLevels.value = value;
    update();
  }

  setSelectedLevel(String value) => selectedLevel.value = value;

  loadLevels() {
    APIsCallPost.submitRequestWithAuth("", {"action": "alllevels"})
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        List list = value.data;
        listLevels.value = list;
        // levelsControllers.setList(list);
      } else if (value.statusCode == 401) {
        AppFunctions.showSnackBar("Authorization", "Authorization Denied");
      } else {
        AppFunctions.showSnackBar("Error", "Something went wrong");
      }
    });
  }
}
