import 'package:bhulexapp/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

import 'onboarding_screen2.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/bhulexlogin..png',
          width: ResponsiveHelper.spacing(297), // 297px on iPhone X
          height: ResponsiveHelper.spacing(116), // 116px on iPhone X
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
