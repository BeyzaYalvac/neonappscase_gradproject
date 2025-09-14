import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/theme/cubit/theme_cubit.dart';

class LottieThemeToggle extends StatefulWidget {
  const LottieThemeToggle({super.key});

  @override
  State<LottieThemeToggle> createState() => _LottieThemeToggleState();
}

class _LottieThemeToggleState extends State<LottieThemeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this);
    final initialMode = context.read<ThemeCubit>().state.themeMode;
    _ctrl.value = (initialMode == ThemeMode.dark) ? 1.0 : 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Tema değişirse, controller hedef frame’de kalsın
    final mode = context.watch<ThemeCubit>().state.themeMode;
    _animateTo(mode == ThemeMode.dark ? 1.0 : 0.0);
  }

  // Future döndür ki onTap’te await edebilelim
  Future<void> _animateTo(double target) {
    return _ctrl.animateTo(
      target / 2,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _onTap() async {
    final cubit = context.read<ThemeCubit>();
    final goingDark = cubit.state.themeMode != ThemeMode.dark;
    // 1) önce animasyon
    await _animateTo(goingDark ? 1.0 : 0.0);
    // 2) sonra temayı kalıcı değiştir
    cubit.toggle();
    // Artık controller hedefte kaldı, loop etmeyecek.
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: () => context.read<ThemeCubit>().setTheme(ThemeMode.system),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Lottie.asset(
          'assets/animations/theme_toggle.json',
          controller: _ctrl,
          repeat: false, // 👈 döngü KAPALI
          animate: false, // 👈 otomatik oynatma YOK (tam kontrol sende)
          onLoaded: (comp) {
            // İstersen Lottie süresini de kullanabilirsin:
            // _ctrl.duration = comp.duration;
          },
        ),
      ),
    );
  }
}
