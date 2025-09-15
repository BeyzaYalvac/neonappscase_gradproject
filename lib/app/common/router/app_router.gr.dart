// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:neonappscase_gradproject/app/presentation/favorite/view/favorite_view.dart'
    as _i1;
import 'package:neonappscase_gradproject/app/presentation/home/view/home_view.dart'
    as _i2;
import 'package:neonappscase_gradproject/app/presentation/item_details/view/item_detail.dart'
    as _i3;
import 'package:neonappscase_gradproject/app/presentation/splash/view/splash_description_view.dart'
    as _i4;
import 'package:neonappscase_gradproject/app/presentation/splash/view/splash_view.dart'
    as _i5;
import 'package:neonappscase_gradproject/app/presentation/upload/view/upload_file_view.dart'
    as _i6;
import 'package:neonappscase_gradproject/app/presentation/upload/view/upload_image_view.dart'
    as _i7;

/// generated route for
/// [_i1.FavoriteView]
class FavoriteRoute extends _i8.PageRouteInfo<void> {
  const FavoriteRoute({List<_i8.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.FavoriteView();
    },
  );
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeView();
    },
  );
}

/// generated route for
/// [_i3.ItemDetailView]
class ItemDetailRoute extends _i8.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i9.Key? key,
    required dynamic item,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ItemDetailRoute.name,
          args: ItemDetailRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemDetailRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemDetailRouteArgs>();
      return _i3.ItemDetailView(
        key: args.key,
        item: args.item,
      );
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({
    this.key,
    required this.item,
  });

  final _i9.Key? key;

  final dynamic item;

  @override
  String toString() {
    return 'ItemDetailRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i4.SplashDescriptionView]
class SplashDescriptionRoute extends _i8.PageRouteInfo<void> {
  const SplashDescriptionRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashDescriptionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashDescriptionRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashDescriptionView();
    },
  );
}

/// generated route for
/// [_i5.SplashView]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashView();
    },
  );
}

/// generated route for
/// [_i6.UploadFileView]
class UploadFileRoute extends _i8.PageRouteInfo<void> {
  const UploadFileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          UploadFileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UploadFileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.UploadFileView();
    },
  );
}

/// generated route for
/// [_i7.UploadView]
class UploadRoute extends _i8.PageRouteInfo<void> {
  const UploadRoute({List<_i8.PageRouteInfo>? children})
      : super(
          UploadRoute.name,
          initialChildren: children,
        );

  static const String name = 'UploadRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.UploadView();
    },
  );
}
