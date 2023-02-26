import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Routes/routes_names.dart';

import '../../Controllers/Theme/menuController.dart';
import '../../Controllers/Theme/themecontroller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this.context, {Key? key}) : super(key: key);
  final BuildContext context;
  widgetItems(String name, String asset, Function onTap) {
    return Obx(() => InkWell(
          onTap: onTap as void Function(),
          child: Container(
            color: (MenuController.to.selected.value == name)
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Image.asset(
                  asset,
                  width: 20,
                  height: 20,
                  color: Get.theme.colorScheme.background,
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Get.theme.colorScheme.background,
                      ),
                ),
              ],
            ),
          ),
        ));
  }

  widgetItemsBottom(String name, String asset, Function onTap) {
    return Row(
      children: [
        Image.asset(
          asset,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 1),
        Text(
          name,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }

  // final ThemeController themeControllers = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Get.theme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Divider(
                    color: Theme.of(context).primaryColorDark,
                    height: 5,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                    child: Obx(
                      () => Container(
                        // width: 300,
                        height: 70,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ThemeController.to.isDark.value
                            ? Image.asset('assets/images/logo_dark.png')
                            : Image.asset('assets/images/logo_light.png'),
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColorDark,
                    height: 40,
                    thickness: 1,
                  ),
                  Column(
                    children: [
                      widgetItems("Home", "assets/images/icon_home.png", () {
                        // Get.offAll(ProfileScreen());
                        MenuController.to.setSelected("Home");
                        Get.toNamed(Routes.homeScreen);
                      }),
                      widgetItems("Training", "assets/images/icon_training.png",
                          () {
                        MenuController.to.setSelected("Training");

                        Get.toNamed(
                          Routes.training,
                        );
                      }),
                      widgetItems("Favourites", "assets/images/icon_heart.png",
                          () {
                        MenuController.to.setSelected("Favourites");

                        // Get.offAll(Routes.favourites);
                        Get.toNamed(Routes.favourites);
                      }),
                      widgetItems("Profile", "assets/images/icon_profile.png",
                          () {
                        MenuController.to.setSelected("Profile");

                        // Get.offAll(ProfileScreen());
                        Get.toNamed(Routes.userProfile);
                      }),
                      widgetItems("Shop", "assets/images/icon_shop.png", () {
                        MenuController.to.setSelected("Shop");

                        Get.toNamed(Routes.shop);
                      }),
                      widgetItems("Setting", "assets/images/icon_setting.png",
                          () {
                        MenuController.to.setSelected("Setting");

                        Get.toNamed(Routes.setting);
                      }),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).primaryColorDark,
                    height: 40,
                    thickness: 1,
                  ),
                  // Obx(
                  //   () => IconButton(
                  //     icon: Icon(
                  //         ThemeController.to.isDark.value
                  //             ? Icons.dark_mode
                  //             : Icons.light_mode,
                  //         color: Colors.white),
                  //     onPressed: () {
                  //       print("button Clicked");

                  //       print(ThemeController.to.isDark.value);
                  //       if (ThemeController.to.isDark.value) {
                  //         Get.changeTheme(CustomThemeData.themeLight());

                  //         Get.changeThemeMode(ThemeMode.light);
                  //         ThemeController.to.setThemeIsDark(false);
                  //       } else {
                  //         Get.changeTheme(CustomThemeData.themeDark());
                  //         Get.changeThemeMode(ThemeMode.dark);
                  //         ThemeController.to.setThemeIsDark(true);
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            // Divider(
            //   color: Theme.of(context).primaryColorDark,
            //   height: 10,
            //   thickness: 1,
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       widgetItemsBottom(
            //           "Settings", "assets/images/icon_settings.png", () {
            //         // Get.offAll(ProfileScreen());
            //       }),

            //     ],
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}


// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   // CustomDrawer(this._scaffoldKey);
//   // final GlobalKey<ScaffoldState> _scaffoldKey;
//   @override
//   _CustomDrawerState createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer>
//     with TickerProviderStateMixin {

// }
