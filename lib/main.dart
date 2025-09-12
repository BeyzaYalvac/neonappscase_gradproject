import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_themes.dart';
import 'package:neonappscase_gradproject/app/common/theme/cubit/theme_cubit.dart';
import 'package:neonappscase_gradproject/app/common/theme/cubit/theme_state.dart';
import 'package:neonappscase_gradproject/app/core/boot/app_bootstrap.dart';
import 'package:neonappscase_gradproject/app/core/network/cubit/network_cubit.dart';
import 'package:neonappscase_gradproject/app/core/injections/injection_container_items.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  // Native splash ekranda kalsın:
  FlutterNativeSplash.preserve(widgetsBinding: bindings);

  // Burada sadece en minimal şeyleri yap (çok ağır işleri SplashAnimated’a bırak)
  // Örn. hiçbir şey veya sadece kritik 10-50ms işler.

  // Native splash’i kapat ve uygulamayı göster:
  FlutterNativeSplash.remove();
  // AĞIR İŞLERİ BURADA YAP ⬇️
  final boot = await AppBootstrap.init(); // settingsBox vs burada hazır
  runApp(MyApp(settingsBox: boot.settingsBox));
}

class MyApp extends StatelessWidget {
  final Box settingsBox;
  const MyApp({super.key, required this.settingsBox});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(settingsBox)),
        BlocProvider<NetworkCubit>(create: (_) => NetworkCubit()..start()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            scaffoldMessengerKey: rootScaffoldMessengerKey, // ✅ kritik
            //home: MoviesHomepage(),
            routerConfig: InjectionContainerItems.appRouter.config(),
          );
        },
      ),
    );
  }
}
