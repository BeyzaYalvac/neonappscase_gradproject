import 'package:neonappscase_gradproject/app/common/router/app_router.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container.dart';
import 'package:neonappscase_gradproject/app/data/datasources/account_datasource.dart';
import 'package:neonappscase_gradproject/app/data/datasources/content_datasource.dart';
import 'package:neonappscase_gradproject/app/data/repositories/account_repository.dart';
import 'package:neonappscase_gradproject/app/data/repositories/content_repository.dart';

final class InjectionContainerItems {
  const InjectionContainerItems._();

  static AppRouter get appRouter => InjectionContainer.read<AppRouter>();
  static AccountDatasource get appAccountDataSource =>
      InjectionContainer.read<AccountDatasource>();
  static AccountRepositoryImpl get appAccountRepository =>
      InjectionContainer.read<AccountRepositoryImpl>();
  static ContentDataSource get contentDataSource =>
      InjectionContainer.read<ContentDataSource>();
  static ContentRepository get contentRepository =>
      InjectionContainer.read<ContentRepositoryImpl>();
}
