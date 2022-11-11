import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/theme_styles.dart';

class GaribookTextWidget extends StatelessWidget{
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  const GaribookTextWidget({Key? key, required this.text, this.color, this.fontSize, this.fontWeight, this.maxLines, this.textAlign, this.textDecoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      // textAlign: TextAlign.left,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,// I used ellipsis, but it works with others (fade, clip, etc.)
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 16,
        color:  color ?? ThemeStyles.secondaryTextColor,
        overflow: maxLines !=   null ? TextOverflow.ellipsis : null,
        decoration: textDecoration,
        // fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }


}