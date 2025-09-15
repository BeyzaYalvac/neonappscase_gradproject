import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/presentation/item_details/view/item_detail.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: SplashDescriptionRoute.page),
      AutoRoute(page: HomeRoute.page),
      AutoRoute(page: FavoriteRoute.page),
      AutoRoute(page: UploadRoute.page),
      AutoRoute(page: UploadFileRoute.page),
      AutoRoute(page: ItemDetailRoute.page),
    ];
  }
}
