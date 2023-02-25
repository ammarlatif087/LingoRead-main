import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';
import 'package:lingoread/Widgets/TextField/myTextFromField.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Utils/app_constants.dart';
import '../Widgets/Header/CustomerHeader.dart';

class PayOnline extends StatelessWidget {
  PayOnline({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: Scaffold(
          body: Stack(
        children: [
          ThemeFooter(),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 15),
            child: Column(
              children: [
                SizedBox(height: AppConst.padding * 3),
                CustomerHeader(
                  image:  ThemeController.to.isDark.isTrue
                      ? "assets/images/icon_menu_white.png"
                      : "assets/images/pay_online.png",
                  title: "Pay Online",
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(height: AppConst.padding * 3), 
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Details',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Color(0xff016064)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                          controller: textEditingController,
                          labelText: "Name",
                          isShowHeader: true,
                        ),
                        MyTextFormField(
                          controller: textEditingController,
                          labelText: "Card Number",
                          prefixIcon: Icon(
                            Icons.car_repair,
                            color: Colors.white,
                          ),
                          isShowHeader: true,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                controller: textEditingController,
                                labelText: "Expiration Date",
                                isShowHeader: true,
                              ),
                            ),
                            SizedBox(
                              width: AppConst.padding * 0.5,
                            ),
                            Expanded(
                              child: MyTextFormField(
                                controller: textEditingController,
                                labelText: "CVV",
                                isShowHeader: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppConst.padding * 1,
                        ),
                        Center(
                          child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff00ACC4)),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                    child: Text(
                                  'Pay',
                                  style: Theme.of(context).textTheme.headline4,
                                )),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
