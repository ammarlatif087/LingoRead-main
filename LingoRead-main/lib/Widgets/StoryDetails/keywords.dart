import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/keywordcontroller.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Controllers/Theme/traningKeywords.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';

import '../../Utils/app_constants.dart';
import '../text_widget_heading.dart';

class KeyWords extends StatelessWidget {
  const KeyWords(this.keywords, this.flutterTts, {Key? key}) : super(key: key);
  final List keywords;
  final FlutterTts flutterTts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: keywords.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic keyword = keywords[index];

                  return Keyword(keyword, flutterTts);
                }),
          ),
        )
      ],
    );
  }
}

class Keyword extends StatelessWidget {
  Keyword(this.keyword, this.flutterTts, {Key? key}) : super(key: key);
  final dynamic keyword;
  KeywordController keywordController = Get.put(KeywordController());
  final FlutterTts flutterTts;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF5A6CEA).withOpacity(0.3),
              // offset: const Offset(
              //   2.0,
              //   2.0,
              // ),
              blurRadius: 1.0,
              spreadRadius: .0,
            ), //BoxShadow
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(10),
          color: ThemeController.to.isDark.isTrue
              ? AppConst.dark_colorPrimaryDark
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                //  flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgetHeading(
                      textAlignment: TextAlign.center,
                      titleHeading: (keyword ?? {})["title"] ?? "",
                      textStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: getProportionateScreenHeight(18),
                          // letterSpacing: 1.3,
                          fontWeight: FontWeight.w400,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ),
                    Text(
                      (keyword ?? {})["subtitle"] ?? "",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: const Color(
                            0xffA7A7A7,
                          ),
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      flutterTts.speak((keyword ?? {})["title"] ?? "");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.play_circle_outline_rounded,
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : const Color(0XFFBEC3D0),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (((TrainingKeyword.to.listTrainingKeyword.indexWhere(
                              (element) =>
                                  element["keyword"].toString() ==
                                  keyword["id"].toString())) >
                          -1)) {
                        TrainingKeyword.to.removeFromFav(keyword["id"],
                            isTrainingScreen: true);
                        // keywordController.setAddedStatus(false);
                      } else {
                        TrainingKeyword.to.addtoTraining(keyword["id"],
                            isTrainingScreen: true);
                        // keywordController.setAddedStatus(true);
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   color: ((TrainingKeyword.to.listTrainingKeyword
                        //               .indexWhere((element) =>
                        //                   element["keyword"].toString() ==
                        //                   keyword["id"].toString())) >
                        //           -1)
                        //       ? Theme.of(context).primaryColor
                        //       : Color(0XFFBEC3D0),
                        // ),
                        child: const Icon(
                          Icons.note_alt_rounded,
                          color: Color(0XFFBEC3D0),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
