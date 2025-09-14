import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/cubit/splash_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/cubit/splash_state.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/view/splash_desc_body.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/button/onboarding_button.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/button/splash_dots.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/view/splash_welcome_body.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

@RoutePage()
class SplashDescriptionView extends StatelessWidget {
  const SplashDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bodies = const [SplashWelcomeBody(), SplashDescriptionBody()];

    return BlocProvider(
      create: (_) => SplashCubit(bodies.length),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          final cubit = context.read<SplashCubit>();

          return Scaffold(
            body: Stack(
              children: [
                // Text body'ler containerların üstünde
                PageView(
                  controller: cubit.controller,
                  onPageChanged: (index) => cubit.updatePage(index),
                  children: bodies,
                ),

                // Dots + Button
                Column(
                      children: [
                        AppPaddings.CustomHeightSizedBox(context, 0.17),
                        SplashDots(),
                        AppPaddings.CustomHeightSizedBox(context, 0.01),
                        SplashButton(
                          text: state.index == state.totalPages - 1
                              ? "Başla"
                              : "İleri",
                          onPressed: () {
                            if (state.index == state.totalPages - 1) {
                              context.router.replace(HomeRoute());
                              final boxFirst = Hive.box<bool>(
                                'first_control_box',
                              );
                              boxFirst.put(AppConfig.isFirstKey, false);
                            } else {
                              cubit.nextPage();
                            }
                          },
                        ),
                      ],
                    )
                    .withAlignment(Alignment.bottomCenter)
                    .withPadding(
                      EdgeInsets.only(
                        top: AppMediaQuery.screenHeight(context) * 0.65,
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
