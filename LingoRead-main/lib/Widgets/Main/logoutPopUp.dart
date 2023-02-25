import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/app_constants.dart';
import '../shop_wigdet.dart';

class LogoutPopUp extends StatefulWidget {
  const LogoutPopUp({Key? key}) : super(key: key);

  @override
  State<LogoutPopUp> createState() => _LogoutPopUpState();
}

class _LogoutPopUpState extends State<LogoutPopUp> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.transparent,
      child: Container(
          child: Align(
        alignment: Alignment.center,
        child: Container(
          color: const Color(0xff757575).withOpacity(0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    padding: EdgeInsets.all(AppConst.padding * 0.5),
                    alignment: Alignment.center,
                    width: Get.width / 1.08,
                    decoration: BoxDecoration(
                        color: ThemeController.to.isDark.isTrue
                            ? Get.theme.backgroundColor
                            : AppConst.colorWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: ThemeController.to.isDark.isTrue
                                      ? AppConst.colorWhite
                                      : AppConst.colorPrimaryLight,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text('Are you sure?',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeController.to.isDark.isTrue
                                        ? Color(0xff00899C)
                                        : Color(0xff3F3F3F))),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ThemeController.to.isDark.isTrue
                                    ? AppConst.dark_colorPrimaryDark
                                    : AppConst.colorPrimaryLight),
                            child: InkWell(
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('isGuestLogin', false);

                                await prefs.setString('userDetails', "");
                                await prefs.setString('UserId', "");
                                await prefs.setString("level", "");
                                await GoogleSignIn(scopes: <String>["email"])
                                    .signOut();
                                Get.offAllNamed(Routes.login);
                              },
                              child: Center(
                                  child: Text(
                                'Logout',
                                style: Theme.of(context).textTheme.headline4,
                              )),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
