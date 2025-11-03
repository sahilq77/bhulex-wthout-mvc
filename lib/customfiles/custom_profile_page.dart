import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BhulexStyle {
  static const String fontFamily = 'Poppins';

  static TextStyle appBarTitle(double width) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: width * 0.050,
      color: const Color(0xFF36322E),
    );
  }

  static Style htmlBodyStyle(double width) {
    return Style(
      fontFamily: fontFamily,
      fontSize: FontSize(width * 0.04),
      color: const Color(0xFF36322E),
    );
  }

  static Style htmlParagraphStyle(double width) {
    return Style(
      fontFamily: fontFamily,
      fontSize: FontSize(width * 0.04),
      color: const Color(0xFF36322E),
    );
  }

  static Style htmlHeading1Style(double width) {
    return Style(
      fontFamily: fontFamily,
      fontSize: FontSize(width * 0.06),
      fontWeight: FontWeight.w600,
      color: const Color(0xFF36322E),
    );
  }

  static Style htmlHeading2Style(double width) {
    return Style(
      fontFamily: fontFamily,
      fontSize: FontSize(width * 0.05),
      fontWeight: FontWeight.w500,
      color: const Color(0xFF36322E),
    );
  }

  static IconThemeData iconStyle(double width) {
    return IconThemeData(color: const Color(0xFF36322E), size: width * 0.06);
  }

  static const Color backgroundColor = Color(0xFFFDFDFD);
}
