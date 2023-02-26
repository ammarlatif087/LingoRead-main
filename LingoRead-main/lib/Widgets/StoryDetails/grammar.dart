import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Controllers/Theme/themecontroller.dart';
import 'package:lingoread/Utils/constants.dart';
import 'package:lingoread/Utils/size_config.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';
import '../../Utils/app_constants.dart';
import 'package:flutter_html/flutter_html.dart';

class Grammer extends StatelessWidget {
  const Grammer(this.grammers, {Key? key}) : super(key: key);
  final List grammers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: grammers.length,
      itemBuilder: (context, index) {
        dynamic grammer = grammers[index];
        return GrammerWidget(grammer);
      },
    );
  }
}

class GrammerWidget extends StatelessWidget {
  const GrammerWidget(this.data, {Key? key}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(12), horizontal: 6),
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: AppConst.padding * 0.5),
        // padding: EdgeInsets.fromLTRB(AppConst.padding * 1, AppConst.padding * 1,
        //   AppConst.padding * 1, AppConst.padding * 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeController.to.isDark.isTrue
              ? AppConst.color_343434.withOpacity(0.28)
              : kPrimaryColor,
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(5),
              horizontal: getProportionateScreenHeight(11),
            ),
            child: Container(
              height: getProportionateScreenHeight(52),
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidgetHeading(
                    textAlignment: TextAlign.center,
                    titleHeading: (data ?? {})["name"] ?? "",
                    textStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        // letterSpacing: 1.3,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: AppConst.padding * 0.5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(5),
                  horizontal: getProportionateScreenHeight(10),
                ),
                child: TextWidgetHeading(
                  textAlignment: TextAlign.center,
                  titleHeading: 'Example',
                  textStyle: GoogleFonts.sora(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                  child: Html(
                style: {
                  "body": Style(
                    padding: EdgeInsets.zero,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'sora',
                    color: kTextColorSecondary,
                    fontSize: FontSize(getProportionateScreenHeight(14)),
                    // fontWeight: FontWeight.bold,
                  ),
                },
                data: data['example'],
              )),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: getProportionateScreenHeight(2),
                color: const Color(0XFFD9D9D9),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(5),
                  horizontal: getProportionateScreenHeight(9),
                ),
                child: TextWidgetHeading(
                  textAlignment: TextAlign.center,
                  titleHeading: 'Discription',
                  textStyle: GoogleFonts.sora(
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: kTextColorSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                child: Html(
                  style: {
                    "body": Style(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'sora',
                      color: kTextColorSecondary,
                      fontSize: FontSize(getProportionateScreenHeight(14)),
                      // fontWeight: FontWeight.bold,
                    ),
                  },
                  data: data["content"] ?? "",
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
