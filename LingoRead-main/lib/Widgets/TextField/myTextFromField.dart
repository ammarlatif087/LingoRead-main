import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:lingoread/Utils/constants.dart';

import '../../Utils/size_config.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? onChange;
  final Function? validator;
  final Function? onSaved;
  final Function? onTap;

  final Function? onFieldSubmitted;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRequired;
  final bool isshowHelp;
  final bool isShowHeader;
  final bool isFormField;
  final bool isNumberOnly;
  final bool isZeroPadding;
  final bool isAutoFocus;
  final bool newheight;
  final FocusNode? focusNode;

  final TextEditingController? controller;

  MyTextFormField(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.helpText,
      this.onChange,
      this.onTap,
      this.isPassword = false,
      this.isEmail = false,
      this.isEnabled = true,
      this.isRequired = false,
      this.isshowHelp = false,
      this.isShowHeader = true,
      this.isFormField = false,
      this.isNumberOnly = true,
      this.isZeroPadding = false,
      this.isAutoFocus = false,
      this.newheight = false,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.intialValue,
      this.controller,
      this.onFieldSubmitted,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isShowHeader)
            Row(
              children: [
                Text(labelText.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                if (isRequired)
                  Text(
                    " *",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.red),
                  ),
                if (isshowHelp)
                  Tooltip(
                    message: helpText,
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorLight),
                    child: const Icon(
                      Icons.info,
                      size: 15,
                    ),
                  )
              ],
            ),
          // SizedBox(
          //   height: 1,
          // ),
          Container(
            // height: newheight ? 35 : ((isFormField) ? 30 : 50),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                focusNode: focusNode,
                onTap: onTap as void Function()?,
                controller: controller,
                initialValue: intialValue,
                autofocus: isAutoFocus,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
                // scrollPadding: EdgeInsets.all(0),
                inputFormatters: isNumberOnly
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d*)'))
                      ]
                    : null,
                enabled: isEnabled,
                decoration: InputDecoration(
                  hintText: hintText ?? "Enter " + labelText!,

                  labelText: isShowHeader ? null : labelText,
                  labelStyle: TextStyle(
                    color: kTextColorSecondary, // Set the label color
                    fontSize: getProportionateScreenHeight(
                        16), // Set the label font size
                  ),
                  // prefixStyle: Theme.of(context)
                  //     .textTheme
                  //     .bodyText1!
                  //     .copyWith(fontWeight: FontWeight.bold),
                  suffixStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                  prefixIconColor: Theme.of(context).primaryColorLight,
                  iconColor: Theme.of(context).primaryColorLight,
                  hintStyle: TextStyle(
                    color: kTextColorSecondary, // Set the hint text color
                    fontSize: getProportionateScreenHeight(
                        16), // Set the hint text font size
                  ),
                  contentPadding: isZeroPadding
                      ? const EdgeInsets.symmetric(
                          horizontal: 3.0, vertical: 10)
                      : const EdgeInsets.all(10.0),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: isShowHeader
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColorDark,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: isShowHeader
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColorDark,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      width: 2,
                      color: isShowHeader
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColorDark,
                      style: BorderStyle.solid,
                    ),
                  ),
                  // labelText: labelText,
                  filled: false,
                  suffixIcon: suffixIcon,
                  prefix: prefixIcon,
                ),
                obscureText: isPassword ? true : false,
                validator: validator as String? Function(String?)?,
                onSaved: onSaved as void Function(String?)?,
                onChanged: onChange as void Function(String?)?,
                onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
                keyboardType:
                    isEmail ? TextInputType.emailAddress : TextInputType.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
