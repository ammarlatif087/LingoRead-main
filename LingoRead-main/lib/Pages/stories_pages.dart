import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/learnedStories.dart';
import 'package:lingoread/Controllers/Theme/storyDetails_controller.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Buttons/button_main.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/StoryDetails/grammar.dart';
import 'package:lingoread/Widgets/StoryDetails/keywords.dart';
import 'package:lingoread/Widgets/StoryDetails/quiz.dart';
import 'package:lingoread/Widgets/StoryDetails/story.dart';
import 'package:translator/translator.dart';

import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Widgets/Main/paid_star.dart';
import '../Widgets/text_widget_heading.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    storyDetailsControllers.setStory(Get.arguments);
    setState(() {
      isPaidStory =
          (((Get.arguments ?? {})["subscription_type"] ?? "") == "Paid")
              ? true
              : false;
      story = Get.arguments;
      textGerman = (Get.arguments ?? {})["description"] ?? "";
      storyId = (Get.arguments ?? {})["id"] ?? "";
      keywords = (((Get.arguments ?? {})["keywords"]) != false)
          ? (Get.arguments ?? {})["keywords"] ?? []
          : [];
      grammer = (((Get.arguments ?? {})["grammer"]) != false)
          ? (Get.arguments ?? {})["grammer"] ?? []
          : [];
      questions = (((Get.arguments ?? {})["questions"]) != false)
          ? (Get.arguments ?? {})["questions"] ?? []
          : [];

      image = (Get.arguments ?? {})["image"] ?? "";
      checkBoxValue = (LearnedStories.to
                  .checkIfAddedtoTraining((Get.arguments ?? {})["id"] ?? "") >
              -1)
          ? true
          : false;
    });
    print(Get.arguments);
  }

  StoryDetailsControllers storyDetailsControllers =
      Get.put(StoryDetailsControllers());
  List keywords = [];
  List grammer = [];
  List questions = [];
  String image = "";
  dynamic story = {};
  bool value = false;
  int screenNo = 0;
  bool checkBoxValue = false;
  String textGerman = "";

  String storyId = "-1";
  bool isPaidStory = false;
  String wordToTranslate = "";
  String translatedWord = "";
  final translator = GoogleTranslator();
  List listTextGerman = [];
  int selectedWordIndex = -1;
  FlutterTts flutterTts = FlutterTts();
  bool playingAudio = false;
  bool pauseAudio = false;
  bool is1x = true;
  String speed = "1";
  String readingword = "";

  playAudioOnSpeedChange() async {
    await flutterTts.setLanguage("de");
    await flutterTts.setQueueMode(1);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(storyDetailsControllers.getNewStringtoPlay());
    flutterTts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
      log("$startOffset $endOffset $word");
      storyDetailsControllers.setPlayingIndex(word);
    });

    flutterTts.setCancelHandler(() {
      // storyDetailsControllers
      //     .resetDataAfterRead();
    });
    flutterTts.setCompletionHandler(() {
      flutterTts.stop();
      storyDetailsControllers.resetDataAfterRead();
      setState(() {
        playingAudio = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: Scaffold(
        //   backgroundColor: Colors.green,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///-------------App Bar
                Obx(
                  () => Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppConst.padding * 2),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(24)),
                          child: Container(
                            height: getProportionateScreenHeight(45),
                            width: getProportionateScreenWidth(45),
                            decoration: BoxDecoration(
                              color: kButtonColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ThemeController.to.isDark.isTrue
                                    ? AppConst.colorWhite
                                    : kButtonColor,
                                size: 20,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(24),
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(24)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        screenNo = 0;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        TextWidgetHeading(
                                          textAlignment: TextAlign.center,
                                          titleHeading: 'Story',
                                          textStyle: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              // letterSpacing: 1.3,
                                              fontWeight: FontWeight.w500,
                                              color: (screenNo == 0)
                                                  ? kTextColorSecondary
                                                  : ThemeController
                                                          .to.isDark.isTrue
                                                      ? AppConst.colorWhite
                                                      : kTextColorSecondary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(4),
                                        ),
                                        Visibility(
                                          visible: screenNo == 0,
                                          child: Container(
                                            color: kButtonColor,
                                            height: 2,
                                            width: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (isPaidStory) {
                                        AppFunctions.subcribeplan(context);
                                      } else {
                                        if (screenNo != 1) {
                                          flutterTts.stop();
                                          setState(() {
                                            playingAudio = false;
                                            selectedWordIndex = 0;
                                          });
                                        }
                                        setState(() {
                                          screenNo = 1;
                                        });
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            TextWidgetHeading(
                                              textAlignment: TextAlign.center,
                                              titleHeading: 'Quiz',
                                              textStyle: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  // letterSpacing: 1.3,
                                                  fontWeight: FontWeight.w500,
                                                  color: (screenNo == 1)
                                                      ? kTextColorSecondary
                                                      : ThemeController
                                                              .to.isDark.isTrue
                                                          ? AppConst.colorWhite
                                                          : kTextColorSecondary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      4),
                                            ),
                                            Visibility(
                                              visible: screenNo == 1,
                                              child: Container(
                                                color: kButtonColor,
                                                height: 2,
                                                width: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (isPaidStory) const PaidStar()
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (isPaidStory) {
                                            AppFunctions.subcribeplan(context);
                                          } else {
                                            if (screenNo != 2) {
                                              flutterTts.stop();
                                              setState(() {
                                                playingAudio = false;
                                                selectedWordIndex = 0;
                                              });
                                            }
                                            setState(() {
                                              screenNo = 2;
                                            });
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            TextWidgetHeading(
                                              textAlignment: TextAlign.center,
                                              titleHeading: 'Keywords',
                                              textStyle: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  // letterSpacing: 1.3,
                                                  fontWeight: FontWeight.w500,
                                                  color: (screenNo == 3)
                                                      ? kTextColorSecondary
                                                      : ThemeController
                                                              .to.isDark.isTrue
                                                          ? AppConst.colorWhite
                                                          : kTextColorSecondary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      4),
                                            ),
                                            Visibility(
                                              visible: screenNo == 2,
                                              child: Container(
                                                color: kButtonColor,
                                                height: 2,
                                                width: 75,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isPaidStory) const PaidStar()
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (isPaidStory) {
                                        AppFunctions.subcribeplan(context);
                                      } else {
                                        if (screenNo != 3) {
                                          flutterTts.stop();
                                          setState(() {
                                            playingAudio = false;
                                            selectedWordIndex = 0;
                                          });
                                        }
                                        setState(() {
                                          screenNo = 3;
                                        });
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            TextWidgetHeading(
                                              textAlignment: TextAlign.center,
                                              titleHeading: 'Grammer',
                                              textStyle: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  // letterSpacing: 1.3,
                                                  fontWeight: FontWeight.w500,
                                                  color: (screenNo == 3)
                                                      ? kTextColorSecondary
                                                      : ThemeController
                                                              .to.isDark.isTrue
                                                          ? AppConst.colorWhite
                                                          : kTextColorSecondary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      4),
                                            ),
                                            Visibility(
                                              visible: screenNo == 3,
                                              child: Container(
                                                color: kButtonColor,
                                                height: 2,
                                                width: 75,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (isPaidStory) const PaidStar()
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(12),
                ),

                ///-------Hero Image Box with Play/Pause & Speed Controllers
                // Obx(
                //   () => Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: [
                //             InkWell(
                //               onTap: () {
                //                 setState(() {
                //                   screenNo = 0;
                //                 });
                //               },
                //               child: Column(
                //                 children: [
                //                   Text(
                //                     "Story",
                //                     style: TextStyle(
                //                       color: (screenNo == 0)
                //                           ? kTextColorSecondary
                //                           : ThemeController.to.isDark.isTrue
                //                               ? AppConst.colorWhite
                //                               : kTextColorSecondary,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: getProportionateScreenHeight(4),
                //                   ),
                //                   Visibility(
                //                     visible: screenNo == 0,
                //                     child: Container(
                //                       color: kButtonColor,
                //                       height: 2,
                //                       width: 40,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             InkWell(
                //               onTap: () {
                //                 if (isPaidStory) {
                //                   AppFunctions.subcribeplan(context);
                //                 } else {
                //                   if (screenNo != 1) {
                //                     flutterTts.stop();
                //                     setState(() {
                //                       playingAudio = false;
                //                       selectedWordIndex = 0;
                //                     });
                //                   }
                //                   setState(() {
                //                     screenNo = 1;
                //                   });
                //                 }
                //               },
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Column(
                //                     children: [
                //                       Text(
                //                         "Quiz",
                //                         style: TextStyle(
                //                           color: (screenNo == 1)
                //                               ? kTextColorSecondary
                //                               : ThemeController.to.isDark.isTrue
                //                                   ? AppConst.colorWhite
                //                                   : kTextColorSecondary,
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: getProportionateScreenHeight(4),
                //                       ),
                //                       Visibility(
                //                         visible: screenNo == 1,
                //                         child: Container(
                //                           color: kButtonColor,
                //                           height: 2,
                //                           width: 40,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   if (isPaidStory) const PaidStar()
                //                 ],
                //               ),
                //             ),
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     if (isPaidStory) {
                //                       AppFunctions.subcribeplan(context);
                //                     } else {
                //                       if (screenNo != 2) {
                //                         flutterTts.stop();
                //                         setState(() {
                //                           playingAudio = false;
                //                           selectedWordIndex = 0;
                //                         });
                //                       }
                //                       setState(() {
                //                         screenNo = 2;
                //                       });
                //                     }
                //                   },
                //                   child: Column(
                //                     children: [
                //                       Text(
                //                         "Keywords",
                //                         style: TextStyle(
                //                           color: (screenNo == 2)
                //                               ? kTextColorSecondary
                //                               : ThemeController.to.isDark.isTrue
                //                                   ? AppConst.colorWhite
                //                                   : kTextColorSecondary,
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: getProportionateScreenHeight(4),
                //                       ),
                //                       Visibility(
                //                         visible: screenNo == 2,
                //                         child: Container(
                //                           color: kButtonColor,
                //                           height: 2,
                //                           width: 75,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 if (isPaidStory) const PaidStar()
                //               ],
                //             ),
                //             InkWell(
                //               onTap: () {
                //                 if (isPaidStory) {
                //                   AppFunctions.subcribeplan(context);
                //                 } else {
                //                   if (screenNo != 3) {
                //                     flutterTts.stop();
                //                     setState(() {
                //                       playingAudio = false;
                //                       selectedWordIndex = 0;
                //                     });
                //                   }
                //                   setState(() {
                //                     screenNo = 3;
                //                   });
                //                 }
                //               },
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Column(
                //                     children: [
                //                       Text(
                //                         "Grammer",
                //                         style: TextStyle(
                //                           color: (screenNo == 3)
                //                               ? kTextColorSecondary
                //                               : ThemeController.to.isDark.isTrue
                //                                   ? AppConst.colorWhite
                //                                   : kTextColorSecondary,
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: getProportionateScreenHeight(4),
                //                       ),
                //                       Visibility(
                //                         visible: screenNo == 3,
                //                         child: Container(
                //                           color: kButtonColor,
                //                           height: 2,
                //                           width: 75,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   if (isPaidStory) const PaidStar()
                //                 ],
                //               ),
                //             ),
                //           ]),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: Container(
                    height: getProportionateScreenHeight(265),
                    width: MediaQuery.of(context).size.width,
                    //  padding: const EdgeInsets.all(10),
                    //  margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: (image == "")
                          ? null
                          : DecorationImage(
                              image: NetworkImage(image.contains("http")
                                  ? image
                                  : (AppConst.imagebaseurl + image)),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppConst.padding),
                              child: InkWell(
                                onTap: () {
                                  if (checkBoxValue) {
                                    LearnedStories.to.removeFromFLearned(
                                        storyId,
                                        isLearnedStoreisScreen: true);
                                    setState(() {
                                      checkBoxValue = !checkBoxValue;
                                    });
                                  } else {
                                    LearnedStories.to.addtoLearned(storyId,
                                        isLearnedStoreisScreen: true);

                                    setState(() {
                                      checkBoxValue = !checkBoxValue;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: getProportionateScreenHeight(32),
                                    width: getProportionateScreenWidth(132),
                                    decoration: BoxDecoration(
                                        color: kButtonColor.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(
                                            getProportionateScreenHeight(16))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextWidgetHeading(
                                          textAlignment: TextAlign.center,
                                          titleHeading: 'Mark As Learned',
                                          textStyle: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      10),
                                              // letterSpacing: 1.3,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeController
                                                      .to.isDark.isTrue
                                                  ? AppConst.light_textColor_gw
                                                  : kTextColorPrimary,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 11,
                                            backgroundColor: Theme.of(context)
                                                .primaryColorLight,
                                            child: CircleAvatar(
                                                radius: 8,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor: checkBoxValue
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          if (storyDetailsControllers.wordToTranslate.value !=
                              "")
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.white.withOpacity(1),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          storyDetailsControllers
                                              .wordToTranslate.value,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            storyDetailsControllers
                                                .translatedWord.value,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        flutterTts.speak(storyDetailsControllers
                                            .wordToTranslate.value);
                                      },
                                      icon: const Icon(
                                        Icons.play_circle_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),

                          // Row(
                          //   children: [
                          //     ///------Pause  / Play Button
                          //     //---- this will be shown when reading is continue
                          //     playingAudio
                          //         ? Padding(
                          //             padding: const EdgeInsets.only(right: 10),
                          //             child: CircleAvatar(
                          //               backgroundColor:
                          //                   ThemeController.to.isDark.isTrue
                          //                       ? AppConst.colorBlack
                          //                       : const Color(0xff00ACC4),
                          //               radius: 20,
                          //               child: IconButton(
                          //                 icon: Icon(
                          //                     pauseAudio
                          //                         ? Icons.pause
                          //                         : Icons.play_arrow,
                          //                     color: Colors.white),
                          //                 onPressed: (screenNo != 0)
                          //                     ? () {
                          //                         AppFunctions.showSnackBar(
                          //                             "Info",
                          //                             "Open Story Tab to Play Story");
                          //                       }
                          //                     : () async {
                          //                         if (pauseAudio) {
                          //                           //   ///----if audio is playing then just stop it

                          //                           flutterTts.stop();
                          //                           setState(() {
                          //                             pauseAudio = !pauseAudio;
                          //                           });
                          //                         } else {
                          //                           ///----- on resume functionality will be added here

                          //                           setState(() {
                          //                             pauseAudio = !pauseAudio;
                          //                           });

                          //                           ///----- on resume functionality will be added here
                          //                           await flutterTts
                          //                               .setLanguage("de");
                          //                           await flutterTts
                          //                               .setQueueMode(1);
                          //                           await flutterTts
                          //                               .awaitSpeakCompletion(
                          //                                   true);

                          //                           ///-----Replace the Previous Full Description to Latest Description read so far
                          //                           // await flutterTts
                          //                           //     .speak(textGerman);
                          //                           print(
                          //                               storyDetailsControllers
                          //                                   .selectedWordIndex
                          //                                   .value);

                          //                           await flutterTts.speak(
                          //                               storyDetailsControllers
                          //                                   .getNewStringtoPlay());

                          //                           flutterTts
                          //                               .setProgressHandler(
                          //                                   (String text,
                          //                                       int startOffset,
                          //                                       int endOffset,
                          //                                       String word) {
                          //                             log("$startOffset $endOffset $word");
                          //                             storyDetailsControllers
                          //                                 .setPlayingIndex(
                          //                                     word);
                          //                           });

                          //                           flutterTts
                          //                               .setCancelHandler(() {
                          //                             // storyDetailsControllers
                          //                             //     .resetDataAfterRead();
                          //                           });
                          //                           flutterTts
                          //                               .setCompletionHandler(
                          //                                   () {
                          //                             flutterTts.stop();
                          //                             storyDetailsControllers
                          //                                 .resetDataAfterRead();
                          //                             setState(() {
                          //                               playingAudio = false;
                          //                             });
                          //                           });
                          //                         }
                          //                       },
                          //               ),
                          //             ),
                          //           )
                          //         : const SizedBox.shrink(),

                          //     ///---------Play / Restart Button
                          //     Stack(
                          //       children: [
                          //         CircleAvatar(
                          //           backgroundColor:
                          //               ThemeController.to.isDark.isTrue
                          //                   ? AppConst.colorBlack
                          //                   : const Color(0xff00ACC4),
                          //           radius: 20,
                          //           child: IconButton(
                          //             icon: Icon(
                          //                 playingAudio
                          //                     ? Icons.stop
                          //                     : Icons.play_arrow,
                          //                 color: Colors.white),
                          //             onPressed: (screenNo != 0)
                          //                 ? () {
                          //                     AppFunctions.showSnackBar("Info",
                          //                         "Open Story Tab to Play Story");
                          //                   }
                          //                 : () async {
                          //                     if (isPaidStory) {
                          //                       AppFunctions.subcribeplan(
                          //                           context);
                          //                     } else {
                          //                       if (playingAudio) {
                          //                         flutterTts.stop();
                          //                         storyDetailsControllers
                          //                             .resetDataAfterRead();
                          //                         setState(() {
                          //                           playingAudio = false;
                          //                           selectedWordIndex = 0;
                          //                         });
                          //                       } else {
                          //                         await flutterTts
                          //                             .setLanguage("de");
                          //                         await flutterTts
                          //                             .setQueueMode(1);
                          //                         await flutterTts
                          //                             .awaitSpeakCompletion(
                          //                                 true);
                          //                         await flutterTts
                          //                             .speak(textGerman);
                          //                         flutterTts.setProgressHandler(
                          //                             (String text,
                          //                                 int startOffset,
                          //                                 int endOffset,
                          //                                 String word) {
                          //                           print(
                          //                               "$startOffset $endOffset $word");
                          //                           storyDetailsControllers
                          //                               .setPlayingIndex(word);
                          //                         });

                          //                         setState(() {
                          //                           selectedWordIndex = 0;
                          //                           playingAudio = true;
                          //                           pauseAudio = true;
                          //                         });
                          //                         flutterTts
                          //                             .setCancelHandler(() {});
                          //                         flutterTts
                          //                             .setCompletionHandler(() {
                          //                           flutterTts.stop();
                          //                           storyDetailsControllers
                          //                               .resetDataAfterRead();
                          //                           setState(() {
                          //                             playingAudio = false;
                          //                           });
                          //                         });
                          //                       }
                          //                     }
                          //                   },
                          //           ),
                          //         ),
                          //         if (isPaidStory)
                          //           const Positioned(
                          //             child: PaidStar(),
                          //             top: 0,
                          //             right: 0,
                          //           )
                          //       ],
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),

                          //     ///------Speed Button
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           color: ThemeController.to.isDark.isTrue
                          //               ? AppConst.colorBlack
                          //               : const Color(0xff58B9B3),
                          //           borderRadius: BorderRadius.circular(25)),
                          //       child: IconButton(
                          //         icon: Text(
                          //           speed + "x".toUpperCase(),
                          //           style: TextStyle(
                          //               color: ThemeController.to.isDark.isTrue
                          //                   ? AppConst.colorWhite
                          //                   : Theme.of(context)
                          //                       .primaryColorLight,
                          //               fontSize: 14,
                          //               fontFamily:
                          //                   GoogleFonts.dmSans().fontFamily,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //         onPressed: () async {
                          //           if (speed == "0.5") {
                          //             await flutterTts.stop();
                          //             await flutterTts.setSpeechRate(0.35);
                          //             setState(() {
                          //               speed = "0.7";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           } else if (speed == "0.7") {
                          //             await flutterTts.stop();
                          //             flutterTts.setSpeechRate(0.5);
                          //             setState(() {
                          //               speed = "1";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           } else if (speed == "1") {
                          //             await flutterTts.stop();

                          //             flutterTts.setSpeechRate(0.7);
                          //             setState(() {
                          //               speed = "1.5";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           } else if (speed == "1.5") {
                          //             await flutterTts.stop();

                          //             flutterTts.setSpeechRate(1.0);
                          //             setState(() {
                          //               speed = "2";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           } else if (speed == "2") {
                          //             await flutterTts.stop();

                          //             flutterTts.setSpeechRate(0.25);
                          //             setState(() {
                          //               speed = "0.5";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           } else {
                          //             await flutterTts.stop();

                          //             setState(() {
                          //               flutterTts.setSpeechRate(0.5);
                          //               speed = "1";
                          //             });
                          //             playAudioOnSpeedChange();
                          //           }
                          //           // flutterTts.setSpeechRate(!is1x ? 0.5 : 1.0);

                          //           // setState(() {
                          //           //   is1x = !is1x;
                          //           // });
                          //         },
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Obx(
                //   () => Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: ThemeController.to.isDark.isTrue
                //           ? AppConst.dark_colorPrimaryDark
                //           : Color(0xff58B9B3),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: [
                //             InkWell(
                //               onTap: () {
                //                 setState(() {
                //                   screenNo = 0;
                //                 });
                //               },
                //               child: Text(
                //                 "Story",
                //                 style: TextStyle(
                //                     color: (screenNo == 0)
                //                         ? Color(0xFF162D3B)
                //                         : ThemeController.to.isDark.isTrue
                //                             ? AppConst.colorWhite
                //                             : Theme.of(context)
                //                                 .primaryColorLight,
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             Container(
                //                 width: 2, height: 20, color: Colors.white),
                //             InkWell(
                //               onTap: () {
                //                 if (isPaidStory) {
                //                   AppFunctions.subcribeplan(context);
                //                 } else {
                //                   if (screenNo != 1) {
                //                     flutterTts.stop();
                //                     setState(() {
                //                       playingAudio = false;
                //                       selectedWordIndex = 0;
                //                     });
                //                   }
                //                   setState(() {
                //                     screenNo = 1;
                //                   });
                //                 }
                //               },
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "Quiz",
                //                     style: TextStyle(
                //                       color: (screenNo == 1)
                //                           ? Color(0xFF162D3B)
                //                           : ThemeController.to.isDark.isTrue
                //                               ? AppConst.colorWhite
                //                               : Theme.of(context)
                //                                   .primaryColorLight,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   if (isPaidStory) PaidStar()
                //                 ],
                //               ),
                //             ),
                //             Container(
                //                 width: 2, height: 20, color: Colors.white),
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     if (isPaidStory) {
                //                       AppFunctions.subcribeplan(context);
                //                     } else {
                //                       if (screenNo != 2) {
                //                         flutterTts.stop();
                //                         setState(() {
                //                           playingAudio = false;
                //                           selectedWordIndex = 0;
                //                         });
                //                       }
                //                       setState(() {
                //                         screenNo = 2;
                //                       });
                //                     }
                //                   },
                //                   child: Text(
                //                     "Keywords",
                //                     style: TextStyle(
                //                       color: (screenNo == 2)
                //                           ? Color(0xFF162D3B)
                //                           : ThemeController.to.isDark.isTrue
                //                               ? AppConst.colorWhite
                //                               : Theme.of(context)
                //                                   .primaryColorLight,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //                 if (isPaidStory) PaidStar()
                //               ],
                //             ),
                //             Container(
                //                 width: 2, height: 20, color: Colors.white),
                //             InkWell(
                //               onTap: () {
                //                 if (isPaidStory) {
                //                   AppFunctions.subcribeplan(context);
                //                 } else {
                //                   if (screenNo != 3) {
                //                     flutterTts.stop();
                //                     setState(() {
                //                       playingAudio = false;
                //                       selectedWordIndex = 0;
                //                     });
                //                   }
                //                   setState(() {
                //                     screenNo = 3;
                //                   });
                //                 }
                //               },
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "Grammer",
                //                     style: TextStyle(
                //                       color: (screenNo == 3)
                //                           ? Color(0xFF162D3B)
                //                           : ThemeController.to.isDark.isTrue
                //                               ? AppConst.colorWhite
                //                               : Theme.of(context)
                //                                   .primaryColorLight,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   if (isPaidStory) PaidStar()
                //                 ],
                //               ),
                //             ),
                //           ]),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: screenNo == 0
                      ? StoryDetails(story, isPaidStory)
                      : screenNo == 1
                          ? StoryQuiz(questions)
                          : screenNo == 2
                              ? KeyWords(keywords, flutterTts)
                              : screenNo == 3
                                  ? Grammer(grammer)
                                  : Container(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///------Pause  / Play Button
                    //---- this will be shown when reading is continue
                    playingAudio
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: ThemeController.to.isDark.isTrue
                                  ? AppConst.colorBlack
                                  : const Color(0xff00ACC4),
                              radius: 20,
                              child: IconButton(
                                icon: Icon(
                                    pauseAudio ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white),
                                onPressed: (screenNo != 0)
                                    ? () {
                                        AppFunctions.showSnackBar("Info",
                                            "Open Story Tab to Play Story");
                                      }
                                    : () async {
                                        if (pauseAudio) {
                                          //   ///----if audio is playing then just stop it

                                          flutterTts.stop();
                                          setState(() {
                                            pauseAudio = !pauseAudio;
                                          });
                                        } else {
                                          ///----- on resume functionality will be added here

                                          setState(() {
                                            pauseAudio = !pauseAudio;
                                          });

                                          ///----- on resume functionality will be added here
                                          await flutterTts.setLanguage("de");
                                          await flutterTts.setQueueMode(1);
                                          await flutterTts
                                              .awaitSpeakCompletion(true);

                                          ///-----Replace the Previous Full Description to Latest Description read so far
                                          // await flutterTts
                                          //     .speak(textGerman);
                                          print(storyDetailsControllers
                                              .selectedWordIndex.value);

                                          await flutterTts.speak(
                                              storyDetailsControllers
                                                  .getNewStringtoPlay());

                                          flutterTts.setProgressHandler(
                                              (String text, int startOffset,
                                                  int endOffset, String word) {
                                            log("$startOffset $endOffset $word");
                                            storyDetailsControllers
                                                .setPlayingIndex(word);
                                          });

                                          flutterTts.setCancelHandler(() {
                                            // storyDetailsControllers
                                            //     .resetDataAfterRead();
                                          });
                                          flutterTts.setCompletionHandler(() {
                                            flutterTts.stop();
                                            storyDetailsControllers
                                                .resetDataAfterRead();
                                            setState(() {
                                              playingAudio = false;
                                            });
                                          });
                                        }
                                      },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),

                    ///---------Play / Restart Button

                    Visibility(
                      visible: screenNo == 0,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ThemeController.to.isDark.isTrue
                                ? AppConst.colorBlack
                                : const Color(0xff00ACC4),
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                  playingAudio ? Icons.stop : Icons.play_arrow,
                                  color: Colors.white),
                              onPressed: (screenNo != 0)
                                  ? () {
                                      AppFunctions.showSnackBar("Info",
                                          "Open Story Tab to Play Story");
                                    }
                                  : () async {
                                      if (isPaidStory) {
                                        AppFunctions.subcribeplan(context);
                                      } else {
                                        if (playingAudio) {
                                          flutterTts.stop();
                                          storyDetailsControllers
                                              .resetDataAfterRead();
                                          setState(() {
                                            playingAudio = false;
                                            selectedWordIndex = 0;
                                          });
                                        } else {
                                          await flutterTts.setLanguage("de");
                                          await flutterTts.setQueueMode(1);
                                          await flutterTts
                                              .awaitSpeakCompletion(true);
                                          await flutterTts.speak(textGerman);
                                          flutterTts.setProgressHandler(
                                              (String text, int startOffset,
                                                  int endOffset, String word) {
                                            print(
                                                "$startOffset $endOffset $word");
                                            storyDetailsControllers
                                                .setPlayingIndex(word);
                                          });

                                          setState(() {
                                            selectedWordIndex = 0;
                                            playingAudio = true;
                                            pauseAudio = true;
                                          });
                                          flutterTts.setCancelHandler(() {});
                                          flutterTts.setCompletionHandler(() {
                                            flutterTts.stop();
                                            storyDetailsControllers
                                                .resetDataAfterRead();
                                            setState(() {
                                              playingAudio = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                            ),
                          ),
                          if (isPaidStory)
                            const Positioned(
                              child: PaidStar(),
                              top: 0,
                              right: 0,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    //------Speed Button
                    Visibility(
                      visible: screenNo == 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeController.to.isDark.isTrue
                                ? AppConst.colorBlack
                                : const Color(0xff58B9B3),
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                          icon: Text(
                            speed + "x".toUpperCase(),
                            style: TextStyle(
                                color: ThemeController.to.isDark.isTrue
                                    ? AppConst.colorWhite
                                    : Theme.of(context).primaryColorLight,
                                fontSize: 14,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (speed == "0.5") {
                              await flutterTts.stop();
                              await flutterTts.setSpeechRate(0.35);
                              setState(() {
                                speed = "0.7";
                              });
                              playAudioOnSpeedChange();
                            } else if (speed == "0.7") {
                              await flutterTts.stop();
                              flutterTts.setSpeechRate(0.5);
                              setState(() {
                                speed = "1";
                              });
                              playAudioOnSpeedChange();
                            } else if (speed == "1") {
                              await flutterTts.stop();

                              flutterTts.setSpeechRate(0.7);
                              setState(() {
                                speed = "1.5";
                              });
                              playAudioOnSpeedChange();
                            } else if (speed == "1.5") {
                              await flutterTts.stop();

                              flutterTts.setSpeechRate(1.0);
                              setState(() {
                                speed = "2";
                              });
                              playAudioOnSpeedChange();
                            } else if (speed == "2") {
                              await flutterTts.stop();

                              flutterTts.setSpeechRate(0.25);
                              setState(() {
                                speed = "0.5";
                              });
                              playAudioOnSpeedChange();
                            } else {
                              await flutterTts.stop();

                              setState(() {
                                flutterTts.setSpeechRate(0.5);
                                speed = "1";
                              });
                              playAudioOnSpeedChange();
                            }
                            // flutterTts.setSpeechRate(!is1x ? 0.5 : 1.0);

                            // setState(() {
                            //   is1x = !is1x;
                            // });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isPaidStory)
              Positioned(
                bottom: Get.height * 0.23,
                left: 50,
                child: SizedBox(
                  width: Get.width - 100,
                  child: CustomButton(
                    text: "Read More",
                    onPressed: () async {
                      AppFunctions.subcribeplan(context);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
