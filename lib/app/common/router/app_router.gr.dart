// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:neonappscase_gradproject/app/common/presentation/splash/view/splash_description_view.dart'
    as _i1;
import 'package:neonappscase_gradproject/app/common/presentation/splash/view/splash_view.dart'
    as _i2;

/// generated route for
/// [_i1.SplashDescriptionView]
class SplashDescriptionRoute extends _i3.PageRouteInfo<void> {
  const SplashDescriptionRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SplashDescriptionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashDescriptionRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.SplashDescriptionView();
    },
  );
}

/// generated route for
/// [_i2.SplashView]
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashView();
    },
  );
}
