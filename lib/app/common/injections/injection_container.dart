import 'package:get_it/get_it.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.dart';
import 'package:neonappscase_gradproject/app/data/datasources/account_datasource.dart';
import 'package:neonappscase_gradproject/app/data/datasources/content_datasource.dart';
import 'package:neonappscase_gradproject/app/data/repositories/account_repository.dart';
import 'package:neonappscase_gradproject/app/data/repositories/content_repository.dart';

class InjectionContainer {
  InjectionContainer._();

  static final _instance = GetIt.instance;

  static void setUp() {
    if (!_instance.isRegistered<AppRouter>()) {
      _instance.registerSingleton<AppRouter>(AppRouter());
    }
    if (!_instance.isRegistered<AccountDatasource>()) {
      _instance.registerSingleton<AccountDatasource>(
        AccountDatasource()..fetchAccountDetails(),
      );
    }
    if (!_instance.isRegistered<AccountRepositoryImpl>()) {
      _instance.registerSingleton<AccountRepositoryImpl>(
        AccountRepositoryImpl()..fetchAccountDetails(),
      );
    }
    
    if (!_instance.isRegistered<ContentDataSource>()) {
      _instance.registerLazySingleton<ContentDataSource>(
        () => ContentDataSource(),
      );
    }

    if (!_instance.isRegistered<ContentRepositoryImpl>()) {
      _instance.registerSingleton<ContentRepositoryImpl>(
        ContentRepositoryImpl(),
      );
    }
    
  }

  static T read<T extends Object>() => _instance<T>();
}
