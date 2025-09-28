import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class LineerBg extends StatelessWidget {
  const LineerBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.textMedium, AppColors.bgTransparent],
          begin: AlignmentGeometry.bottomCenter,
          end: AlignmentGeometry.center,
        ),
      ),
    );
  }
}
