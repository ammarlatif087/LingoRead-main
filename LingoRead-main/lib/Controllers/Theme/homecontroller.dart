import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var indexSlider = 0.obs;
  var showFilters = false.obs;
  var listStories = [].obs;
  var listStoriesOrg = [].obs;

  filterPaidFreeStories(String status) {
    List newList = listStories(listStories
        .where((element) => element["subscription_type"].toString() == status)
        .toList());
    listStories.value = newList;
  }

  setFilter(bool value) => showFilters.value = value;

  setIndex(int value) => indexSlider.value = value;
  setListStories(List list, String status, bool statusChange) {
    if (!statusChange) {
      listStoriesOrg.value = list;
    }
    if (status == "Paid" || status == "Free") {
      List newList = list
          .where((element) => element["subscription_type"].toString() == status)
          .toList();
      listStories.value = newList;
    } else {
      listStories.value = list;
    }
  }
}
