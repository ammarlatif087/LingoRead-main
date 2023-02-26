import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lingoread/Controllers/Theme/favcontroller.dart';
import 'package:lingoread/Controllers/Theme/homecontroller.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Routes/routes_names.dart';
import '../../Utils/constants.dart';
import '../text_widget_heading.dart';

class Story extends StatefulWidget {
  const Story(this.story, this.context, this.favController,
      {Key? key, this.isFavScreen = false})
      : super(key: key);
  final dynamic story;
  final BuildContext context;
  final FavController favController;
  final bool isFavScreen;

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  void initState() {
    super.initState();

    getUserId();
    setData();
    setState(() {
      if (widget.isFavScreen) {
        isFav = true;
      } else {
        if (FavController.to.checkIfAddedtoFav(widget.story["id"]) > -1) {
          isFav = true;
        } else {
          isFav = false;
        }
      }
      // isFav = (widget.favController.listFavIDs
      //         .contains(widget.story["id"].toString()))
      //     ? true
      //     : false;
    });
  }

  setData() {
    try {
      setState(() {
        date = DateFormat("MMM dd, yyyy")
            .format(DateTime.parse(widget.story["created_on"].toString()));
      });
    } catch (e) {
      setState(() {
        date = DateFormat("MMM dd, yyyy").format(DateTime.now());
      });
    }
  }

  String date = "";
  FavController favController = Get.put(FavController());

  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userIdTemp = prefs.getString('UserId');
    setState(() {
      userId = userIdTemp.toString();
    });
  }

  String userId = "";

  List list = [];
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: getProportionateScreenHeight(265),
        margin: EdgeInsets.symmetric(
          vertical: AppConst.padding * 0.25,
          horizontal: AppConst.padding * 0.5,
        ),
        // padding: EdgeInsets.all(AppConst.padding * 0.5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5A6CEA).withOpacity(0.2),
              // offset: const Offset(
              //   5.0,
              //   5.0,
              // ),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            const BoxShadow(
              color: Colors.white,
              // offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          image: DecorationImage(
              image: NetworkImage(widget.story["image"].contains("http")
                  ? widget.story["image"]
                  : (AppConst.imagebaseurl + widget.story["image"])),
              fit: BoxFit.cover),
          //color: Colors.green,
          color: ThemeController.to.isDark.isTrue
              ? Theme.of(context).colorScheme.primary
              : AppConst.light_textColor_gw,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //   color: Theme.of(context).primaryColorLight,
          //   width: 1.5,
          // ),
        ),
        child: InkWell(
          onTap: () {
            HomeController.to.setFilter(false);

            Get.toNamed(Routes.stories_page, arguments: widget.story);
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: getProportionateScreenHeight(87),
                  //  width: getProportionateScreenWidth(320),
                  decoration: BoxDecoration(
                    color: const Color(0XFF18A5D3).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidgetHeading(
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlignment: TextAlign.left,
                          titleHeading: widget.story["title"].toString(),
                          textStyle: GoogleFonts.sora(
                            textStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(15),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(8),
                        ),
                        TextWidgetHeading(
                          textAlignment: TextAlign.left,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          titleHeading: widget.story["description"].toString(),
                          textStyle: GoogleFonts.sora(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                    onTap: () {},
                    child: const Icon(Icons.check_circle, color: kButtonColor)),
              ),
              Positioned(
                top: 10,
                right: 50,
                child: InkWell(
                  onTap: () {
                    if (favController.checkIfAddedtoFav(
                            (widget.story ?? {})["id"] ?? "0") ==
                        -1) {
                      favController.addtoFav((widget.story ?? {})["id"] ?? "",
                          isFavScreen: true);
                    } else {
                      favController.removeFromFav(
                          (widget.story ?? {})["id"] ?? "",
                          isFavScreen: true);
                    }
                  },
                  child: Icon(
                    favController.checkIfAddedtoFav(
                                (widget.story ?? {})["id"] ?? "0") ==
                            -1
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: favController.checkIfAddedtoFav(
                                (widget.story ?? {})["id"] ?? "0") ==
                            -1
                        ? const Color(0XFFBEC3D0)
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
