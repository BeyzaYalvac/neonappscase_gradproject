import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/tabs%20sections/tab_sections.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_cubit.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_state.dart';

class NetworkControlMaterialBanner extends StatelessWidget {
  const NetworkControlMaterialBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (ctx, state) {
        final messenger = ScaffoldMessenger.of(ctx);
        final isOnline = state.isOnline;
    
        messenger.hideCurrentMaterialBanner();
        messenger.showMaterialBanner(
          MaterialBanner(
            backgroundColor: isOnline ? AppColors.success : AppColors.fail,
            leading: Icon(
              isOnline ? Icons.wifi : Icons.wifi_off,
              color: AppColors.bgPrimary,
            ),
            content: Text(
              isOnline
                  ? AppStrings.internetHasCome
                  : AppStrings.internetHasGone,
              style: AppTextSytlyes.whiteTextStyle,
            ),
            actions: [
              TextButton(
                onPressed: () => messenger.hideCurrentMaterialBanner(),
                child: const Text(
                  AppStrings.closeText,
                  style: AppTextSytlyes.whiteTextStyle,
                ),
              ),
            ],
          ),
        );
    
        Future.delayed(Duration(seconds: isOnline ? 2 : 4), () {
          if (ctx.mounted) messenger.hideCurrentMaterialBanner();
        });
      },
    
      child: TabSections(),
    );
  }
}
