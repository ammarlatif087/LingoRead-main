import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lingoread/Utils/size_config.dart';

const kPrimaryColor = Color(0xFFFFFFFF);
const kButtonColor = Color(0xFF18A5D3);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF18A5D3),
    // Color(0xFF18A5D3),
    Color(0XFFB3D8EE),
  ],
);
const kTextColorPrimary = Color(0xFFFFFFFF);
const kTextColorSecondary = Color(0xFF09051C);

final introTextStyle = TextStyle(
  fontFamily: 'Poppins-Bold',
  fontSize: getProportionateScreenHeight(16),
  color: const Color(0xffFFFFFF),
  fontWeight: FontWeight.w300,
);
const kAnimationDuration = Duration(milliseconds: 200);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

//////
class MyGoogleFont extends GoogleFonts {
  final double fontSize;
  final FontWeight fontWeight;

  MyGoogleFont({
    required String font,
    required this.fontSize,
    required this.fontWeight,
  });

  TextStyle getStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}

enum SubsType { monthly, yearly, non }
