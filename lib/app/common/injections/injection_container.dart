import 'package:get_it/get_it.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.dart';
import 'package:neonappscase_gradproject/app/data/datasources/account_datasource.dart';
import 'package:neonappscase_gradproject/app/data/datasources/content_datasource.dart';
import 'package:neonappscase_gradproject/app/data/repositories/account_repository.dart';
import 'package:neonappscase_gradproject/app/data/repositories/content_repository.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_cubit.dart';

class InjectionContainer {
  InjectionContainer._();

  static final _instance = GetIt.instance;

  static void setUp() {
    if (!_instance.isRegistered<AppRouter>()) {
      _instance.registerSingleton<AppRouter>(AppRouter());
    }
    if (!_instance.isRegistered<AccountDatasource>()) {
      _instance.registerSingleton<AccountDatasource>(AccountDatasource());
    }
    if (!_instance.isRegistered<AccountRepository>()) {
      _instance.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(),
      );
    }

    if (!_instance.isRegistered<ContentDataSource>()) {
      _instance.registerLazySingleton<ContentDataSource>(
        () => ContentDataSource(),
      );

      if (!_instance.isRegistered<ContentRepository>()) {
        _instance.registerSingleton<ContentRepository>(ContentRepositoryImpl());
      }
    }

    if (!_instance.isRegistered<HomeCubit>()) {
      _instance.registerFactory<HomeCubit>(() => HomeCubit());
    }
    if (!_instance.isRegistered<FavoriteCubit>()) {
      _instance.registerFactory<FavoriteCubit>(() => FavoriteCubit());
    }
    if (!_instance.isRegistered<UploadCubit>()) {
      _instance.registerFactory<UploadCubit>(() => UploadCubit());
    }
    if (!_instance.isRegistered<NetworkCubit>()) {
      _instance.registerFactory<NetworkCubit>(() => NetworkCubit());
    }
    if (!_instance.isRegistered<ProfileCubit>()) {
      _instance.registerFactory<ProfileCubit>(() => ProfileCubit());
    }
  }

  static T read<T extends Object>() => _instance<T>();
}
