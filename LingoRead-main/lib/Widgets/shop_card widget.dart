import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'text_widget_heading.dart';

class ShopCardWidget extends StatelessWidget {
  String? titleHeading;
  String? titleSubHeading;
  Color? colorPrimary, colorSecondary, cardBg, borderColor;

  ShopCardWidget({
    this.colorPrimary,
    this.cardBg,
    this.borderColor,
    this.titleHeading,
    this.titleSubHeading,
    this.colorSecondary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(57),
      width: getProportionateScreenWidth(340),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor!),
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(9),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
            bottom: getProportionateScreenHeight(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidgetHeading(
              textAlignment: TextAlign.left,
              titleHeading: titleHeading,
              textStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  // letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: colorPrimary,
                ),
              ),
            ),
            // SizedBox(
            //   height: getProportionateScreenHeight(2),
            // ),
            TextWidgetHeading(
              textAlignment: TextAlign.left,
              titleHeading: titleSubHeading,
              textStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  // letterSpacing: 1,
                  fontWeight: FontWeight.w200,
                  color: colorSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
