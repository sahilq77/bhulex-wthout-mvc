import 'package:flutter/material.dart';


void SnackBarDesign(String Message, BuildContext context, Color backgroundColor,
    Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: new Text(
      Message,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: backgroundColor.withOpacity(0.7),
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating, // Customize the behavior
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Customize the border radius
    ),
  ));

  print(Message);
}

void SnackBarDesignLowTime(String Message, BuildContext context,
    Color backgroundColor, Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: new Text(
      Message,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: backgroundColor.withOpacity(0.7),
    duration: Duration(seconds: 1),
    behavior: SnackBarBehavior.floating, // Customize the behavior
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Customize the border radius
    ),
  ));

  print(Message);
}
