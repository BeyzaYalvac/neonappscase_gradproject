import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/bars/storage_bar.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/cards/stats_cards.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/header/header_avatar.dart';
import 'package:neonappscase_gradproject/core/utils/storage_utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final account = state.acountInfos;
        final traficLeft = state.acountInfos?.storageLeftFormatted;

        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textBej),
          );
        }

        final double used = StorageUtils.bytesToGb(
          account.storageUsed.toDouble(),
        );
        String usedString = used.toStringAsFixed(4);
        //debugPrint("used: $usedString GB");

        //final int left = account.storageLeft; kullanmıycam

        //debugPrint("progress: ${progress.toStringAsFixed(4)}");

        final h = AppMediaQuery.screenHeight(context);
        final w = AppMediaQuery.screenWidth(context);
        final avatarRadius = w * 0.14;

        return Container(
          width: w,
          height: h,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER + AVATAR STACK
              HeaderAvatar(
                h: h,
                w: w,
                account: account,
                avatarRadius: avatarRadius,
              ),

              SizedBox(height: h * 0.02),

              // Storage Bar
              StorageBar(h: h, w: w, progress: used),

              SizedBox(height: h * 0.02),

              // Stats
              Stats(w: w, used: usedString, h: h, traficLeft: traficLeft),
            ],
          ),
        );
      },
    );
  }
}
