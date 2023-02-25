import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/profileController.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';

import '../Utils/app_constants.dart';
import '../Widgets/TextField/myTextFromField.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadProfile());
  }

  loadProfile() {
    APIsCallPost.submitRequestWithAuth("", {"action": "userprofile"}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);

        List listData = value.data;
        dynamic dataObj = listData[0];

        textEditingControllerName.text = dataObj["name"] ?? "";
        textEditingControllerMobileNo.text = dataObj["phone"] ?? "";
        textEditingControllerAddress.text = dataObj["address"] ?? "";
      } else {}
    });
  }

  updateProfile() {
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    try {
      APIsCallPost.submitRequestWithAuth("", {
        "action": "edit_profile",
        "user_name": textEditingControllerName.text,
        "user_address": textEditingControllerAddress.text,
        "user_phonenumber": textEditingControllerMobileNo.text,
      }).then((value) {
        if (value.statusCode == 200) {
          ProfileController.to.updateName((textEditingControllerName.text).toString());

          AppFunctions.showSnackBar("Success", "Profile Updated");
        } else {
          AppFunctions.showSnackBar("Error", value.data.toString());
        }
      });
    } catch (e) {
      Loader.hide();
    }
    Loader.hide();
  }

  bool editName = false;
  bool editPhoneNo = false;
  bool editAddress = false;

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeedit = FocusNode();

  TextEditingController textEditingControllerName = TextEditingController();

  TextEditingController textEditingControllerMobileNo = TextEditingController();

  TextEditingController textEditingControllerAddress = TextEditingController();

  bool isSendingMessage = false;

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              ThemeFooter(),
              Padding(
                padding: EdgeInsets.fromLTRB(AppConst.padding * 1, AppConst.padding * 2, AppConst.padding * 1, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffffffff),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: AppConst.padding * 3),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text('Edit Profile',
                              style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24)),
                        ),
                        SizedBox(height: AppConst.padding * 1.5),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.2),
                          radius: AppConst.padding * 1.5,
                          child: Icon(
                            Icons.person,
                            size: AppConst.padding * 2.6,
                            color: AppConst.colorWhite,
                          ),
                        ),
                        SizedBox(height: AppConst.padding * 1.2),
                        InkWell(
                          onTap: () {
                            if (!editName) {
                              setState(() {
                                editName = true;
                              });
                              focusNodeName.requestFocus();
                            }
                          },
                          child: MyTextFormField(
                            focusNode: focusNodeName,
                            controller: textEditingControllerName,
                            hintText: "Name",
                            labelText: "Name",
                            suffixIcon: IconButton(
                                icon: editName
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    editName = false;
                                  });
                                  updateProfile();
                                }),
                            isEnabled: editName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            isShowHeader: false,
                            isNumberOnly: false,
                          ),
                        ),
                        SizedBox(height: AppConst.padding * 0.5),
                        InkWell(
                          onTap: () {
                            if (!editPhoneNo) {
                              setState(() {
                                editPhoneNo = true;
                              });

                              focusNodePhone.requestFocus();
                            }
                          },
                          child: MyTextFormField(
                            focusNode: focusNodePhone,
                            controller: textEditingControllerMobileNo,
                            hintText: "+92123456789",
                            labelText: "Mobile Number",
                            suffixIcon: IconButton(
                                icon: editPhoneNo
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  if (textEditingControllerMobileNo.text.trim().isEmpty) {
                                    AppFunctions.showSnackBar("Error", "Please Enter Phone Number");
                                  } else if (!RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                                      .hasMatch(textEditingControllerMobileNo.text.trim())) {
                                    AppFunctions.showSnackBar("Error", "Please enter a valid mobile number");
                                  } else {
                                    setState(() {
                                      editPhoneNo = false;
                                    });
                                    updateProfile();
                                  }
                                }),
                            isEnabled: editPhoneNo,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your mobile number";
                              }

                              return null;
                            },
                            isShowHeader: false,
                            isNumberOnly: true,
                          ),
                        ),
                        SizedBox(height: AppConst.padding * 0.5),
                        InkWell(
                          onTap: () {
                            if (!editAddress) {
                              setState(() {
                                editAddress = true;
                              });

                              focusNodeedit.requestFocus();
                            }
                          },
                          child: MyTextFormField(
                            focusNode: focusNodeedit,
                            controller: textEditingControllerAddress,
                            hintText: "Address",
                            labelText: "Address",
                            suffixIcon: IconButton(
                                icon: editAddress
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    editAddress = false;
                                  });
                                  updateProfile();
                                }),
                            isEnabled: editAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            isShowHeader: false,
                            isNumberOnly: false,
                          ),
                        ),
                      ],
                    ),
                  )),
                ]),
              )
            ],
          )),
    );
  }
}
