import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/storyDetails_controller.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import 'package:translator/translator.dart';

import '../../Controllers/Theme/favcontroller.dart';

class StoryDetails extends StatelessWidget {
  StoryDetails(this.story, this.isPaidStory, {Key? key}) : super(key: key);
  final dynamic story;

  final bool isPaidStory;

  FavController favController = Get.put(FavController());
  StoryDetailsControllers storyDetailsControllers =
      Get.put(StoryDetailsControllers());

  String storyId = "-1";
  int screenNo = 0;
  String textGerman = "";

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
  //   playAudioOnSpeedChange() async {
  //   await flutterTts.setLanguage("de");
  //   await flutterTts.setQueueMode(1);
  //   await flutterTts.awaitSpeakCompletion(true);
  //   await flutterTts.speak(storyDetailsControllers.getNewStringtoPlay());
  //   flutterTts.setProgressHandler(
  //       (String text, int startOffset, int endOffset, String word) {
  //     log("$startOffset $endOffset $word");
  //     storyDetailsControllers.setPlayingIndex(word);
  //   });

  //   flutterTts.setCancelHandler(() {
  //     // storyDetailsControllers
  //     //     .resetDataAfterRead();
  //   });
  //   flutterTts.setCompletionHandler(() {
  //     flutterTts.stop();
  //     storyDetailsControllers.resetDataAfterRead();
  //     setState(() {
  //       playingAudio = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(6),
          horizontal: getProportionateScreenWidth(10)),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(AppConst.padding * 1,
                  AppConst.padding, AppConst.padding * 1, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextWidgetHeading(
                      overflow: TextOverflow.ellipsis,
                      textAlignment: TextAlign.left,
                      titleHeading: (story ?? {})["title"] ?? "",
                      textStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          // letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.compare_arrows_rounded,
                          color: Color(0XFFBEC3D0),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(17),
                        ),
                        InkWell(
                          onTap: () {
                            if (favController.checkIfAddedtoFav(
                                    (story ?? {})["id"] ?? "0") ==
                                -1) {
                              favController.addtoFav((story ?? {})["id"] ?? "",
                                  isFavScreen: true);
                            } else {
                              favController.removeFromFav(
                                  (story ?? {})["id"] ?? "",
                                  isFavScreen: true);
                            }
                          },
                          child: Icon(
                            favController.checkIfAddedtoFav(
                                        (story ?? {})["id"] ?? "0") ==
                                    -1
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: favController.checkIfAddedtoFav(
                                        (story ?? {})["id"] ?? "0") ==
                                    -1
                                ? const Color(0XFFBEC3D0)
                                : Colors.red,
                          ),
                        )
                        // : const Icon(
                        //     Icons.favorite,
                        //     color: Colors.red,
                        //   ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppConst.padding * 1.3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  // padding: EdgeInsets.fromLTRB(
                  //     AppConst.padding, AppConst.padding, AppConst.padding, 0),
                  child: Obx(
                    () => SingleChildScrollView(
                      child: Wrap(
                        spacing: -6.1,
                        runSpacing: 2.1,
                        children: storyDetailsControllers.listStoryDisWords
                            .asMap()
                            .entries
                            .map((e) => InkWell(
                                  onTap: () async {
                                    if (isPaidStory) {
                                      AppFunctions.subcribeplan(context);
                                    } else {
                                      storyDetailsControllers
                                          .setWordForTranslation(
                                              e.key, e.value);
                                    }

                                    // setState(() {
                                    //   selectedWordIndex = e.key;
                                    //   readingword = e.value;
                                    // });
                                    // Translation translated =
                                    //     await translator.translate(
                                    //         e.value,
                                    //         from: 'de',
                                    //         to: 'en');
                                    // setState(() {
                                    //   wordToTranslate = e.value;
                                    //   translatedWord = translated.text;
                                    // });
                                  },
                                  child: ImageFiltered(
                                    imageFilter: (e.key > 15 && isPaidStory)
                                        ? ImageFilter.blur(
                                            sigmaX: 2.0, sigmaY: 2.0)
                                        : ImageFilter.blur(
                                            sigmaX: 0.0, sigmaY: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: storyDetailsControllers
                                                      .selectedWordIndex
                                                      .value ==
                                                  e.key
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: TextWidgetHeading(
                                        overflow: TextOverflow.ellipsis,
                                        textAlignment: TextAlign.left,
                                        titleHeading: e.value,
                                        textStyle: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
                                            // letterSpacing: 1.3,
                                            fontWeight: FontWeight.w400,

                                            color: kTextColorSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  //  Text(
                  //   (story ?? {})["description"] ?? "",
                  //   textAlign: TextAlign.left,
                  //   style: Theme.of(context).textTheme.headline5!.copyWith(
                  //       fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 14),
                  // ),
                ),
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
            //               backgroundColor: ThemeController.to.isDark.isTrue
            //                   ? AppConst.colorBlack
            //                   : const Color(0xff00ACC4),
            //               radius: 20,
            //               child: IconButton(
            //                 icon: Icon(
            //                     pauseAudio ? Icons.pause : Icons.play_arrow,
            //                     color: Colors.white),
            //                 onPressed: (screenNo != 0)
            //                     ? () {
            //                         AppFunctions.showSnackBar(
            //                             "Info", "Open Story Tab to Play Story");
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
            //                           await flutterTts.setLanguage("de");
            //                           await flutterTts.setQueueMode(1);
            //                           await flutterTts.awaitSpeakCompletion(true);

            //                           ///-----Replace the Previous Full Description to Latest Description read so far
            //                           // await flutterTts
            //                           //     .speak(textGerman);
            //                           print(storyDetailsControllers
            //                               .selectedWordIndex.value);

            //                           await flutterTts.speak(
            //                               storyDetailsControllers
            //                                   .getNewStringtoPlay());

            //                           flutterTts.setProgressHandler((String text,
            //                               int startOffset,
            //                               int endOffset,
            //                               String word) {
            //                             log("$startOffset $endOffset $word");
            //                             storyDetailsControllers
            //                                 .setPlayingIndex(word);
            //                           });

            //                           flutterTts.setCancelHandler(() {
            //                             // storyDetailsControllers
            //                             //     .resetDataAfterRead();
            //                           });
            //                           flutterTts.setCompletionHandler(() {
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
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: ThemeController.to.isDark.isTrue
            //               ? AppConst.colorBlack
            //               : const Color(0xff00ACC4),
            //           radius: 20,
            //           child: IconButton(
            //             icon: Icon(playingAudio ? Icons.stop : Icons.play_arrow,
            //                 color: Colors.white),
            //             onPressed: (screenNo != 0)
            //                 ? () {
            //                     AppFunctions.showSnackBar(
            //                         "Info", "Open Story Tab to Play Story");
            //                   }
            //                 : () async {
            //                     if (isPaidStory) {
            //                       AppFunctions.subcribeplan(context);
            //                     } else {
            //                       if (playingAudio) {
            //                         flutterTts.stop();
            //                         storyDetailsControllers.resetDataAfterRead();
            //                         setState(() {
            //                           playingAudio = false;
            //                           selectedWordIndex = 0;
            //                         });
            //                       } else {
            //                         await flutterTts.setLanguage("de");
            //                         await flutterTts.setQueueMode(1);
            //                         await flutterTts.awaitSpeakCompletion(true);
            //                         await flutterTts.speak(textGerman);
            //                         flutterTts.setProgressHandler((String text,
            //                             int startOffset,
            //                             int endOffset,
            //                             String word) {
            //                           print("$startOffset $endOffset $word");
            //                           storyDetailsControllers
            //                               .setPlayingIndex(word);
            //                         });

            //                         setState(() {
            //                           selectedWordIndex = 0;
            //                           playingAudio = true;
            //                           pauseAudio = true;
            //                         });
            //                         flutterTts.setCancelHandler(() {});
            //                         flutterTts.setCompletionHandler(() {
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

            //     //------Speed Button
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
            //                   : Theme.of(context).primaryColorLight,
            //               fontSize: 14,
            //               fontFamily: GoogleFonts.dmSans().fontFamily,
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
            //     ),
            //   ],
            // ),
            // Container(
            //   color: Colors.amber,
            //   height: 50,
            //   width: 50,
            // )
          ],
        ),
      ),
    );
  }
}
