import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/app_funtions.dart';

class LearnedStories extends GetxController {
  static LearnedStories get to => Get.find();

  var indexSlider = 0.obs;
  var listLearnedStories = [].obs;
  int checkIfAddedtoTraining(String id) =>
      listLearnedStories.indexWhere((element) => element["story_id"] == id);

  loadLearnedStories() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? userIdTemp = prefs.getString('UserId');
    APIsCallPost.submitRequestWithAuth("", {"action": "alllearntstories"})
        .then((value) {
      if (value.statusCode == 200) {
        List list = value.data;

        listLearnedStories.value = list;
      } else {
        listLearnedStories.value = [];
      }
    });
  }

  addtoLearned(String id, {bool isLearnedStoreisScreen = false}) {
    // Loader.show(widget.context, progressIndicator: CircularProgressIndicator());

    APIsCallPost.submitRequestWithAuth(
        "", {"action": "addlearnedstory", "story_id": id}).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;
        if (isLearnedStoreisScreen) {
          // if it is fav screen, reload the fav list
          loadLearnedStories();
        }
        AppFunctions.showSnackBar("Message", "Added to Learned Stories");
      }
    });
  }

  removeFromFLearned(String id, {bool isLearnedStoreisScreen = false}) {
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "removelearnedstory", "story_id": id}).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;
        AppFunctions.showSnackBar(
          "Message",
          "Removed from Learned Stories",
        );

        if (isLearnedStoreisScreen) {
          // if it is fav screen, reload the fav list
          loadLearnedStories();
        }
      }
    });
  }
}
