import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Pages/introduction.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/Theme/decoration.dart';
import 'package:lingoread/Utils/Theme/theme.dart';
import 'package:lingoread/Widgets/Buttons/buttongoogle.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/routes_names.dart';
import '../Utils/app_constants.dart';
import '../Utils/app_funtions.dart';
import '../Widgets/Buttons/button_main.dart';
import '../Widgets/Buttons/buttonfb.dart';
import '../Widgets/TextField/myTextFromField.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key}) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  void initState() {
    super.initState();
    print(Get.arguments);
    setArguments();
  }

  String otp = "";
  setArguments() {
    var rnd = math.Random();
    String otp = rnd.nextInt(9).toString() +
        rnd.nextInt(9).toString() +
        rnd.nextInt(9).toString() +
        rnd.nextInt(9).toString() +
        rnd.nextInt(9).toString() +
        rnd.nextInt(9).toString();
    setState(() {
      this.otp = otp;
    });
    var arg = Get.arguments;

    APIsCallPost.submitRequest("", {
      "action": "sendotp",
      "user_email": arg["email"] ?? "",
      "user_otp": otp
    }).then((value) {
      if (value.statusCode == 200) {}
    });

    setState(() {
      registerdata = arg["data"] ?? "";
      isLogin = arg["isLogin"] ?? false;
    });
  }

  TextEditingController textEditingControllerOTP = TextEditingController();
  TextEditingController textEditingControllerPhoneNumber =
      TextEditingController();
  TextEditingController textEditingControllerAddress = TextEditingController();
  // String verficationId = "";
  // int resendToken = 0;
  var registerdata = {};
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ThemeFooter(),
          Padding(
            padding: EdgeInsets.fromLTRB(AppConst.padding * 2,
                AppConst.padding * 3, AppConst.padding * 2, 0),
            child: Column(
              children: [
                Center(
                  child: Text("LingoRead",
                      style: Theme.of(context).textTheme.headline1),
                ),
                SizedBox(height: AppConst.padding * 2),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Verify",
                            style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 2),
                        Text("To Continue",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                        SizedBox(height: AppConst.padding * 2),
                        SizedBox(height: AppConst.padding * 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Enter OTP",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.headline3),
                          ],
                        ),
                        Obx(
                          () => PinCodeTextField(
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            textStyle: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: ThemeController.to.isDark.isTrue
                                        ? AppConst.colorWhite
                                        : Theme.of(context).primaryColor),
                            pastedTextStyle: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: ThemeController.to.isDark.isTrue
                                        ? AppConst.colorWhite
                                        : Theme.of(context).primaryColor),
                            pinTheme: PinTheme(
                              activeColor: Theme.of(context).primaryColorDark,
                              inactiveColor: Theme.of(context).primaryColor,
                              inactiveFillColor:
                                  ThemeController.to.isDark.isTrue
                                      ? AppConst.dark_colorPrimaryDark
                                      : Theme.of(context).primaryColorLight,
                              selectedFillColor:
                                  Theme.of(context).primaryColorLight,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor:
                                  Theme.of(context).primaryColorLight,
                              selectedColor: Theme.of(context).primaryColorDark,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            // backgroundColor: Colors.blue.shade50,
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            controller: textEditingControllerOTP,
                            onCompleted: (v) {},
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        SizedBox(height: AppConst.padding * 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Didn’t Receive Code? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 12)),
                            InkWell(
                              onTap: () {
                                Loader.show(context,
                                    progressIndicator:
                                        CircularProgressIndicator());

                                print(registerdata);
                                APIsCallPost.submitRequest("", {
                                  "action": "sendotp",
                                  "user_email":
                                      registerdata["user_email"] ?? "",
                                  "user_otp": otp
                                }).then((value) {
                                  if (value.statusCode == 200) {
                                    Loader.hide();

                                    AppFunctions.showSnackBar(
                                        "Message", "OTP Sent");
                                  }
                                  Loader.hide();
                                });
                              },
                              child: Text("Request Again",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(height: AppConst.padding),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              text: "Verify OTP",
                              onPressed: () {
                                //RegisterAPI Call
                                if (textEditingControllerOTP.text == otp) {
                                  APIsCallPost.submitRequest("", registerdata)
                                      .then((value) async {
                                    if (value.statusCode == 200) {
                                      Get.offAllNamed(Routes.levelsScreen);

                                      AppFunctions.showSnackBar(
                                        "Success",
                                        "User Created Successfully",
                                      );
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString('Authorization',
                                          value.data["token"] ?? "");
                                      var data = {
                                        "action": "login",
                                        "user_email":
                                            registerdata["user_email"],
                                        "user_password":
                                            registerdata["user_password"],
                                      };

                                      APIsCallPost.submitRequest("", data)
                                          .then((value) async {
                                        // await prefs.setString('userDetails',
                                        //     jsonEncode(value.data));
                                        // await prefs.setString('Authorization',
                                        //     value.data["token"] ?? "");

                                        // await prefs.setString('UserId',
                                        //     value.data["user_id"].toString());

                                        APIsCallPost.submitRequestWithAuth("", {
                                          "action": "randomstories"
                                        }).then((value) => {
                                              if (value.statusCode == 200)
                                                {
                                                  prefs.setString("Banners",
                                                      jsonEncode(value.data)),
                                                  Get.offAllNamed(
                                                      Routes.levelsScreen)
                                                }
                                              else
                                                {
                                                  Get.offAllNamed(Routes.login),
                                                }
                                            });
                                      }).catchError((error) => print(error));
                                    } else {
                                      AppFunctions.showSnackBar(
                                        "Error",
                                        "User Already Exists",
                                      );
                                    }
                                  }).catchError((error) => print(error));
                                } else {
                                  AppFunctions.showSnackBar(
                                    "Error",
                                    "OTP is wrong",
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
