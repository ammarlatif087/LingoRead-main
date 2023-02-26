import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:translator/translator.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Controllers/Theme/traningKeywords.dart';
import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Widgets/text_widget_heading.dart';

class TotalWords extends StatefulWidget {
  const TotalWords({Key? key}) : super(key: key);

  @override
  State<TotalWords> createState() => _TotalWordsState();
}

class _TotalWordsState extends State<TotalWords> {
  int playingIndex = 0;
  bool showAnswer = false;
  String translatedWord = "";
  @override
  void initState() {
    super.initState();
    if (TrainingKeyword.to.listTrainingKeyword.isNotEmpty) {
      translate(TrainingKeyword.to.listTrainingKeyword[playingIndex]["title"]
          .toString());
    }
  }

  translate(String word) async {
    final translator = GoogleTranslator();

    try {
      Translation translated =
          await translator.translate(word, from: 'de', to: 'en');
      setState(() {
        translatedWord = translated.text;
      });
    } on Exception {
      translatedWord = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(TrainingKeyword.to.listTrainingKeyword[playingIndex].toString());
    return ThemeContainer(
      child: SafeArea(
        child: Scaffold(
            //  backgroundColor: Colors.red,
            body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    AppConst.padding * 1, 0, AppConst.padding * 1, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/words.png',
                          height: getProportionateScreenHeight(35),
                          width: getProportionateScreenWidth(35),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: TextWidgetHeading(
                        textAlignment: TextAlign.center,
                        titleHeading: TrainingKeyword
                            .to.listTrainingKeyword.length
                            .toString(),
                        textStyle: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: getProportionateScreenHeight(28),
                            // letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: kButtonColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (TrainingKeyword.to.listTrainingKeyword.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: TextWidgetHeading(
                              textAlignment: TextAlign.center,
                              titleHeading: TrainingKeyword
                                  .to.listTrainingKeyword[playingIndex]["title"]
                                  .toString(),
                              textStyle: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(28),
                                  // letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColorSecondary,
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.play_circle_outline,
                          //     color: Color(0xffffffff),
                          //   ),
                          //   onPressed: () {
                          //     FlutterTts().speak(TrainingKeyword
                          //         .to
                          //         .listTrainingKeyword[playingIndex]
                          //             ["title"]
                          //         .toString());
                          //   },
                          // ),
                        ],
                      ),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (playingIndex > 0)
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: kButtonColor,
                            ),
                            onPressed: () {
                              setState(() {
                                translatedWord = "";

                                showAnswer = false;
                                playingIndex--;
                              });
                              translate(TrainingKeyword
                                  .to.listTrainingKeyword[playingIndex]["title"]
                                  .toString());
                            },
                          ),
                        const Expanded(child: Text("")),
                        if (playingIndex + 1 !=
                            TrainingKeyword.to.listTrainingKeyword.length)
                          ThemeController.to.isDark.isTrue
                              ? Row(
                                  children: [
                                    const Text(
                                      'Next',
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Colors.green.withOpacity(0.7)),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xff000000),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            translatedWord = "";
                                            showAnswer = false;
                                            playingIndex++;
                                          });
                                          translate(TrainingKeyword
                                              .to
                                              .listTrainingKeyword[playingIndex]
                                                  ["title"]
                                              .toString());
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kButtonColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      translatedWord = "";
                                      showAnswer = false;
                                      playingIndex++;
                                    });
                                    translate(TrainingKeyword
                                        .to
                                        .listTrainingKeyword[playingIndex]
                                            ["title"]
                                        .toString());
                                  },
                                ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Center(
                      child: Container(
                        height: getProportionateScreenHeight(37),
                        width: getProportionateScreenHeight(84),
                        decoration: BoxDecoration(
                            color: const Color(0xff18a5d3).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: kButtonColor,
                                ),
                                onPressed: () {
                                  FlutterTts().speak(TrainingKeyword
                                      .to
                                      .listTrainingKeyword[playingIndex]
                                          ["title"]
                                      .toString());
                                },
                              ),
                            ),
                            TextWidgetHeading(
                              textAlignment: TextAlign.center,
                              titleHeading: 'Play',
                              textStyle: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
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
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    if (!showAnswer)
                      Center(
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              height: getProportionateScreenHeight(57),
                              width: getProportionateScreenWidth(340),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kButtonColor,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showAnswer = true;
                                  });
                                },
                                child: Center(
                                    child: Text('Show Answer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                fontWeight: FontWeight.bold))),
                              )),
                        ),
                      ),
                    if (showAnswer)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Divider(
                            // color: Colors.black,
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextWidgetHeading(
                                  textAlignment: TextAlign.center,
                                  titleHeading: translatedWord,
                                  textStyle: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                      // letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (showAnswer)
              Obx(
                () => Padding(
                  padding: EdgeInsets.all(AppConst.padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      widgetForStatusChange(
                          "Hard",
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0XFFF6E5E5), () {
                        TrainingKeyword.to.changeStatus(
                            TrainingKeyword.to.listTrainingKeyword[playingIndex]
                                ["keyword"],
                            "Hard");
                      },
                          TrainingKeyword.to.listTrainingKeyword[playingIndex]
                              ["status"]),
                      widgetForStatusChange(
                          "Okay",
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0XFFE0E0F1), () {
                        TrainingKeyword.to.changeStatus(
                            TrainingKeyword.to.listTrainingKeyword[playingIndex]
                                ["keyword"],
                            "Okay");
                      },
                          TrainingKeyword.to.listTrainingKeyword[playingIndex]
                              ["status"]),
                      widgetForStatusChange(
                          "Easy",
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0xFFE0E0F1), () {
                        TrainingKeyword.to.changeStatus(
                            TrainingKeyword.to.listTrainingKeyword[playingIndex]
                                ["keyword"],
                            "Easy");
                      },
                          TrainingKeyword.to.listTrainingKeyword[playingIndex]
                              ["status"]),
                      widgetForStatusChange(
                          "Done",
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0xff18A5D3).withOpacity(0.3), () {
                        TrainingKeyword.to.changeStatus(
                            TrainingKeyword.to.listTrainingKeyword[playingIndex]
                                ["keyword"],
                            "Done");
                      },
                          TrainingKeyword.to.listTrainingKeyword[playingIndex]
                              ["status"]),
                    ],
                  ),
                ),
              )
          ],
        )),
      ),
    );
  }

  Widget widgetForStatusChange(
      String title, Color color, void Function()? onTap, String status) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenHeight(17),
            backgroundColor: color,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: title == status ? color : kButtonColor,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextWidgetHeading(
            textAlignment: TextAlign.center,
            titleHeading: title,
            textStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: getProportionateScreenHeight(12),
                // letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: kTextColorSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
