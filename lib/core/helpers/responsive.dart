import 'package:flutter/material.dart';

class Responsive {
  static const double tabletBreakpoint = 600;
  static const double tabletContentWidth = 620;
  static const double largeTabletContentWidth = 700;

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }
}
