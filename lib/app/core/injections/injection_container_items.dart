
import 'package:neonappscase_gradproject/app/common/router/app_router.dart';
import 'package:neonappscase_gradproject/app/core/injections/injection_container.dart';

final class InjectionContainerItems {
  const InjectionContainerItems._();

  static AppRouter get appRouter => InjectionContainer.read<AppRouter>();

  
}
