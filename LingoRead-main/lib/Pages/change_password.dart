import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/profileController.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';
import 'package:lingoread/Widgets/TextField/myTextFromField.dart';

import '../Utils/app_constants.dart';
import '../Widgets/Buttons/button_main.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController textEditingControllerEmail =
      TextEditingController(text: ProfileController.to.userEmail.value);

  TextEditingController textEditingControllerOldPassword =
      TextEditingController();

  TextEditingController textEditingControllerNewPassword =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSendingMessage = false;
  @override
  void initState() {
    super.initState();
    print("*************************");
    print(ProfileController.to.userEmail.value);
  }

  Container loadingwidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConst.padding * 0.25),
          color: Theme.of(context).primaryColor),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: Scaffold(
        body: Stack(
          children: [
            ThemeFooter(),
            Padding(
              padding: EdgeInsets.fromLTRB(AppConst.padding * 1,
                  AppConst.padding * 2, AppConst.padding * 1, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffffffff),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("LingoRead",
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                  SizedBox(height: AppConst.padding * 2),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text("Change Password",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 26)),
                        ),
                        SizedBox(height: AppConst.padding * 2),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              MyTextFormField(
                                controller: textEditingControllerEmail,
                                labelText: "Email",
                                isEnabled: (isSendingMessage)
                                    ? false
                                    : ProfileController.to.userEmail.value == ""
                                        ? true
                                        : false,
                                isShowHeader: false,
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
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerOldPassword,
                                labelText: "Old Password",
                                isEnabled: !isSendingMessage,
                                isShowHeader: false,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Please enter Password';
                                  } else if (value.length <= 7) {
                                    return 'Please enter 8 digit Password';
                                  }
                                  return null;
                                },
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 0.5),
                              MyTextFormField(
                                controller: textEditingControllerNewPassword,
                                labelText: "New Password",
                                isEnabled: !isSendingMessage,
                                isShowHeader: false,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Please enter Password';
                                  } else if (value.length <= 7) {
                                    return 'Please enter 8 digit Password';
                                  }
                                  return null;
                                },
                                isNumberOnly: false,
                              ),
                              SizedBox(height: AppConst.padding * 1),
                              SizedBox(
                                width: double.infinity,
                                child: isSendingMessage
                                    ? loadingwidget()
                                    : CustomButton(
                                        text: "Continue",
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isSendingMessage = true;
                                            });
                                            var data = {
                                              "action": "updatepassword",
                                              "user_email":
                                                  textEditingControllerEmail
                                                      .text
                                                      .trim(),
                                              "user_new_password":
                                                  textEditingControllerNewPassword
                                                      .text
                                                      .trim(),
                                              "user_password":
                                                  textEditingControllerOldPassword
                                                      .text
                                                      .trim()
                                            };
                                            APIsCallPost.submitRequestWithAuth(
                                                    "", data)
                                                .then((value) {
                                              print(value.data);
                                              if (value.statusCode == 200) {
                                                AppFunctions.showSnackBar(
                                                    "Success",
                                                    "Passwod Changed");
                                              } else if (value.statusCode ==
                                                  209) {
                                                AppFunctions.showSnackBar(
                                                    "Error",
                                                    "Email or Old Password is Incorrect");
                                              } else {
                                                AppFunctions.showSnackBar(
                                                    "Error",
                                                    value.data.toString());
                                              }
                                              setState(() {
                                                isSendingMessage = false;
                                              });
                                            });
                                          } else {
                                            print('Unsuccesful');
                                          }
                                        },
                                      ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
