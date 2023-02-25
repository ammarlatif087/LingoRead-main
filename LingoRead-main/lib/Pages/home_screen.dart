import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/learnedStories.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Controllers/Theme/traningKeywords.dart';
import 'package:lingoread/Services/postRequests.dart';
import 'package:lingoread/Widgets/Drawer/custome_drawer.dart';
import 'package:lingoread/Widgets/Header/CustomerHeader.dart';
import 'package:lingoread/Widgets/Home/story.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Shimmers/shimmer_stories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/Theme/favcontroller.dart';
import '../Controllers/Theme/homecontroller.dart';
import '../Controllers/Theme/levels_controllers.dart';
import '../Utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    start();
    // print(storiesControllers.listStories);
  }

  List listBanners = [];

  start() async {
    TrainingKeyword.to.loadKeywords();
    LearnedStories.to.loadLearnedStories();
    LevelsControllers.to.loadLevels();
    FavController.to.loadFav();
    final prefs = await SharedPreferences.getInstance();

    String? level = prefs.getString("level");

    if (level != null) {
      setState(() {
        selectedLevel = level;
      });
      loadStories(level);
    }

    String? banners = prefs.getString("Banners");

    if (banners != null) {
      try {
        setState(() {
          listBanners = jsonDecode(banners);
          print(listBanners);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  bool showloadMore = false;

  bool loadingStories = false;
  loadStories(String level) {
    setState(() {
      loadingStories = false;
      showloadMore = false;
    });

    APIsCallPost.submitRequestWithAuth(
        "", {"action": "storiesbylevel", "filter_title": level}).then((value) {
      if (value.statusCode == 200) {
        List list = value.data;
        if (list.length > 5) {
          setState(() {
            showloadMore = true;
          });
        }
        homeController.setListStories(list, storyType, false);
      } else {
        homeController.setListStories([], storyType, false);
      }
      setState(() {
        loadingStories = true;
      });
      // Loader.hide();
    });
  }

  String selectedLevel = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.put(HomeController());
  final TrainingKeyword traingKeywords = Get.put(TrainingKeyword());
  final LearnedStories learnedStories = Get.put(LearnedStories());
  final LevelsControllers levelsControllers = Get.put(LevelsControllers());

  FavController favController = Get.put(FavController());

  bool showFilter = false;
  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
        child: Scaffold(
      key: _scaffoldkey,
      drawer: CustomDrawer(context),
      backgroundColor: Colors.redAccent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              //SizedBox(height: AppConst.padding * 3),
              Obx(
                () => CustomerHeader(
                  image: ThemeController.to.isDark.isTrue
                      ? "assets/images/icon_menu_white.png"
                      : "assets/images/icon_menu.png",
                  title: "Stories",
                  onPressed: () {
                    HomeController.to.setFilter(false);
                    _scaffoldkey.currentState!.openDrawer();
                  },
                ),
              ),
              SizedBox(height: AppConst.padding * 0.7),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConst.padding,
                        ),
                        sliver: const SliverToBoxAdapter(
                            // child: Column(
                            //   children: [
                            //     // ShimmerViewBanners()
                            //     listBanners.isEmpty
                            //         ? ShimmerViewBanners()
                            //         : CarasoleWidget(listBanners),
                            //   ],
                            // ),
                            )),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConst.padding,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Card(
                          child: Row(
                            //  alignment: WrapAlignment.center,
                            children: LevelsControllers.to.listLevels.value
                                .map((e) => Container(
                                      color: Colors.green,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: AppConst.padding * 0.5,
                                          vertical: AppConst.padding * 0.4),
                                      child: InkWell(
                                        onTap: () async {
                                          if (selectedLevel !=
                                              (e["title"] ?? "")) {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            await prefs.setString(
                                                "level", e["title"] ?? "");
                                            setState(() {
                                              selectedLevel = e["title"] ?? "";
                                            });
                                            HomeController.to.setFilter(false);

                                            loadStories(e["title"] ?? "");
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets
                                                      .symmetric(
                                                  // horizontal:
                                                  //     getProportionateScreenHeight(
                                                  //   26,
                                                  // ),
                                                  ),
                                              decoration: BoxDecoration(
                                                color: (selectedLevel ==
                                                        (e["title"] ?? ""))
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : ThemeController
                                                            .to.isDark.isTrue
                                                        ? AppConst
                                                            .dark_colorPrimaryDark
                                                        : const Color(
                                                            0xff07595F),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        //  vertical: 6,
                                                        //horizontal: 20,
                                                        ),
                                                child: Text(
                                                  e["title"] ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(
                      height: AppConst.padding * 0.5,
                    )),
                    loadingStories
                        ? Obx(
                            () => homeController.listStories.isNotEmpty
                                ?
                                // CarasolContainer(
                                //     //  imagePath: listBanners[0]["image"],
                                //     date: listBanners[0]["created_on"],
                                //     title: listBanners[0]["title"],
                                //     description: listBanners[0]["description"])
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        dynamic story =
                                            homeController.listStories[index];
                                        return Story(
                                            story, context, favController);
                                      },
                                      childCount: showloadMore
                                          ? 4
                                          : homeController.listStories.length,
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Center(
                                      child: Text(
                                        "No stories found",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily),
                                      ),
                                    ),
                                  ),
                          )
                        : const SliverToBoxAdapter(
                            child: ShimmerStories(),
                          ),
                    if (showloadMore)
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showloadMore = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Text(
                                      "Load More",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  String storyType = "All";
}
