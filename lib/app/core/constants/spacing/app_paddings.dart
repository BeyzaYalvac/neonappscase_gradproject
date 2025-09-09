import 'package:flutter/material.dart';

class AppPaddings {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;

  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static SizedBox customHeightSizedBox(BuildContext context, double customHeight) {
    return SizedBox(height: MediaQuery.of(context).size.height * customHeight);
  }
  static SizedBox customWidthSizedBox(BuildContext context, double customHeight) {
    return SizedBox(height: MediaQuery.of(context).size.width * customHeight);
  }

  
}
