import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingKeyword extends GetxController {
  static TrainingKeyword get to => Get.find();

  var indexSlider = 0.obs;
  var listTrainingKeyword = [].obs;
  var totalEasyKeywords = 0.obs;
  var totalOkKeywords = 0.obs;
  var totalHardKeywords = 0.obs;
  var totalCompletedKeywords = 0.obs;
  int checkIfAddedtoTraining(String id) =>
      listTrainingKeyword.indexWhere((element) => element["id"] == id);

  setCountKeywords() {
    // List listnew = [...listTrainingKeyword];

    List newListWithStatus = listTrainingKeyword;
    totalEasyKeywords.value = newListWithStatus
        .where((element) => element["status"] == "Easy")
        .length;

    totalOkKeywords.value = newListWithStatus
        .where((element) => element["status"] == "Okay")
        .length;
    totalHardKeywords.value = newListWithStatus
        .where((element) => element["status"] == "Hard")
        .length;
    totalCompletedKeywords.value = newListWithStatus
        .where((element) => element["status"] == "Done")
        .length;
  }

  changeStatus(String id, String status) {
    // Loader.show(widget.context, progressIndicator: CircularProgressIndicator());

    APIsCallPost.submitRequestWithAuth("", {
      "action": "addkeywordstatus",
      "keyword_id": id,
      "status": status
    }).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;

        loadKeywords();

        AppFunctions.showSnackBar("Message", "Status Updated");
      }
    });
  }

  loadKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    // String? userIdTemp = prefs.getString('UserId');
    APIsCallPost.submitRequestWithAuth("", {"action": "trained_keywords"})
        .then((value) {
      if (value.statusCode == 200) {
        List list = value.data;

        listTrainingKeyword.value = list;
        setCountKeywords();
      } else {
        listTrainingKeyword.value = [];
      }
    });
  }

  addtoTraining(String id, {bool isTrainingScreen = false}) {
    // Loader.show(widget.context, progressIndicator: CircularProgressIndicator());

    APIsCallPost.submitRequestWithAuth(
        "", {"action": "addkeyword", "keyword_id": id}).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;
        if (isTrainingScreen) {
          // if it is fav screen, reload the fav list
          loadKeywords();
        }
        AppFunctions.showSnackBar("Message", "Added to Training Keywords");
      }
    });
  }

  removeFromFav(String id, {bool isTrainingScreen = false}) {
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "removekeyword", "keyword_id": id}).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;
        AppFunctions.showSnackBar("Message", "Removed from Training Keywords");

        if (isTrainingScreen) {
          // if it is fav screen, reload the fav list
          loadKeywords();
        }
      }
    });
  }
}
