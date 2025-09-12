import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/core/network/cubit/network_cubit.dart';
import 'package:neonappscase_gradproject/app/core/network/cubit/network_state.dart';
import 'package:neonappscase_gradproject/app/core/widget/button/theme_toggle_button.dart';
import 'package:neonappscase_gradproject/app/core/widget/snackbar/custom_app_snackbar.dart';
import 'package:neonappscase_gradproject/main.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<NetworkCubit, NetworkState>(
      listenWhen: (prev, next) => prev?.status != next.status,
      listener: (context, state) {
        final messenger = rootScaffoldMessengerKey.currentState;
        messenger?.hideCurrentSnackBar();

        final isOnline = state.isOnline;
        messenger?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: isOnline ? 2 : 4),
            content: Row(
              children: [
                Icon(isOnline ? Icons.wifi : Icons.wifi_off),
                const SizedBox(width: 8),
                Text(
                  isOnline ? 'İnternet geri geldi' : 'İnternet bağlantısı yok',
                ),
              ],
            ),
            backgroundColor: isOnline ? AppColors.success : AppColors.fail,
          ),
        );
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              CustomAppSnackbar.success(context, "Başarılı", "lşmkl");
            },
            child: Text("Tıkla"),
          ),
        ),
        appBar: AppBar(actions: [LottieThemeToggle()]),
      ),
    );
  }
}
