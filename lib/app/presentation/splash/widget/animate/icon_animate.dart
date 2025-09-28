import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';

class IconAnimate extends StatelessWidget {
  const IconAnimate({
    super.key,
    required bool readyToNavigate,
    required AnimationController ctrl,
  }) : _readyToNavigate = readyToNavigate, _ctrl = ctrl;

  final bool _readyToNavigate;
  final AnimationController _ctrl;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 800),
      scale: _readyToNavigate ? 0.95 : 1.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _readyToNavigate ? 0.0 : 1.0,
        child: Lottie.asset(
          AppAssets.themeToggleAnimation,
          controller: _ctrl,
          onLoaded: (comp) {
            _ctrl
              ..duration = comp.duration
              ..repeat();
          },
          width: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
