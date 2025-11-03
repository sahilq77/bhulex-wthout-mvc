// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';

// class AppFontStyle {
//   static TextStyle poppins({
//     double? fontSize,
//     Color? color,
//     FontWeight? fontWeight,
//     double? height,
//     TextStyle? textStyle,
//     //int? letterSpacing, // Optional, to be set by the caller
//   }) {
//     return GoogleFonts.poppins(
//       height: height, // Use the provided height
//     ).copyWith(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: fontWeight, // Pass through if provided, null otherwise
//     );
//   }

//   static TextStyle inter({
//     double? fontSize,
//     Color? color,
//     FontWeight? fontWeight,
//     double? height, // Optional, to be set by the caller
//   }) {
//     return GoogleFonts.inter(
//       height: height, // Use the provided height
//     ).copyWith(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: fontWeight, // Pass through if provided, null otherwise
//     );
//   }
// }
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppFontStyle {
  static TextStyle poppins({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextStyle? textStyle,
    bool isLocal = false, // Added for Marathi support, defaults to false
  }) {
    return isLocal
        ? GoogleFonts.notoSansDevanagari(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        )
        : GoogleFonts.poppins(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        );
  }

  static TextStyle inter({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    bool isLocal = false, // Added for Marathi support, defaults to false
  }) {
    return isLocal
        ? GoogleFonts.notoSansDevanagari(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        )
        : GoogleFonts.inter(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        );
  }
}

class AppFontStyle2 {
  static TextStyle blinker({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextStyle? textStyle,
    bool isLocal = false, // Added for Marathi support, defaults to false
  }) {
    return isLocal
        ? GoogleFonts.notoSansDevanagari(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        )
        : GoogleFonts.blinker(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        );
  }

  static TextStyle inter({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    bool isLocal = false, // Added for Marathi support, defaults to false
  }) {
    return isLocal
        ? GoogleFonts.notoSansDevanagari(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        )
        : GoogleFonts.inter(
          height: height, // Use the provided height
        ).copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight, // Pass through if provided, null otherwise
        );
  }
}
