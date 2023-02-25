import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavController extends GetxController {
  static FavController get to => Get.find();

  var indexSlider = 0.obs;
  dynamic listFavIDs = [].obs;
  var listFavStories = [].obs;

  // addtoFav(String id) => listFavIDs.value.add(id);
  // removeFav(String id) => listFavIDs.value.remove(id);

  int checkIfAddedtoFav(String id) =>
      listFavStories.indexWhere((element) => element["id"] == id);

  loadFav() async {
    final prefs = await SharedPreferences.getInstance();
    String? userIdTemp = prefs.getString('UserId');
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "storiesbyid", "user_id": userIdTemp}).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        try {
          List list = value.data;
          print(list);
          listFavStories.value = list;
        } catch (e) {
          print(e);

          listFavStories.value = [];
        }
      } else {
        listFavStories.value = [];
      }
    });
  }

  addtoFav(String id, {bool isFavScreen = false}) {
    // Loader.show(widget.context, progressIndicator: CircularProgressIndicator());

    APIsCallPost.submitRequestWithAuth("", {"action": "addfav", "story_id": id})
        .then((value) {
      print(value.statusCode);
      print(value.data);
      if (value.statusCode == 200) {
        // List list = value.data;
        if (isFavScreen) {
          // if it is fav screen, reload the fav list
          loadFav();
        }
        AppFunctions.showSnackBar("Message", "Added to Favorite");
      }
    });
  }

  removeFromFav(String id, {bool isFavScreen = false}) {
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "removefav", "story_id": id}).then((value) {
      if (value.statusCode == 200) {
        // List list = value.data;
        AppFunctions.showSnackBar("Message", "Removed from Favorite");

        if (isFavScreen) {
          // if it is fav screen, reload the fav list
          loadFav();
        }
      }
    });
  }
}
