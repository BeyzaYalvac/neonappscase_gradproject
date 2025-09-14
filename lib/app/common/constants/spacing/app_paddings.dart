import 'package:flutter/material.dart';

class AppPaddings {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 48.0;

  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static SizedBox CustomHeightSizedBox(
    BuildContext context,
    double customHeight,
  ) {
    return SizedBox(height: MediaQuery.of(context).size.height * customHeight);
  }

  static SizedBox CustomWidthSizedBox(
    BuildContext context,
    double customHeight,
  ) {
    return SizedBox(height: MediaQuery.of(context).size.width * customHeight);
  }
}
