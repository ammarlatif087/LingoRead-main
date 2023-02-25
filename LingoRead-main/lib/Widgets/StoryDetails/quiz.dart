import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/Buttons/button_main.dart';

class StoryQuiz extends StatefulWidget {
  const StoryQuiz(this.listQuestions, {Key? key}) : super(key: key);
  final List listQuestions;
  @override
  State<StoryQuiz> createState() => _StoryQuizState();
}

class _StoryQuizState extends State<StoryQuiz> {
  @override
  void initState() {
    super.initState();
    setIntials();
  }

  setIntials() {
    List listQuestion = [];

    for (var element in widget.listQuestions) {
      List answers = [];
      answers.add({
        "key": "Answer1",
        "answer": (element["answer_option"] ?? {})["Answer1"] ?? "",
        "istrue": ""
      });
      answers.add({
        "key": "Answer2",
        "answer": (element["answer_option"] ?? {})["Answer2"] ?? "",
        "istrue": ""
      });
      answers.add({
        "key": "Answer3",
        "answer": (element["answer_option"] ?? {})["Answer3"] ?? "",
        "istrue": ""
      });
      var question = {
        "id": element["id"],
        "title": element["title"],
        "type": element["type"],
        "answer_option": answers,
        "answer_index": element["answer_index"],
      };
      listQuestion.add(question);
    }
    setState(() {
      progressIncrement = 100 / widget.listQuestions.length;
      totalQuestions = widget.listQuestions.length;
      progress += 100 / widget.listQuestions.length;
      listQuestionstoDisplay = listQuestion;
    });
  }

  List listQuestionstoDisplay = [];
  int _questionIndex = 0;
  int totalQuestions = 1;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  double progress = 0;
  double progressIncrement = 0;
  List answers = [];
  questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }

      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      resetQuiz();
    }
  }

  resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;

      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (listQuestionstoDisplay.isNotEmpty)
            Center(
              child: Column(
                children: [
                  // Column(
                  //   children: const [
                  //     SizedBox(
                  //       height: 10.0,
                  //     ),
                  //   ],
                  // ),
                  if (listQuestionstoDisplay.isNotEmpty &&
                      _questionIndex < listQuestionstoDisplay.length)
                    _questionwithOpitions(
                        listQuestionstoDisplay[_questionIndex],
                        context,
                        _questionIndex),

                  endOfQuiz
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConst.padding * 1,
                            horizontal: AppConst.padding * 1,
                          ),
                          child: Text((_totalScore / totalQuestions >= 0.5)
                              ? 'Congratulations! Your final score is: $_totalScore'
                              : 'Your final score is: $_totalScore. Better luck next time!'),
                        )
                      : Padding(
                          padding: EdgeInsets.all(AppConst.padding),
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: "Submit",
                              onPressed: () async {
                                if (listQuestionstoDisplay[_questionIndex]
                                        ["answeres"] ??
                                    false) {
                                  if (_questionIndex + 1 == totalQuestions) {
                                    int total = 0;

                                    for (int i = 0;
                                        i < listQuestionstoDisplay.length;
                                        i++) {
                                      if (listQuestionstoDisplay[i]
                                              ["answer_index"] ==
                                          listQuestionstoDisplay[i]
                                              ["selectedIndex"]) {
                                        total += 1;
                                      }
                                    }

                                    setState(() {
                                      _totalScore = total;
                                      endOfQuiz = true;
                                    });
                                  } else {
                                    setState(() {
                                      _questionIndex++;
                                    });
                                  }
                                } else {
                                  AppFunctions.showSnackBar(
                                      "Error", "Question Not Answered");
                                }

                                // login();
                              },
                            ),
                          ),
                        ),
                  // SizedBox(height: 20.0),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     minimumSize: Size(double.infinity, 40.0),
                  //   ),
                  //   onPressed: () {
                  //     if (!answerWasSelected) {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         content: Text(
                  //             'Please select an answer before going to the next question'),
                  //       ));
                  //       return;
                  //     }
                  //     nextQuestion();
                  //   },
                  //   child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question'),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(20.0),
                  //   child: Text(
                  //     '${_totalScore.toString()}/${_questions.length}',
                  //     style:
                  //         TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // if (answerWasSelected && !endOfQuiz)
                  //   Container(
                  //     height: 100,
                  //     width: double.infinity,
                  //     color: correctAnswerSelected ? Colors.green : Colors.red,
                  //     child: Center(
                  //       child: Text(
                  //         correctAnswerSelected
                  //             ? 'Well done, you got it right!'
                  //             : 'Wrong :/',
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // if (endOfQuiz)
                  //   Container(
                  //     height: 100,
                  //     width: double.infinity,
                  //     color: Colors.black,
                  //     child: Center(
                  //       child: Text(
                  //         _totalScore > 2
                  //             ? 'Congratulations! Your final score is: $_totalScore'
                  //             : 'Your final score is: $_totalScore. Better luck next time!',
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: _totalScore > 4 ? Colors.green : Colors.red,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          if (listQuestionstoDisplay.isEmpty)
            Padding(
              padding: EdgeInsets.all(AppConst.padding),
              child: const Text(
                "No Quiz Available",
                style: TextStyle(color: Colors.black),
              ),
            )
        ],
      ),
    );
  }

  _questionwithOpitions(dynamic obj, BuildContext context, int qIndex) {
    List listOptions = obj['answer_option'];
    int selectedAnswer = -1;

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(10)),
      child: Container(
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConst.padding * 1,
                  vertical: getProportionateScreenHeight(6)),
              child: Text(
                obj['title'].toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontFamily: GoogleFonts.raleway().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${_questionIndex + 1} / $totalQuestions",
                    style: TextStyle(
                        color: kButtonColor,
                        fontSize: 20,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(17),
                  horizontal: getProportionateScreenHeight(17)),
              child: Wrap(children:
                      //  listOptions
                      //     .map((e) =>
                      [
                for (int i = 0; i < listOptions.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppConst.padding * 0.2,
                        vertical: AppConst.padding * 0.1),
                    child: InkWell(
                      onTap: () {
                        print("++++++++++++++");
                        setState(() {
                          listQuestionstoDisplay[qIndex]["answeres"] = true;
                          listQuestionstoDisplay[qIndex]["selectedIndex"] =
                              i.toString();

                          for (int j = 0; j < listOptions.length; j++) {
                            if (i == j) {
                              listOptions[j]["selected"] = true;
                            } else {
                              listOptions[j]["selected"] = false;
                            }
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: getProportionateScreenWidth(300),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConst.padding * 0.8,
                          vertical: AppConst.padding * 0.5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: const Color(0XFFBEC3D0)),
                            borderRadius: BorderRadius.circular(20),
                            color: (listOptions[i]["selected"] ?? false)
                                ? ThemeController.to.isDark.isTrue
                                    ? AppConst.dark_colorPrimaryDark
                                    : Theme.of(context).primaryColor
                                : const Color(0xffffffff)),
                        child: Center(
                          child: Text(
                            listOptions[i]["answer"],
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: (listOptions[i]["selected"] ?? false)
                                        ? ThemeController.to.isDark.isTrue
                                            ? AppConst
                                                .colorPrimaryLightv3_1BA0C1
                                            : Colors.white
                                        : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
              ]
                  // )
                  // .toList() as List<Widget>,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

final _questions = [
  {
    'question': 'How long is New Zealand’s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km', 'score': true},
      {'answerText': '55km', 'score': false},
      {'answerText': '90km', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael', 'score': true},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
];
