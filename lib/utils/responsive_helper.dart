import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  // Initialize once in your main widget
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  // Get responsive font size based on screen width
  static double getResponsiveFontSize(double fontSize) {
    double scaleFactor = screenWidth / 375.0; // Base: iPhone X width (375px)

    // Limit scaling to prevent extreme sizes on very small or large screens
    if (scaleFactor < 0.85) scaleFactor = 0.85;
    if (scaleFactor > 1.15) scaleFactor = 1.15;

    return fontSize * scaleFactor;
  }

  // Make any TextStyle responsive
  static TextStyle makeResponsive(TextStyle style) {
    return style.copyWith(
      fontSize: getResponsiveFontSize(style.fontSize ?? 14.0),
    );
  }

  // Safe text widget that prevents overflow and scales properly
  static Widget safeText(
    String text, {
    required TextStyle style,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: textAlign == TextAlign.center
              ? Alignment.center
              : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
            ),
            child: Text(
              text,
              style: makeResponsive(style),
              maxLines: maxLines,
              textAlign: textAlign,
              overflow: overflow ?? TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        );
      },
    );
  }

  // Flexible version for use in Rows/Columns
  static Widget flexText(
    String text, {
    required TextStyle style,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    return Flexible(
      child: safeText(
        text,
        style: style,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }

  // Responsive spacing
  static double spacing(double value) {
    return (value * screenWidth) / 375.0;
  }

  // Responsive padding
  static EdgeInsets padding(double value) {
    final responsive = spacing(value);
    return EdgeInsets.all(responsive);
  }

  static EdgeInsets paddingSymmetric(
      {double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(
      horizontal: spacing(horizontal),
      vertical: spacing(vertical),
    );
  }

  // Check device types
  static bool isMobile() => screenWidth < 600;
  static bool isTablet() => screenWidth >= 600 && screenWidth < 1200;
  static bool isDesktop() => screenWidth >= 1200;
}

// Extension to make your existing AppStyle responsive with minimal changes
extension AppStyleResponsive on TextStyle {
  TextStyle get responsive => ResponsiveHelper.makeResponsive(this);
}

// Extension for easy access to responsive values
extension ResponsiveContext on BuildContext {
  double get sw => MediaQuery.of(this).size.width;
  double get sh => MediaQuery.of(this).size.height;

  // Quick responsive values
  double r(double value) => ResponsiveHelper.spacing(value);

  bool get isMobile => sw < 600;
  bool get isTablet => sw >= 600 && sw < 1200;
  bool get isDesktop => sw >= 1200;
}
