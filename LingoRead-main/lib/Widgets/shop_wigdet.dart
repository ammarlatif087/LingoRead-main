import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingoread/Utils/app_constants.dart';

import '../Controllers/Theme/themecontroller.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget(this.text1, this.text2, this.color1, {Key? key})
      : super(key: key);
  final String text1;
  final String text2;
  final Color color1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConst.padding * 0.25),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppConst.padding * 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: ThemeController.to.isDark.isTrue
                            ? AppConst.colorWhite
                            : AppConst.dark_colorMainLight)),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  text2,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
