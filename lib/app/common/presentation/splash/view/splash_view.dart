import 'package:auto_route/auto_route.dart' show AutoRouterX, RoutePage;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/core/boot/app_bootstrap.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/core/constants/spacing/app_paddings.dart';

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
    // 1) Ağır init’leri başlat (en fazla 4 sn bekle)
    await Future.wait([
      AppBootstrap.init(), // init burada
      Future.delayed(const Duration(milliseconds: 2000)), // 3 sn sabit
    ]);

    // 2) Onboarding/HOME kararı
    final box = Hive.box('settingsBox');
    final seenOnboarding =
        box.get('seenOnboarding', defaultValue: false) as bool;

    if (!mounted) return;
    setState(() => _readyToNavigate = true);

    // 3) Kısa bir fade/scale bitişi için küçük gecikme (opsiyonel 300–600ms)
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    setState(() => _readyToNavigate = true);
    await Future.delayed(const Duration(milliseconds: 300)); // kısa fade
    if (!mounted && seenOnboarding) return;
    context.router.replace(SplashDescriptionRoute());
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
                AnimatedScale(
                  duration: const Duration(milliseconds: 800),
                  scale: _readyToNavigate ? 0.95 : 1.0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: _readyToNavigate ? 0.0 : 1.0,
                    child: Lottie.asset(
                      'assets/animations/theme_toggle.json',
                      controller: _ctrl,
                      onLoaded: (comp) {
                        // Döngü istersen:
                        _ctrl
                          ..duration = comp.duration
                          ..repeat();
                      },
                      width: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

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
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.textMedium, Colors.transparent],
                begin: AlignmentGeometry.bottomCenter,
                end: AlignmentGeometry.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
