import 'package:auto_route/auto_route.dart' show AutoRouterX, RoutePage;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/common/boot/app_bootstrap.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/animate/icon_animate.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/container/lineer_bg.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool _readyToNavigate = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this);
    _start();
  }

  Future<void> _start() async {
    await Future.wait([
      AppBootstrap.init(),
      Future.delayed(const Duration(milliseconds: 2000)),
    ]);

    if (!mounted) return;
    setState(() => _readyToNavigate = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    final boxFirst = Hive.box<bool>('first_control_box');

    final isFirst = boxFirst.get(AppConfig.isFirstKey) ?? true;
    debugPrint("isFirst değişkeni: ${isFirst.toString()}");

    if (isFirst) {
      //await boxFirst.put(AppConfig.isFirstKey, false);
      context.router.replace(const SplashDescriptionRoute());
    } else if (!isFirst) {
      context.router.replace(const HomeRoute());
    } else {
      if (!mounted) return;
      context.router.replace(const HomeRoute());
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.bgTriartry,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconAnimate(readyToNavigate: _readyToNavigate, ctrl: _ctrl),

                AppPaddings.customHeightSizedBox(context, 0.2),

                Text(
                  AppStrings.appName,
                  style: AppTextSytlyes.appNameTextStyle,
                ),
                Text(
                  AppStrings.appSplashParagraph,
                  style: AppTextSytlyes.splashSubtitleStyle,
                ),
              ],
            ),
          ),
          LineerBg(),
        ],
      ),
    );
  }
}