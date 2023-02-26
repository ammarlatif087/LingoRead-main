import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/app_constants.dart';

import '../Utils/constants.dart';
import '../Utils/size_config.dart';
import 'text_widget_heading.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget(this.text1, this.text2, this.color1, {Key? key})
      : super(key: key);
  final String text1;
  final String text2;
  final Color color1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConst.padding * 0.25),
      decoration: BoxDecoration(
          border: Border.all(color: kButtonColor),
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppConst.padding * 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidgetHeading(
                  textAlignment: TextAlign.left,
                  titleHeading: text1,
                  textStyle: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
                TextWidgetHeading(
                  textAlignment: TextAlign.left,
                  titleHeading: text2,
                  textStyle: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
