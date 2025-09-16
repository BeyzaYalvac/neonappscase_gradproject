import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = AppMediaQuery.screenHeight(context);
    final w = AppMediaQuery.screenWidth(context);
    final avatarRadius = w * 0.14;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final account = state.acountInfos;

        if (account == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Güvenli tipler ve hesap
        final int used = account.storageUsed ?? 0;
        final int left = account.storageLeft ?? 0;
        final int total = used + left;
        double progress = total > 0 ? used / total : 0.0;
        // Gürültülü veriye karşı clamp
        progress = progress.clamp(0.0, 1.0);

        String formatBytes(num bytes) {
          if (bytes <= 0) return "0 B";
          const k = 1024;
          const sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
          final i = (math.log(bytes) / math.log(k)).floor().clamp(
            0,
            sizes.length - 1,
          );
          final v = bytes / math.pow(k, i);
          return "${v.toStringAsFixed(1)} ${sizes[i]}";
        }

        final h = AppMediaQuery.screenHeight(context);
        final w = AppMediaQuery.screenWidth(context);
        final avatarRadius = w * 0.14;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HEADER + AVATAR STACK
            SizedBox(
              height: h * 0.20,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: h * 0.12,
                    width: w * 0.9,
                    margin: EdgeInsets.fromLTRB(
                      w * 0.05,
                      h * 0.08,
                      w * 0.05,
                      0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.06),
                      child: Center(
                        child: Text(
                          account.email,
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: h * 0.01,
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.bgQuaternary,
                      child: Icon(
                        Icons.person,
                        size: avatarRadius,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // STORAGE BAR
            Container(
              height: h * 0.10,
              width: w * 0.9,
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.bgQuaternary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Current Storage: ${formatBytes(used)} / ${formatBytes(total)}  (${(progress * 100).toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      minHeight: h * 0.02,
                      value: progress, // ✅ doğru 0..1 aralığı
                      backgroundColor: AppColors.bgQuaternary,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.bgTriartry,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            // Stats
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Used',
                      value: formatBytes(used),
                      height: h * 0.18,
                      color: AppColors.bgQuaternary,
                    ),
                  ),
                  _StatCard(
                    title: 'Left',
                    value: formatBytes(left),
                    height: h * 0.18,
                    color: AppColors.bgQuaternary,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double height;
  final Color color;

  const _StatCard({
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
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.1),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
