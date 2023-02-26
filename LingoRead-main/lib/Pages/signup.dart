import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';

import '../Routes/routes_names.dart';
import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Widgets/Buttons/button_main.dart';
import '../Widgets/TextField/myTextFromField.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerAddress = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  bool isSendingMessage = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      //backgroundColor: Colors.red,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(AppConst.padding * 2,
                AppConst.padding * 3, AppConst.padding * 2, 0),
            child: Column(
              children: [
                Center(
                  child: TextWidgetHeading(
                    textAlignment: TextAlign.center,
                    titleHeading: 'LingoRead',
                    textStyle: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: getProportionateScreenHeight(28),
                        // letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: kTextColorSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppConst.padding * 2),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextWidgetHeading(
                          textAlignment: TextAlign.center,
                          titleHeading: 'Register To Continue',
                          textStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              // letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              color: kTextColorSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        SizedBox(height: AppConst.padding * 1.5),
                        CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.2),
                          radius: AppConst.padding * 1.5,
                          child: Icon(
                            Icons.person,
                            size: AppConst.padding * 2.6,
                            color: kButtonColor,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerName,
                                hintText: "Full Name",
                                labelText: "Full Name",
                                isEnabled: !isSendingMessage,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                                isShowHeader: false,
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerEmail,
                                labelText: "Email",
                                isEnabled: !isSendingMessage,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter email";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                isShowHeader: false,
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerPassword,
                                hintText: "Enter Password",
                                labelText: "Password",
                                isEnabled: !isSendingMessage,
                                isShowHeader: false,
                                validator: (value) {
                                  if (value.length < 8) {
                                    return 'Please enter 8 digit password';
                                  }
                                  return null;
                                },
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerAddress,
                                hintText: "Enter Address",
                                labelText: "Address",
                                isEnabled: !isSendingMessage,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                                isShowHeader: false,
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              isSendingMessage
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConst.padding * 0.25),
                                          color: AppConst
                                              .colorPrimaryLightv3_1BA0C1),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary)),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: "Register",
                                        onPressed: () async {
                                          signup();
                                        },
                                      ),
                                    ),
                              const SizedBox(height: 320),
                            ],
                          ),
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

  signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSendingMessage = true;
      });

      APIsCallPost.submitRequest("", {
        'action': 'checkemail',
        'user_email': textEditingControllerEmail.text
      }).then((value) {
        print(value.data);
        print(value.statusCode);
        if (value.statusCode == 404) {
          dynamic data = {
            "action": "register",
            "user_name": textEditingControllerName.text,
            "user_email": textEditingControllerEmail.text,
            "user_password": textEditingControllerPassword.text,
            "user_address": textEditingControllerAddress.text,
          };

          var arguments = {
            "isLogin": false,
            "data": data,
            "email": textEditingControllerEmail.text,
          };

          setState(() {
            isSendingMessage = false;
          });

          Get.toNamed(Routes.otpverify, arguments: arguments);
        } else {
          setState(() {
            isSendingMessage = false;
          });
          AppFunctions.showSnackBar("Email", "Email Already Exist");
        }
      });

      // setState(() {
      //   verificationIdNew = verificationId;
      // });

    }
  }
}
