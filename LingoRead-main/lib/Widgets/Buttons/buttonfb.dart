import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Widgets/text_widget_heading.dart';

import '../../Utils/constants.dart';
import '../../Utils/size_config.dart';

class ButtonFB extends StatelessWidget {
  ButtonFB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.all(10),
        foregroundColor: Theme.of(context).primaryColorDark,
        backgroundColor: const Color(0xFF549DF2),
      ),
      onPressed: onPressed as void Function()?,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 22,
            child: Image.asset("assets/images/fb.png"),
          ),
          const SizedBox(
            width: 10,
          ),
          TextWidgetHeading(
            // textAlignment: TextAlign.center,
            titleHeading: 'Facebook',
            textStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: getProportionateScreenHeight(16),
                // letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: kTextColorSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
