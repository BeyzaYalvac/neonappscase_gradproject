import 'package:neonappscase_gradproject/app/common/router/app_router.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container.dart';
import 'package:neonappscase_gradproject/app/common/theme/cubit/theme_cubit.dart';
import 'package:neonappscase_gradproject/app/data/datasources/account_datasource.dart';
import 'package:neonappscase_gradproject/app/data/datasources/content_datasource.dart';
import 'package:neonappscase_gradproject/app/data/repositories/account_repository.dart';
import 'package:neonappscase_gradproject/app/data/repositories/content_repository.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_cubit.dart';

final class InjectionContainerItems {
  const InjectionContainerItems._();

  static AppRouter get appRouter => InjectionContainer.read<AppRouter>();
  static AccountDatasource get appAccountDataSource =>
      InjectionContainer.read<AccountDatasource>();
  static AccountRepository get appAccountRepository =>
      InjectionContainer.read<AccountRepository>();
  static ContentDataSource get contentDataSource =>
      InjectionContainer.read<ContentDataSource>();
  static ContentRepository get contentRepository =>
      InjectionContainer.read<ContentRepository>();

  static HomeCubit get homeCubit => InjectionContainer.read<HomeCubit>();
  static FavoriteCubit get favoriteCubit =>
      InjectionContainer.read<FavoriteCubit>();
  static UploadCubit get uploadCubit => InjectionContainer.read<UploadCubit>();
  static NetworkCubit get networkCubit =>
      InjectionContainer.read<NetworkCubit>();
  static ThemeCubit get themeCubit => InjectionContainer.read<ThemeCubit>();
  static ProfileCubit get profileCubit =>
      InjectionContainer.read<ProfileCubit>();
}
