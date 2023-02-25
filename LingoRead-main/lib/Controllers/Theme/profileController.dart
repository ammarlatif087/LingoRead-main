import 'package:get/get.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  var userEmail = "".obs;

  var userName = "".obs;

  updateName(String value) => userName.value = value;

  loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? userIdTemp = prefs.getString('UserId');
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "userprofile", "user_id": userIdTemp}).then((value) {
      if (value.statusCode == 200) {
        List list = value.data;
        userEmail.value = (list[0] ?? {})["email"] ?? "";
      }
    });
  }
}
