import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class splash_gradient_bg extends StatelessWidget {
  const splash_gradient_bg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.bgTriartry,
            AppColors.textTransparent,
            AppColors.textTransparent,
          ],
          stops: const [0.01, 0.8, 1.0],
          begin: AlignmentGeometry.bottomCenter,
          end: AlignmentGeometry.center,
        ),
      ),
    );
  }
}
