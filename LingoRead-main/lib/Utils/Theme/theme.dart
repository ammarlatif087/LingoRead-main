import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/app_constants.dart';

class CustomThemeData {
  static ThemeData themeDark() {
    return ThemeData(
      primaryColor: AppConst.colorPrimaryDark,
      primaryColorLight: AppConst.dark_colorPrimaryDark,
      primaryColorDark: AppConst.colorWhite,
      backgroundColor: AppConst.dark_backgruondColor,
      scaffoldBackgroundColor: Colors.transparent,
      // primarySwatch: MaterialColor(primary, swatch),
      fontFamily: GoogleFonts.raleway().fontFamily,
      unselectedWidgetColor: Colors.white.withOpacity(0.7),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(AppConst.colorPrimaryLight),
              foregroundColor: MaterialStateProperty.all(AppConst.colorWhite),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.black,
                ),
              ))),
      colorScheme: ColorScheme.light(
        primary: AppConst.dark_colorPrimaryDark,
        onPrimary: AppConst.colorWhite,
        secondary: AppConst.colorPrimaryLight,
        onSecondary: AppConst.colorPrimaryDark,
        surface: AppConst.colorWhite,
        onSurface: AppConst.colorBlack,
        background: AppConst.dark_textColor_gw,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 28,
          color: AppConst.colorWhite,
          fontWeight: FontWeight.w900,
        ),
        headline2: TextStyle(
          fontSize: 18,
          color: AppConst.dark_textColor_gw,
          fontWeight: FontWeight.w900,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: AppConst.colorWhite,
        ),
        headline4: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppConst.colorWhite,
        ),
        headline5: TextStyle(
          fontSize: 12,
          color: AppConst.colorWhite,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: AppConst.colorWhite,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          color: AppConst.colorWhite,
        ),
      ),
    );
  }

  static ThemeData themeLight() {
    return ThemeData(
      primaryColor: AppConst.colorPrimaryLight,
      primaryColorLight: AppConst.colorWhite,
      primaryColorDark: AppConst.colorPrimaryDark,
      backgroundColor: AppConst.light_backgruondColor,
      scaffoldBackgroundColor: Colors.transparent,
      // primarySwatch: MaterialColor(primary, swatch),
      fontFamily: GoogleFonts.raleway().fontFamily,
      unselectedWidgetColor: Colors.white.withOpacity(0.7),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(AppConst.colorPrimaryLight),
              foregroundColor: MaterialStateProperty.all(AppConst.colorWhite),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.black,
                ),
              ))),
      colorScheme: ColorScheme.light(
        
        primary: AppConst.colorPrimaryLightv4_00959B,
        //free
        onPrimary: AppConst.colorWhite,
        //free
        secondary: AppConst.colorPrimaryLight,
        //free
        onSecondary: AppConst.colorPrimaryDark,
        //free
        surface: AppConst.dark_colorMainLight,
        onSurface: AppConst.colorBlack,
        background: AppConst.light_textColor_gw,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 28,
          color: AppConst.colorWhite,
          fontWeight: FontWeight.w900,
        ),
        headline2: TextStyle(
          fontSize: 18,
          color: AppConst.colorWhite,
          fontWeight: FontWeight.w900,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: AppConst.colorWhite,
        ),
        headline4: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppConst.colorWhite,
        ),
        headline5: TextStyle(
          fontSize: 12,
          color: AppConst.colorWhite,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: AppConst.colorWhite,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          color: AppConst.colorWhite,
        ),
      ),
    );
  }
}
