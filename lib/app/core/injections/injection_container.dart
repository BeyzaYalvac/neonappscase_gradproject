import 'package:get_it/get_it.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.dart';

class InjectionContainer {
  InjectionContainer._();

  static final _instance = GetIt.instance;

  static void setUp() {
    if (!_instance.isRegistered<AppRouter>()) {
      _instance.registerSingleton<AppRouter>(AppRouter());
    }
  }

  static T read<T extends Object>() => _instance<T>();
}
