import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/constants.dart';

import '../Utils/app_constants.dart';
import '../Utils/size_config.dart';
import 'text_widget_heading.dart';

class TrainingScreenWidget extends StatelessWidget {
  const TrainingScreenWidget(this.obj, {Key? key}) : super(key: key);

  final dynamic obj;

  @override
  Widget build(BuildContext context) {
    print(obj);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConst.padding,
        vertical: AppConst.padding * 0.2,
      ),
      child: Container(
        padding: EdgeInsets.all(AppConst.padding * 0.25),
        decoration: BoxDecoration(
            border: Border.all(
                color: ThemeController.to.isDark.isTrue
                    ? AppConst.colorWhite
                    : Colors.black),
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  obj["title"] ?? "",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              InkWell(
                onTap: () {
                  FlutterTts().speak(obj["title"] ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.play_arrow,
                    color: ThemeController.to.isDark.isTrue
                        ? AppConst.colorWhite
                        : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrainingReviewWidget extends StatelessWidget {
  const TrainingReviewWidget(this.color, this.number, this.text, {Key? key})
      : super(key: key);
  final String text;
  final int number;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: getProportionateScreenHeight(103),
      width: getProportionateScreenWidth(166),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(20)),
              child: TextWidgetHeading(
                textAlignment: TextAlign.center,
                titleHeading: text,
                textStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(18),
                    // letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: kTextColorSecondary,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidgetHeading(
                  textAlignment: TextAlign.center,
                  titleHeading: number.toString(),
                  textStyle: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(25),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
