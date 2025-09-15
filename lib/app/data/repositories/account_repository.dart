
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_stats_model.dart';

abstract class AccountRepository {
  Future<AccountModel> fetchAccountDetails();
  Future<AccountStatsModel> fetchAccountStats();
  
}

class AccountRepositoryImpl extends AccountRepository {
  @override
  Future<AccountModel> fetchAccountDetails() async {
    return InjectionContainerItems.appAccountDataSource.fetchAccountDetails();
  }

  @override
  Future<AccountStatsModel> fetchAccountStats() {
    return InjectionContainerItems.appAccountDataSource.fetchAccountStats();
  }
  
 
}
