import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';
import 'package:translator/translator.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Controllers/Theme/traningKeywords.dart';
import '../Utils/app_constants.dart';

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
    if (TrainingKeyword.to.listTrainingKeyword.length > 0) {
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
    } on Exception catch (e) {
      translatedWord = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(TrainingKeyword.to.listTrainingKeyword[playingIndex].toString());
    return ThemeContainer(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.red,
            body: Stack(
              children: [
                ThemeFooter(),
                Column(
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
                                color: Color(0xffffffff),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Words',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: ThemeController.to.isDark.isTrue
                                          ? AppConst.colorPrimaryDark
                                          : Get.theme.primaryColorDark,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 4, color: Colors.white)),
                                  child: Text(
                                    TrainingKeyword
                                        .to.listTrainingKeyword.length
                                        .toString(),
                                    style: Get.textTheme.headline4,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (TrainingKeyword.to.listTrainingKeyword.length >
                                0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    // width: 150,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xffffffff)),
                                    child: Center(
                                      child: Text(
                                        TrainingKeyword
                                            .to
                                            .listTrainingKeyword[playingIndex]
                                                ["title"]
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: ThemeController
                                                        .to.isDark.isTrue
                                                    ? Colors.black
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.volume_up,
                                      color: Color(0xffffffff),
                                    ),
                                    onPressed: () {
                                      FlutterTts().speak(TrainingKeyword
                                          .to
                                          .listTrainingKeyword[playingIndex]
                                              ["title"]
                                          .toString());
                                    },
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (playingIndex > 0)
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xffffffff),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        translatedWord = "";

                                        showAnswer = false;
                                        playingIndex--;
                                      });
                                      translate(TrainingKeyword
                                          .to
                                          .listTrainingKeyword[playingIndex]
                                              ["title"]
                                          .toString());
                                    },
                                  ),
                                Expanded(child: Text("")),
                                if (playingIndex + 1 !=
                                    TrainingKeyword
                                        .to.listTrainingKeyword.length)
                                  ThemeController.to.isDark.isTrue
                                      ? Row(
                                          children: [
                                            Text('Next'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  color: Colors.white
                                                      .withOpacity(0.7)),
                                              child: IconButton(
                                                icon: Icon(
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
                                                      .listTrainingKeyword[
                                                          playingIndex]["title"]
                                                      .toString());
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xffffffff),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              translatedWord = "";
                                              showAnswer = false;
                                              playingIndex++;
                                            });
                                            translate(TrainingKeyword
                                                .to
                                                .listTrainingKeyword[
                                                    playingIndex]["title"]
                                                .toString());
                                          },
                                        ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            if (!showAnswer)
                              Center(
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                      height: 40,
                                      width: 220,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xff00ACC4),
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
                                                        fontWeight:
                                                            FontWeight.bold))),
                                      )),
                                ),
                              ),
                            if (showAnswer)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Divider(
                                    // color: Colors.black,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(translatedWord,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
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
                                      : Color(0xff0094FF), () {
                                TrainingKeyword.to.changeStatus(
                                    TrainingKeyword.to
                                            .listTrainingKeyword[playingIndex]
                                        ["keyword"],
                                    "Hard");
                              },
                                  TrainingKeyword
                                          .to.listTrainingKeyword[playingIndex]
                                      ["status"]),
                              widgetForStatusChange(
                                  "Okay",
                                  ThemeController.to.isDark.isTrue
                                      ? AppConst.dark_colorPrimaryDark
                                      : Color(0xff22D269), () {
                                TrainingKeyword.to.changeStatus(
                                    TrainingKeyword.to
                                            .listTrainingKeyword[playingIndex]
                                        ["keyword"],
                                    "Okay");
                              },
                                  TrainingKeyword
                                          .to.listTrainingKeyword[playingIndex]
                                      ["status"]),
                              widgetForStatusChange(
                                  "Easy",
                                  ThemeController.to.isDark.isTrue
                                      ? AppConst.dark_colorPrimaryDark
                                      : Color(0xffCA1A79), () {
                                TrainingKeyword.to.changeStatus(
                                    TrainingKeyword.to
                                            .listTrainingKeyword[playingIndex]
                                        ["keyword"],
                                    "Easy");
                              },
                                  TrainingKeyword
                                          .to.listTrainingKeyword[playingIndex]
                                      ["status"]),
                              widgetForStatusChange(
                                  "Done",
                                  ThemeController.to.isDark.isTrue
                                      ? AppConst.dark_colorPrimaryDark
                                      : Color(0xffD4CC0C), () {
                                TrainingKeyword.to.changeStatus(
                                    TrainingKeyword.to
                                            .listTrainingKeyword[playingIndex]
                                        ["keyword"],
                                    "Done");
                              },
                                  TrainingKeyword
                                          .to.listTrainingKeyword[playingIndex]
                                      ["status"]),
                            ],
                          ),
                        ),
                      )
                  ],
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: color,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: title == status ? color : Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(title,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: ThemeController.to.isDark.isTrue
                        ? AppConst.dark_colorPrimaryDark
                        : AppConst.colorWhite)),
          ],
        ),
      ),
    );
  }
}
