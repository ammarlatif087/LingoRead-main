import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lingoread/Controllers/Theme/favcontroller.dart';
import 'package:lingoread/Controllers/Theme/homecontroller.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Routes/routes_names.dart';
import '../../Utils/constants.dart';

class FavStoryWidget extends StatefulWidget {
  const FavStoryWidget(this.story, this.context, this.favController,
      {Key? key, this.isFavScreen = false})
      : super(key: key);
  final dynamic story;
  final BuildContext context;
  final FavController favController;
  final bool isFavScreen;

  @override
  State<FavStoryWidget> createState() => _StoryState();
}

class _StoryState extends State<FavStoryWidget> {
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
      () => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(7)),
        child: Container(
          // height: getProportionateScreenHeight(160),
          width: getProportionateScreenWidth(355),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5A6CEA).withOpacity(0.1),
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(85),
                      width: getProportionateScreenWidth(88),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.story["image"].contains("http")
                                    ? widget.story["image"]
                                    : (AppConst.imagebaseurl +
                                        widget.story["image"])),
                            fit: BoxFit.cover),
                        //color: Colors.green,
                        color: ThemeController.to.isDark.isTrue
                            ? Theme.of(context).colorScheme.primary
                            : AppConst.light_textColor_gw,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(
                        //   color: Theme.of(context).primaryColorLight,
                        //   width: 1.5,
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(235),
                          child: TextWidgetHeading(
                            overflow: TextOverflow.ellipsis,
                            maxLine: 2,

                            // textAlignment: TextAlign.left,
                            titleHeading: widget.story["title"].toString(),
                            textStyle: GoogleFonts.sora(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kTextColorSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(6),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(242),
                          child: TextWidgetHeading(
                            // textAlignment: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            titleHeading:
                                widget.story["description"].toString(),
                            maxLine: 3,
                            textStyle: GoogleFonts.sora(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: kTextColorSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(9),
                    ),
                    const Icon(Icons.check_circle, color: kButtonColor),
                  ],
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   selectedTileColor: Colors.red,
                //   selected: true,
                //   leading:
                //   title:
                //   subtitle:
                //   trailing:
                // ),
              ],
            ),
          ),
        ),
      ),
      //  Container(
      //   height: getProportionateScreenHeight(108),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10),
      //     boxShadow: [
      //       BoxShadow(
      //         color: const Color(0XFF5A6CEA).withOpacity(0.1),
      //         offset: const Offset(
      //           2.0,
      //           3.0,
      //         ),
      //         blurRadius: 10.0,
      //         spreadRadius: 2.0,
      //       ), //BoxShadow
      //       BoxShadow(
      //         color: const Color(0XFF5A6CEA).withOpacity(0.1),
      //         offset: const Offset(0.0, 0.0),
      //         blurRadius: 0.0,
      //         spreadRadius: 0.0,
      //       ), //BoxShadow
      //     ],
      //   ),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         height: getProportionateScreenHeight(85),
      //         width: getProportionateScreenWidth(88),
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //               image: NetworkImage(widget.story["image"].contains("http")
      //                   ? widget.story["image"]
      //                   : (AppConst.imagebaseurl + widget.story["image"])),
      //               fit: BoxFit.cover),
      //           //color: Colors.green,
      //           color: ThemeController.to.isDark.isTrue
      //               ? Theme.of(context).colorScheme.primary
      //               : AppConst.light_textColor_gw,
      //           borderRadius: BorderRadius.circular(10),
      //           // border: Border.all(
      //           //   color: Theme.of(context).primaryColorLight,
      //           //   width: 1.5,
      //           // ),
      //         ),
      //       ),
      //       Container(
      //         color: Colors.red,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             // Text(
      //             //   widget.story["title"].toString(),
      //             // ),

      //             TextWidgetHeading(
      //               overflow: TextOverflow.ellipsis,
      //               // textAlignment: TextAlign.left,
      //               titleHeading: widget.story["title"].toString(),
      //               textStyle: GoogleFonts.sora(
      //                 textStyle: const TextStyle(
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.w600,
      //                   color: kTextColorSecondary,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               width: getProportionateScreenWidth(242),
      //               height: getProportionateScreenHeight(48),
      //               child: TextWidgetHeading(
      //                 // textAlignment: TextAlign.left,
      //                 //   overflow: TextOverflow.ellipsis,
      //                 titleHeading: widget.story["description"].toString(),
      //                 textStyle: GoogleFonts.sora(
      //                   textStyle: const TextStyle(
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.w300,
      //                     color: kTextColorSecondary,
      //                   ),
      //                 ),
      //               ),
      //             ),

      //             Align(
      //               alignment: Alignment.bottomRight,
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: const [
      //                   Icon(Icons.check_circle, color: kButtonColor),
      //                   Icon(Icons.favorite, color: kButtonColor),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      // ListTile(
      //   leading: Container(
      //     height: getProportionateScreenHeight(85),
      //     width: getProportionateScreenWidth(88),
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //           image: NetworkImage(widget.story["image"].contains("http")
      //               ? widget.story["image"]
      //               : (AppConst.imagebaseurl + widget.story["image"])),
      //           fit: BoxFit.cover),
      //       //color: Colors.green,
      //       color: ThemeController.to.isDark.isTrue
      //           ? Theme.of(context).colorScheme.primary
      //           : AppConst.light_textColor_gw,
      //       borderRadius: BorderRadius.circular(10),
      //       // border: Border.all(
      //       //   color: Theme.of(context).primaryColorLight,
      //       //   width: 1.5,
      //       // ),
      //     ),
      //   ),
      //   title: TextWidgetHeading(
      //     overflow: TextOverflow.ellipsis,
      //     // textAlignment: TextAlign.left,
      //     titleHeading: widget.story["title"].toString(),
      //     textStyle: GoogleFonts.sora(
      //       textStyle: const TextStyle(
      //         fontSize: 15,
      //         fontWeight: FontWeight.w600,
      //         color: kTextColorSecondary,
      //       ),
      //     ),
      //   ),
      //   subtitle: SizedBox(
      //     width: getProportionateScreenWidth(242),
      //     height: getProportionateScreenHeight(48),
      //     child: TextWidgetHeading(
      //       // textAlignment: TextAlign.left,
      //       //   overflow: TextOverflow.ellipsis,
      //       titleHeading: widget.story["description"].toString(),
      //       textStyle: GoogleFonts.sora(
      //         textStyle: const TextStyle(
      //           fontSize: 12,
      //           fontWeight: FontWeight.w300,
      //           color: kTextColorSecondary,
      //         ),
      //       ),
      //     ),
      //   ),
      //   // trailing: Row(
      //   //   mainAxisSize: MainAxisSize.max,
      //   //   mainAxisAlignment: MainAxisAlignment.end,
      //   //   children: const [
      //   //     Icon(Icons.check_circle, color: kButtonColor),
      //   //     Icon(Icons.favorite, color: kButtonColor),
      //   //   ],
      //   // ),
      // ),
      // ],

      // padding: EdgeInsets.all(AppConst.padding * 0.5),

      // child: Stack(
      //   children: <Widget>[
      //     Positioned(
      //       bottom: 1,
      //       left: 1,
      //       child: Container(
      //         height: 87,
      //         width: 340,
      //         decoration: BoxDecoration(
      //           color: const Color(0XFF18A5D3).withOpacity(0.6),
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 10),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               TextWidgetHeading(
      //                 overflow: TextOverflow.ellipsis,
      //                 textAlignment: TextAlign.left,
      //                 titleHeading: widget.story["title"].toString(),
      //                 textStyle: GoogleFonts.sora(
      //                   textStyle: const TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.w600,
      //                     color: kPrimaryColor,
      //                   ),
      //                 ),
      //               ),
      //               TextWidgetHeading(
      //                 textAlignment: TextAlign.left,
      //                 overflow: TextOverflow.ellipsis,
      //                 titleHeading: widget.story["description"].toString(),
      //                 textStyle: GoogleFonts.sora(
      //                   textStyle: const TextStyle(
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.w300,
      //                     color: kPrimaryColor,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 10,
      //       right: 10,
      //       child: InkWell(
      //           onTap: () {},
      //           child: Icon(Icons.check_circle, color: kButtonColor)),
      //     ),
      //     Positioned(
      //       top: 10,
      //       right: 50,
      //       child: InkWell(
      //           onTap: () {},
      //           child: Icon(Icons.favorite, color: kButtonColor)),
      //     ),
      //   ],
      // ),
      // ),
      // ),
    );
  }
}
