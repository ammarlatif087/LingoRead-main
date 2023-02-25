import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/app_constants.dart';

import '../../Controllers/Theme/themecontroller.dart';
import '../../Utils/constants.dart';
import '../text_widget_heading.dart';

class CustomerHeader extends StatelessWidget {
  const CustomerHeader(
      {Key? key,
      this.icon,
      this.image,
      this.title,
      this.onPressed,
      this.titleimage,
      this.titleicon})
      : super(key: key);
  final String? image;
  final IconData? icon;
  final String? titleimage;
  final IconData? titleicon;

  final String? title;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppConst.padding, 0, AppConst.padding, 0),
      child: Stack(
        children: [
          if (image != null || icon != null)
            Positioned(
              top: 0,
              left: 0,
              child: InkWell(
                onTap: onPressed as void Function(),
                child: image != null
                    ? Image.asset(image ?? "")
                    : Icon(
                        icon ?? Icons.arrow_back_ios,
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : Theme.of(context).primaryColorLight,
                        size: 20,
                      ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (title != null)
                    TextWidgetHeading(
                      textAlignment: TextAlign.center,
                      titleHeading: title ?? "",
                      textStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          // letterSpacing: 1.3,
                          fontWeight: FontWeight.w600,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ),
                  if (titleicon != null)
                    Icon(
                      titleicon,
                      color: ThemeController.to.isDark.isTrue
                          ? AppConst.dark_textColor_gw
                          : kButtonColor,
                    ),
                  if (titleimage != null) Image.asset(titleimage ?? ""),
                  // if (title != null)
                  //   TextWidgetHeading(
                  //     textAlignment: TextAlign.center,
                  //     titleHeading: title ?? "",
                  //     textStyle: GoogleFonts.inter(
                  //       textStyle: const TextStyle(
                  //         fontSize: 20,
                  //         // letterSpacing: 1.3,
                  //         fontWeight: FontWeight.w600,
                  //         color: kTextColorSecondary,
                  //       ),
                  //     ),
                  //   ),
                  const SizedBox(height: 2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
