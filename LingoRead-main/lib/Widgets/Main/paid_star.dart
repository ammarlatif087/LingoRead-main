import 'package:flutter/material.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';

class PaidStar extends StatelessWidget {
  const PaidStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 7,
      backgroundColor: ThemeController.to.isDark.value
          ? AppConst.dark_colorPrimaryDark
          : AppConst.light_backgruondColor,
      child: const Icon(
        Icons.star,
        size: 10,
        color: Colors.white,
      ),
    );
  }
}
