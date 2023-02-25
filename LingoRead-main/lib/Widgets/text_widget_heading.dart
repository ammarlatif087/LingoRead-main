import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgetHeading extends StatelessWidget {
  String? titleHeading;
  TextOverflow? overflow;
  int? maxLine;

  TextStyle? textStyle, textAlign;
  TextAlign? textAlignment;

  FontWeight? fontWeight;
  TextWidgetHeading({
    this.maxLine,
    this.overflow,
    this.titleHeading,
    this.textStyle,
    this.textAlignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleHeading!,
      overflow: overflow,
      style: textStyle,
      textAlign: textAlignment,
      maxLines: maxLine,

      //maxLines: 1,

      //  GoogleFonts.viga(
      //   textStyle: TextStyle(
      //     fontSize: fontSize,
      //     fontWeight: fontWeight,
      //     color: color,
      //   ),
      // ),
    );
  }
}
