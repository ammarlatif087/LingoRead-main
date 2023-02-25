import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/homecontroller.dart';
import 'package:lingoread/Controllers/Theme/levels_controllers.dart';
import 'package:lingoread/Controllers/Theme/stories_controllers.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Utils/app_funtions.dart';

import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/app_constants.dart';
import '../Utils/constants.dart';
import '../Utils/size_config.dart';
import '../Widgets/text_widget_heading.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    APIsCallPost.submitRequestWithAuth("", {"action": "alllevels"})
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          loadingLevels = true;
        });
        print(value.data);
        List list = value.data;
        levelsControllers.setList(list);
      } else if (value.statusCode == 401) {
        AppFunctions.showSnackBar("Authorization", "Authorization Denied");
      } else {
        AppFunctions.showSnackBar("Error", "Something went wrong");
      }
    });
    final prefs = await SharedPreferences.getInstance();

    String? value = prefs.getString("level");
    if (value != null) {
      setState(() {
        selectedLevel = value;
      });
    }
  }

  bool loadingLevels = false;

  final LevelsControllers levelsControllers = Get.put(LevelsControllers());
  final StoriesControllers storiesControllers = Get.put(StoriesControllers());
  final HomeController homeController = Get.put(HomeController());

  String selectedLevel = "";
  List<String> imagePath = [
    'assets/images/begginer.png',
    'assets/images/basic.png',
    'assets/images/medium.png',
    'assets/images/advanced.png',
    'assets/images/challenge.png',
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.amber,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: getProportionateScreenHeight(72)),
            Center(
              child: TextWidgetHeading(
                titleHeading: 'Choose Your Level',
                textStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    //letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                    color: kTextColorSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppConst.padding * 2),
            Expanded(
              child: loadingLevels
                  ? Obx((() => Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: getProportionateScreenWidth(8),
                      // runAlignment: WrapAlignment.center,
                      runSpacing: getProportionateScreenHeight(20),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // textDirection: TextDirection.rtl,
                      verticalDirection: VerticalDirection.down,
                      children: List.generate(5, (index) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              selectedLevel = levelsControllers
                                  .listLevels[index]["title"]
                                  .toString();
                              print(selectedLevel);
                            });
                            print(levelsControllers.selectedLevel);
                            levelsControllers.setSelectedLevel(levelsControllers
                                .listLevels[index]["title"]
                                .toString());
                            final prefs = await SharedPreferences.getInstance();

                            await prefs.setString("level", selectedLevel);
                            Get.toNamed(Routes.bottomNavBar);
                            // loadStories(selectedLevel);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                imagePath[index],
                                height: getProportionateScreenHeight(150),
                                width: getProportionateScreenWidth(177),
                              ),
                              TextWidgetHeading(
                                titleHeading:
                                    "${levelsControllers.listLevels[index]["title"] + ":" + "${levelsControllers.listLevels[index]["description"]}"}",
                                textStyle: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    //letterSpacing: 1,
                                    fontWeight: FontWeight.w600,
                                    color: kTextColorSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }))))
                  : Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
            ),
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // Expanded(
            //   child: loadingLevels
            //       ? Obx(
            //           () => ListView.builder(
            //               itemCount: levelsControllers.listLevels.length,
            //               itemBuilder: ((context, index) {
            //                 return Container(
            //                   color: Colors.yellow,
            //                   margin: EdgeInsets.symmetric(
            //                       vertical: AppConst.padding * 0.3),
            //                   child: InkWell(
            //                     onTap: () async {
            //                       setState(() {
            //                         selectedLevel = levelsControllers
            //                             .listLevels[index]["title"]
            //                             .toString();
            //                       });
            //                       print(levelsControllers.selectedLevel);
            //                       levelsControllers.setSelectedLevel(
            //                           levelsControllers.listLevels[index]
            //                                   ["title"]
            //                               .toString());
            //                       final prefs =
            //                           await SharedPreferences.getInstance();

            //                       await prefs.setString(
            //                           "level", selectedLevel);
            //                       Get.toNamed(Routes.homeScreen);
            //                       // loadStories(selectedLevel);
            //                     },
            //                     child: Obx(
            //                       () => Container(
            //                           padding: EdgeInsets.symmetric(
            //                               horizontal:
            //                                   AppConst.padding * 0.5),
            //                           decoration: BoxDecoration(
            //                             color: levelsControllers
            //                                             .listLevels[index]
            //                                         ["title"] ==
            //                                     selectedLevel
            //                                 ? Theme.of(context).primaryColor
            //                                 : Colors.transparent,
            //                             borderRadius: BorderRadius.circular(
            //                                 AppConst.padding * 0.5),
            //                             border: Border.all(
            //                               color: Colors.red,
            //                               width: 2,
            //                             ),
            //                           ),
            //                           child: Row(
            //                             children: [
            //                               Text(
            //                                 "${levelsControllers.listLevels[index]["title"]}",
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .headline2!
            //                                     .copyWith(
            //                                         fontSize: 24,
            //                                         fontFamily: GoogleFonts
            //                                                 .poppins()
            //                                             .fontFamily),
            //                               ),
            //                               Expanded(
            //                                 child: Text(
            //                                   "${levelsControllers.listLevels[index]["description"]}"
            //                                       .toUpperCase(),
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .headline2!
            //                                       .copyWith(
            //                                           fontSize: 14,
            //                                           fontFamily:
            //                                               GoogleFonts
            //                                                       .poppins()
            //                                                   .fontFamily,
            //                                           color: (selectedLevel ==
            //                                                   levelsControllers
            //                                                               .listLevels[
            //                                                           index]
            //                                                       ["title"])
            //                                               ? Theme.of(
            //                                                       context)
            //                                                   .colorScheme
            //                                                   .onPrimary
            //                                               : ThemeController
            //                                                       .to
            //                                                       .isDark
            //                                                       .isTrue
            //                                                   ? const Color(
            //                                                       0xff35657E)
            //                                                   : const Color(
            //                                                       0xff00C2D6)),
            //                                   textAlign: TextAlign.center,
            //                                 ),
            //                               ),
            //                               Obx(
            //                                 () => Radio(
            //                                     activeColor:
            //                                         Theme.of(context)
            //                                             .colorScheme
            //                                             .onPrimary,
            //                                     fillColor: MaterialStateColor
            //                                         .resolveWith((states) =>
            //                                             ThemeController
            //                                                     .to
            //                                                     .isDark
            //                                                     .isTrue
            //                                                 ? const Color(
            //                                                     0xff254E64)
            //                                                 : Theme.of(
            //                                                         context)
            //                                                     .colorScheme
            //                                                     .onPrimary),
            //                                     overlayColor:   ,

            //                                     value:
            //                                         "${levelsControllers.listLevels[index]["title"]}",
            //                                     groupValue: selectedLevel,
            //                                     onChanged: (value) {
            //                                       // print(value);
            //                                       // levelsControllers.setSelectedLevel(
            //                                       //     value.toString());
            //                                     }),
            //                               )
            //                             ],
            //                           )),
            //                     ),
            //                   ),
            //                 );
            //               })),
            //         )
            //       : Column(
            //           children: const [
            //             CircularProgressIndicator(),
            //           ],
            //         ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(34),
                  right: getProportionateScreenWidth(36)),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  //        print(levelsControllers.selectedLevel);
                  //                   levelsControllers.setSelectedLevel(
                  //                       levelsControllers.listLevels[index]
                  //                               ["title"]
                  //                           .toString());
                  //                   final prefs =
                  //                       await SharedPreferences.getInstance();

                  //                   await prefs.setString(
                  //                       "level", selectedLevel);
                  //                   Get.toNamed(Routes.homeScreen);
                  //                   // loadStories(selectedLevel);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidgetHeading(
                      titleHeading: 'Try Story',
                      textStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          // letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: kButtonColor,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: kButtonColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
