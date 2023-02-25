import 'package:flutter/material.dart';
import 'package:lingoread/Utils/size_config.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget(this.imagePath, this.color, this.text, this.textColor,
      this.imageColor, this.onPressed, this.widget,
      {Key? key})
      : super(key: key);
  final String imagePath;
  final String text;
  final Color color;
  final Color textColor;
  final Color imageColor;
  final VoidCallback? onPressed;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(11)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: color,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff5A6CEA).withOpacity(0.2),
                // spreadRadius: 0.00,
                blurRadius: 7,
                offset: const Offset(-2, 2), // shadow direction: bottom right
              )
            ],
          ),
          width: getProportionateScreenWidth(347),
          height: getProportionateScreenHeight(65),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image(
                    height: getProportionateScreenHeight(25),
                    width: getProportionateScreenWidth(25),
                    image: AssetImage(imagePath),
                    color: imageColor,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(23),
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Spacer(),
                InkWell(
                  onTap: onPressed,
                  child: widget,
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
