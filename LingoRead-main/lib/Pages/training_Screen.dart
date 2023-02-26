import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/traningKeywords.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:lingoread/Utils/app_funtions.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Widgets/custom_app_bar.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import 'package:lingoread/Widgets/training_screen_widget.dart';
import 'package:lingoread/Utils/app_constants.dart';

import '../Controllers/Theme/themecontroller.dart';
import '../Utils/size_config.dart';
import '../Widgets/Drawer/custome_drawer.dart';
import '../Widgets/Main/custom_container.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  @override
  void initState() {
    // TODO: implement initState
    TrainingKeyword.to.loadKeywords();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List keywordsShow = [];
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      key: _scaffoldkey,
      drawer: CustomDrawer(context),
      body: Column(
        children: [
          // SizedBox(height: AppConst.padding * 3),
          // CustomerHeader(
          //   title: "Training",
          //   image: ThemeController.to.isDark.isTrue
          //       ? "assets/images/icon_menu_white.png"
          //       : 'assets/images/icon_menu.png',
          //   titleimage: ThemeController.to.isDark.isTrue
          //       ? 'assets/images/training_icon_dark.png'
          //       : 'assets/images/icon_training.png',
          //   onPressed: () {
          //     _scaffoldkey.currentState!.openDrawer();

          //     // Get.back();
          //   },
          // ),
          CustomAppBar(
            appBarTitle: "Train",
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(12)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0XFF5A6CEA).withOpacity(0.1),
                        offset: const Offset(
                          2.0,
                          3.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: const Color(0XFF5A6CEA).withOpacity(0.1),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(16)),
                    child: Center(
                      child: TextWidgetHeading(
                        textAlignment: TextAlign.center,
                        titleHeading: 'Review',
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
                  ),
                ),

                // Obx(
                //   () => TrainingKeyword.to.listTrainingKeyword.length > 0
                //       ? ListView.builder(
                //           itemBuilder: (context, index) {
                //             return TrainingScreenWidget(TrainingKeyword
                //                 .to.listTrainingKeyword[index]);
                //           },
                //           itemCount: (TrainingKeyword
                //                       .to.listTrainingKeyword.length >
                //                   4)
                //               ? 2
                //               : TrainingKeyword.to.listTrainingKeyword.length,
                //           shrinkWrap: true,
                //           physics: const NeverScrollableScrollPhysics(),
                //         )
                //       : Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             "No Keywords Added",
                //             style: Get.textTheme.headline3,
                //           ),
                //         ),
                // ),

                // if ((TrainingKeyword.to.listTrainingKeyword.length > 4))
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //           "and More ${TrainingKeyword.to.listTrainingKeyword.length - 4} Keywords",
                //           style: TextStyle(color: Colors.black)),
                //     ],
                //   ),

                // const TrainingScreenWidget(),
                // const SizedBox(
                //   height: 10,
                // ),
                // TrainingScreenWidget(),
                // SizedBox(
                //   height: 10,
                // ),
                // TrainingScreenWidget(),
                // SizedBox(
                //   height: 10,
                // ),
                // TrainingScreenWidget(),
                // SizedBox(
                //   height: AppConst.padding * 1,
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(47),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TrainingReviewWidget(
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0xffF6EEE5),
                          TrainingKeyword.to.totalHardKeywords.value,
                          'Hard'),
                      Obx(
                        () => TrainingReviewWidget(
                            ThemeController.to.isDark.isTrue
                                ? AppConst.dark_colorPrimaryDark
                                : const Color(0xffF6E5E5),
                            TrainingKeyword.to.totalOkKeywords.value,
                            'Okay'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Obx(
                //   () => TrainingReviewWidget(
                //       ThemeController.to.isDark.isTrue
                //           ? AppConst.dark_colorPrimaryDark
                //           : const Color(0xff22D269),
                //       TrainingKeyword.to.totalOkKeywords.value,
                //       'Okay'),
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(23),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TrainingReviewWidget(
                          ThemeController.to.isDark.isTrue
                              ? AppConst.dark_colorPrimaryDark
                              : const Color(0xffE0E0F1),
                          TrainingKeyword.to.totalEasyKeywords.value,
                          'Easy'),
                      Obx(
                        () => TrainingReviewWidget(
                            ThemeController.to.isDark.isTrue
                                ? AppConst.dark_colorPrimaryDark
                                : const Color(0xffECE0F1),
                            TrainingKeyword.to.totalCompletedKeywords.value,
                            'Done'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),

                Container(
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorPrimaryLightv3_1BA0C1
                            : const Color(0xffffffff)),
                    child: InkWell(
                      onTap: () {
                        if (TrainingKeyword.to.listTrainingKeyword.isNotEmpty) {
                          Get.toNamed(
                            Routes.total_words,
                          );
                        } else {
                          AppFunctions.showSnackBar(
                              "Message", "No Keywords Added to Play");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: ThemeController.to.isDark.isTrue
                                ? const Color(0xffffffff)
                                : const Color(0xff00767D),
                            child: ThemeController.to.isDark.isTrue
                                ? const Image(
                                    image: AssetImage(
                                        'assets/images/iconTrainingDark.png'))
                                : const Image(
                                    image: AssetImage(
                                        'assets/images/iconTraining.png')),
                          ),
                          // Icon(Icons.card_membership,
                          //     color: ThemeController.to.isDark.isTrue
                          //         ? AppConst.colorWhite
                          //         : AppConst.colorPrimaryDark),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Play in Card',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: ThemeController.to.isDark.isTrue
                                        ? AppConst.colorWhite
                                        : const Color(0xff00ACC4),
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
