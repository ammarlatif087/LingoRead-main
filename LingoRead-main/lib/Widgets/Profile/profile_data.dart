import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';

import '../../Controllers/Theme/themecontroller.dart';
import '../../Utils/app_constants.dart';

class ProfileData extends StatelessWidget {
  const ProfileData(this.text, this.icon1, this.number,
      {Key? key, required this.color})
      : super(key: key);
  final String text;
  final IconData icon1;
  final int number;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0XFF5A6CEA).withOpacity(0.1),
                  // offset: const Offset(
                  //   5.0,
                  //   5.0,
                  // ),
                  blurRadius: getProportionateScreenHeight(15),
                  // spreadRadius: 2.0,
                ), //BoxShadow
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            width: getProportionateScreenWidth(330),
            height: getProportionateScreenHeight(65),
            child: ListTile(
              leading: Icon(
                icon1,
                color: color,
              ),
              title: TextWidgetHeading(
                textAlignment: TextAlign.center,
                titleHeading: text,
                textStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(15),
                    // letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: kTextColorSecondary,
                  ),
                ),
              ),
              trailing: SizedBox(
                width: getProportionateScreenWidth(30),
                child: Text(
                  number.toString(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : kButtonColor,
                      ),
                ),
              ),
            ),
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       text,
        //       style: Theme.of(context).textTheme.headline4!.copyWith(
        //           color: ThemeController.to.isDark.isTrue
        //               ? AppConst.colorWhite
        //               : Theme.of(context).primaryColor),
        //     ),
        //     const SizedBox(
        //       width: 5,
        //     ),
        //     Icon(
        //       icon1,
        //       color: color,
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // CircleAvatar(
        //   backgroundColor: Theme.of(context).primaryColorLight,
        //   child: Text(number.toString(),
        //       style: Theme.of(context).textTheme.headline4!.copyWith(
        //             fontFamily: GoogleFonts.poppins().fontFamily,
        //             color: ThemeController.to.isDark.isTrue
        //                 ? AppConst.colorWhite
        //                 : Theme.of(context).primaryColorDark,
        //           )),
        // ),
      ],
    );
  }
}
