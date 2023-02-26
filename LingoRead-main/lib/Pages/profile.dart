import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/profileController.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Profile/profile_data.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/routes_names.dart';
import '../Utils/app_constants.dart';
import '../Utils/constants.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadProfile());
  }

  loadProfile() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());
    final prefs = await SharedPreferences.getInstance();
    String? userIdTemp = prefs.getString('UserId');
    APIsCallPost.submitRequestWithAuth(
        "", {"action": "userprofile", "user_id": userIdTemp}).then((value) {
      if (value.statusCode == 200) {
        List list = value.data;
        dynamic data = list[0];

        setState(() {
          userData = list[0];
          favStories = int.parse((data['totalfavonstories'] ?? "0").toString());
          learnedWords =
              int.parse((data['totallearnedwords'] ?? "0").toString());
          learnedStoreis =
              int.parse((data['totallearnedstories'] ?? "0").toString());
        });
        // ProfileController.to.updateName((userData["name"] ?? "").toString());
        ProfileController.to.updateName((userData["name"] ?? "").toString());
      }
      Loader.hide();
    });
  }

  dynamic userData = {};
  int favStories = 0;
  int learnedWords = 0;
  int learnedStoreis = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: SafeArea(
      child: Scaffold(
        // drawer: CustomDrawer(context),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(18),
                  horizontal: getProportionateScreenWidth(21)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: getProportionateScreenHeight(45),
                    width: getProportionateScreenWidth(45),
                    decoration: BoxDecoration(
                      color: kButtonColor.withOpacity(.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : kButtonColor,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  TextWidgetHeading(
                    textAlignment: TextAlign.center,
                    titleHeading: 'Profile',
                    textStyle: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        // letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: kTextColorSecondary,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.setting);
                      },
                      child: const Icon(Icons.settings))
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0XFF5A6CEA).withOpacity(0.1),
                          // offset: const Offset(
                          //   5.0,
                          //   5.0,
                          // ),
                          blurRadius: getProportionateScreenHeight(15),
                          // spreadRadius: 2.0,
                        ), //BoxShadow
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(22))),
                  height: getProportionateScreenHeight(503),
                  width: getProportionateScreenWidth(347),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(32),
                        horizontal: getProportionateScreenWidth(6)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: getProportionateScreenHeight(34),
                          width: getProportionateScreenWidth(111),
                          decoration: BoxDecoration(
                              color: kButtonColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: TextWidgetHeading(
                              textAlignment: TextAlign.center,
                              titleHeading:
                                  (userData["user_status"] ?? "") + ' Plan',
                              textStyle: GoogleFonts.sora(
                                textStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                  // letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                  color: kButtonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => TextWidgetHeading(
                                      textAlignment: TextAlign.center,
                                      titleHeading: ProfileController
                                          .to.userName
                                          .toString(),
                                      textStyle: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(28),
                                          // letterSpacing: 1,
                                          fontWeight: FontWeight.w400,
                                          color: kTextColorSecondary,
                                        ),
                                      ),
                                    )),
                                Obx(() => TextWidgetHeading(
                                      textAlignment: TextAlign.center,
                                      titleHeading: ProfileController
                                          .to.userEmail
                                          .toString(),
                                      textStyle: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(14),
                                          // letterSpacing: 1,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            PopupMenuButton<int>(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.edit,
                                size: getProportionateScreenHeight(20),
                                color: kButtonColor,
                              ),
                              itemBuilder: (context) => [
                                // PopupMenuItem 1
                                PopupMenuItem(
                                  value: 1,
                                  // row with 2 children
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_note_outlined,
                                          color:
                                              ThemeController.to.isDark.isTrue
                                                  ? AppConst.colorBlack
                                                  : const Color(0xff00565B)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Edit",
                                          style: TextStyle(
                                              color: Color(0xffA7A7A7),
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                // PopupMenuItem 2
                                PopupMenuItem(
                                  value: 2,
                                  // row with two children
                                  child: Row(
                                    children: [
                                      Icon(Icons.lock,
                                          color:
                                              ThemeController.to.isDark.isTrue
                                                  ? AppConst.colorBlack
                                                  : const Color(0xff00565B)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Password",
                                          style: TextStyle(
                                              color: Color(0xffA7A7A7),
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  // row with two children
                                  child: Row(
                                    children: [
                                      Icon(Icons.settings,
                                          color:
                                              ThemeController.to.isDark.isTrue
                                                  ? AppConst.colorBlack
                                                  : const Color(0xff00565B)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Settings",
                                        style: TextStyle(
                                            color: Color(0xffA7A7A7),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              offset: const Offset(0, 40),
                              color: Colors.white,
                              elevation: 2,
                              // on selected we show the dialog box
                              onSelected: (value) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                bool isGuest = prefs.getBool(
                                      'isGuestLogin',
                                    ) ??
                                    false;
                                // if value 1 show dialog
                                if (value == 1) {
                                  if (isGuest) {
                                    AppFunctions.showSnackBar('Info',
                                        'Guest does not have Edit permission.');
                                  } else {
                                    Get.toNamed(Routes.edit_profile);
                                  }
                                } else if (value == 2) {
                                  if (isGuest) {
                                    AppFunctions.showSnackBar('Info',
                                        'Guest can not change password');
                                  } else {
                                    Get.toNamed(Routes.change_password);
                                  }
                                } else if (value == 3) {
                                  Get.toNamed(Routes.setting);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        ProfileData(
                          'Total Favorites Stories',
                          Icons.favorite,
                          favStories,
                          color: ThemeController.to.isDark.isTrue
                              ? AppConst.colorPrimaryLightv3_1BA0C1
                              : Colors.red,
                        ),
                        ProfileData('Total Learned Words',
                            Icons.menu_book_rounded, learnedWords,
                            color: ThemeController.to.isDark.isTrue
                                ? AppConst.colorWhite
                                : kButtonColor),
                        ProfileData('Total Learned Stories', Icons.check_circle,
                            learnedStoreis,
                            color: ThemeController.to.isDark.isTrue
                                ? AppConst.colorWhite
                                : kButtonColor),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  AppFunctions.logout(context);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          color: Colors.white),
                                      child: Icon(
                                        Icons.logout,
                                        color: ThemeController.to.isDark.isTrue
                                            ? AppConst.colorBlack
                                            : AppConst.colorPrimaryLight,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Logout',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: ThemeController
                                                      .to.isDark.isTrue
                                                  ? AppConst.colorWhite
                                                  : AppConst.colorPrimaryLight),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
