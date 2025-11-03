import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Heading styles using Poppins
  static TextStyle headingLarge({
    Color color = const Color(0xFF36322E),
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.57,
    );
  }

  static TextStyle headingLargepro({
    Color color = const Color(0xFF36322E),
    double fontSize = 24,
    fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.57,
    );
  }

  static TextStyle headingMedium({
    Color color = const Color(0xFF36322E),
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Body styles using Inter
  static TextStyle bodyRegular({
    Color color = const Color(0xFF36322E),
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle logouttext({
    color = Colors.black54,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Hint styles
  static TextStyle hint({
    Color color = const Color(0xFF36322E),
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Error styles
  static TextStyle error({
    Color color = Colors.red,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle secondary({
    Color color = Colors.grey,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Button text style
  static TextStyle button({
    Color color = Colors.white,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle buttonlogout({
    Color color = Colors.white,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Note text style
  static TextStyle note({
    Color color = const Color(0xFF36322E),
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bottomnavLabel({
    Color color = const Color(0xFF353B43),
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bodyRegularpro({
    Color color = const Color(0xFF353B43),
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

