import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double height;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final w = AppMediaQuery.screenWidth(context);

    return Container(
      height: height,
      width: w * 0.4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.08),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
