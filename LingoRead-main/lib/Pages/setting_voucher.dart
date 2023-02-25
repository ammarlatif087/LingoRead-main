import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lingoread/Widgets/shop_wigdet.dart';
import 'package:lingoread/Widgets/Header/CustomerHeader.dart';

import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Utils/app_constants.dart';

class SettingVoucher extends StatelessWidget {
  const SettingVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      body: Stack(children: [
        ThemeFooter(),
        Column(
          children: [
            SizedBox(height: AppConst.padding * 3),
            CustomerHeader(
              icon: Icons.arrow_back_ios,
              title: "Education Voucher",

              // titleicon: Icons.settings,
              titleimage: ThemeController.to.isDark.isTrue
                  ? 'assets/images/dark_setting_voucher.png'
                  : 'assets/images/setting_first_vector.png',
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: AppConst.padding * 2),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConst.padding,
                      ),
                      child: ShopWidget(
                          'Voucher',
                          'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
                          Color(0xff1976D2))),
                ],
              ),
            ))
          ],
        )
      ]),
    ));
  }
}
