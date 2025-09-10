// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:neonappscase_gradproject/app/common/presentation/home/view/home_view.dart'
    as _i1;
import 'package:neonappscase_gradproject/app/common/presentation/splash/view/splash_description_view.dart'
    as _i2;
import 'package:neonappscase_gradproject/app/common/presentation/splash/view/splash_view.dart'
    as _i3;

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeView();
    },
  );
}

/// generated route for
/// [_i2.SplashDescriptionView]
class SplashDescriptionRoute extends _i4.PageRouteInfo<void> {
  const SplashDescriptionRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashDescriptionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashDescriptionRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashDescriptionView();
    },
  );
}

/// generated route for
/// [_i3.SplashView]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashView();
    },
  );
}
