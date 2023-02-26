import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/size_config.dart';
import '../Routes/routes_names.dart';
import '../Utils/constants.dart';

import 'text_widget_heading.dart';

class CustomAppBar extends StatelessWidget {
  String? appBarTitle;
  CustomAppBar({
    this.appBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(22)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidgetHeading(
            textAlignment: TextAlign.center,
            titleHeading: appBarTitle,
            textStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 20,
                // letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: kTextColorSecondary,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.userProfile);
            },
            child: const Icon(
              Icons.person,
              color: kButtonColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
