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
        final traficLeft = state.acountInfos?.storageLeftFormatted;

        byteToGB(double byte) {
          return (byte / (1024 * 1024 * 1024)).toStringAsFixed(4);
        }

        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textBej),
          );
        }

        // Güvenli tipler ve hesap
        final String used = byteToGB(account.storageUsed.toDouble());
        //final int left = account.storageLeft; kullanmıycam
        final int total = 5;
        double progress = total > 0
            ? (double.tryParse(used) ?? 0) / total
            : 0.0;
        print("progress: ${progress.toStringAsFixed(4)}");

        final h = AppMediaQuery.screenHeight(context);
        final w = AppMediaQuery.screenWidth(context);
        final avatarRadius = w * 0.14;

        return Container(
          width: w,
          height: h,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : Theme.of(context).colorScheme.background,
          child: Column(
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.bgSmoothDark
                            : AppColors.bgPrimary,
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
                        child: AppIcons.profile_xxl,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.bgSmoothDark
                      : AppColors.bgPrimary,
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
                        "Current Storage: ${progress.toStringAsFixed(4)}GB / 5GB ",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        minHeight: h * 0.02,
                        value: progress,
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
                      value: used,
                      height: h * 0.18,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.bgSmoothDark
                          : AppColors.bgPrimary,
                    ),
                    StatCard(
                      title: AppStrings.leftProfileText,
                      value: traficLeft ?? 'N/A',
                      height: h * 0.18,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.bgSmoothDark
                          : AppColors.bgPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
