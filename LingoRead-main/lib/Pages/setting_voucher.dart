import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Widgets/shop_wigdet.dart';

import 'package:lingoread/Widgets/Main/custom_container.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Utils/size_config.dart';

class SettingVoucher extends StatelessWidget {
  const SettingVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.green,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: AppConst.padding * 3),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(19),
                  horizontal: getProportionateScreenWidth(16)),
              child: Container(
                height: getProportionateScreenHeight(45),
                width: getProportionateScreenWidth(45),
                decoration: BoxDecoration(
                  color: kButtonColor.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: getProportionateScreenHeight(20),
                    color: ThemeController.to.isDark.isTrue
                        ? AppConst.colorWhite
                        : kButtonColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),

            SizedBox(height: AppConst.padding * 2),
            Expanded(
                child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConst.padding,
                    ),
                    child: const ShopWidget(
                        'Voucher',
                        'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
                        Color(0xff1976D2))),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
