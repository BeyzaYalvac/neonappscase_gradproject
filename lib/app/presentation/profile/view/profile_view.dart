import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/profile_status_cards.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final account = state.acountInfos;
        final storageLeft = state.acountInfos?.storageLeftFormatted;
        final storageUsed = state.acountInfos?.storageUsedFormatted;
        print("traficLeft: $storageLeft");
        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textBej),
          );
        }

        // Güvenli tipler ve hesap
        final int used = account.storageUsed;
        final int left = account.storageLeft;
        final int total = used + left;
        double progress = total > 0 ? used / total : 0.0;
        // Gürültülü veriye karşı clamp
        progress = progress.clamp(0.0, 1.0);

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
                      child: AppIcons.profile,
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
                      "Current Storage: ${storageUsed != null && storageLeft != null ? storageUsed : 'N/A'}",
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
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(
                    title: AppStrings.usedProfileText,
                    value: storageUsed ?? 'N/A',
                    height: h * 0.18,
                    color: AppColors.bgQuaternary,
                  ),
                  StatCard(
                    title: AppStrings.leftProfileText,
                    value: storageLeft ?? 'N/A',
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
