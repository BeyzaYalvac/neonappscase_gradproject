import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/cubit/splash_cubit.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/cubit/splash_state.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/core/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/core/widget/button/onboarding_button.dart';
import 'package:neonappscase_gradproject/app/core/widget/container/splash_dots.dart';

@RoutePage()
class SplashDescriptionView extends StatelessWidget {
  const SplashDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bodies = const [SplashTitleBody(), SplashDescriptionBody()];

    return BlocProvider(
      create: (_) => SplashCubit(bodies.length),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          final cubit = context.read<SplashCubit>();

          return Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: cubit.controller,
                  onPageChanged: (index) => cubit.updatePage(index),
                  children: bodies,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.06,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SplashDots(),
                        const SizedBox(height: 16),
                        SplashButton(
                          text: state.index == state.totalPages - 1
                              ? "Başla"
                              : "İleri",
                          onPressed: () {
                            if (state.index == state.totalPages - 1) {
                              // Splash'a değil, ana sayfaya geç
                              context.router.replace(SplashRoute());
                            } else {
                              cubit.nextPage();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 1) Uygulama adının göründüğü body
class SplashTitleBody extends StatelessWidget {
  const SplashTitleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textBej.withValues(alpha: 0.85),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppPaddings.customHeightSizedBox(context, 0.1),
          Text(
            AppStrings.appName,
            style: AppTextSytlyes.splashWelcomeStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.appSplashParagraph,
            style: AppTextSytlyes.splashWelcomeSubtitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// 2) Uygulama açıklamalarının olduğu body
class SplashDescriptionBody extends StatelessWidget {
  const SplashDescriptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textBej.withValues(alpha: 0.85),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppPaddings.customHeightSizedBox(context, 0.15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppStrings.appSplashWelcome,
              style: AppTextSytlyes.splashWelcomeStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppStrings.appSplashParagraph2,
              style: AppTextSytlyes.splashWelcomeSubtitleStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
