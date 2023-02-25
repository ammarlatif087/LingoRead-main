import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Header/CustomerHeader.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Widgets/shop_card widget.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  SubsType subsType = SubsType.non;

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      // child: Scaffold(
      // key: _scaffoldkey,
      //  drawer: CustomDrawer(context),
      child: Column(
        children: [
          //  SizedBox(height: getProportionateScreenHeight(30)),
          CustomerHeader(
            image: ThemeController.to.isDark.isTrue
                ? "assets/images/icon_menu_white.png"
                : "assets/images/icon_menu.png",
            titleicon: Icons.shopping_cart,
            title: "Shop",
            onPressed: () {
              _scaffoldkey.currentState!.openDrawer();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Container(
              decoration: BoxDecoration(
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
              height: getProportionateScreenHeight(642),
              padding: EdgeInsets.fromLTRB(
                  AppConst.padding, AppConst.padding, AppConst.padding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      height: getProportionateScreenHeight(150),
                      width: getProportionateScreenWidth(217),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(13),
                          bottom: getProportionateScreenHeight(27)),
                      child: TextWidgetHeading(
                        textAlignment: TextAlign.center,
                        titleHeading: 'Start your 7- Days Free access',
                        textStyle: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            // letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: ThemeController.to.isDark.isTrue
                                ? AppConst.colorWhite
                                : kTextColorSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        subsType = SubsType.yearly;
                      });
                    },
                    child: ShopCardWidget(
                      borderColor: subsType == SubsType.yearly
                          ? Colors.transparent
                          : const Color(0xFFBEC3D0),
                      cardBg: subsType == SubsType.yearly
                          ? kButtonColor
                          : Colors.transparent,
                      colorPrimary: subsType == SubsType.yearly
                          ? kPrimaryColor
                          : const Color(0xFFBEC3D0),
                      colorSecondary: subsType == SubsType.yearly
                          ? kPrimaryColor
                          : const Color(0xFFBEC3D0),
                      titleHeading: 'Yearly-& days free',
                      titleSubHeading: 'PKR 166 / Month, billed  at PKR 1990',
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(22),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        subsType = SubsType.monthly;
                      });
                    },
                    child: ShopCardWidget(
                      borderColor: subsType == SubsType.monthly
                          ? Colors.transparent
                          : const Color(0xFFBEC3D0),
                      cardBg: subsType == SubsType.monthly
                          ? kButtonColor
                          : Colors.transparent,
                      colorPrimary: subsType == SubsType.monthly
                          ? kPrimaryColor
                          : const Color(0xFFBEC3D0),
                      colorSecondary: subsType == SubsType.monthly
                          ? kPrimaryColor
                          : const Color(0xFFBEC3D0),
                      titleHeading: 'Monthly -7 days free',
                      titleSubHeading: 'PKR 166 / Month',
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: getProportionateScreenHeight(57),
                    width: getProportionateScreenWidth(340),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: subsType == SubsType.non
                                ? const Color(0xFFBEC3D0)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        color: subsType == SubsType.non
                            ? Colors.transparent
                            : kButtonColor),
                    child: InkWell(
                      onTap: subsType == SubsType.non ? null : () {},
                      child: Center(
                        child: TextWidgetHeading(
                          textAlignment: TextAlign.center,
                          titleHeading: 'START YOU WEEK',
                          textStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(16),
                              // letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              color: subsType == SubsType.non
                                  ? const Color(0xFFBEC3D0)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(54),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
