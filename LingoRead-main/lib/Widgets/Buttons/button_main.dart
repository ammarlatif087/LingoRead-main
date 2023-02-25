import 'package:flutter/material.dart';
import 'package:lingoread/Utils/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 2,
        foregroundColor: kButtonColor,
        backgroundColor: kButtonColor,
      ),
      onPressed: onPressed as void Function(),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
