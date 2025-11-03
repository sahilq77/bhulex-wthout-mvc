import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressDialog {
  static showProgressDialog(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 50));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Lottie.asset("assets/images/loader.json");
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
