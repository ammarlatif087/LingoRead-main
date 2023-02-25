import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppConst.padding * 0.5,
              vertical: AppConst.padding * 0.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ThemeController.to.isDark.isTrue
                ? AppConst.colorPrimaryLightv3_1BA0C1
                : Theme.of(context).primaryColorLight,
          ),
          child: Row(
            children: [
              Text(
                "Filter",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: ThemeController.to.isDark.isTrue
                          ? AppConst.colorWhite
                          : Theme.of(context).primaryColor,
                    ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: ThemeController.to.isDark.isTrue
                    ? AppConst.colorWhite
                    : Theme.of(context).primaryColor,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
