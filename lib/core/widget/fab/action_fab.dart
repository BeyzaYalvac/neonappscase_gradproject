import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class ActionFab extends StatelessWidget {
  const ActionFab({
    Key? key,
    required this.icon,
    this.onPressed,
    this.size = 56,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = scheme.primary;
    final fg = ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
        ? AppColors.bgPrimary
        : AppColors.bgSecondary;

    return Material(
      color: bg,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      child: SizedBox(
        width: size,
        height: size,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: fg,
          splashRadius: size / 2,
        ),
      ),
    );
  }
}
