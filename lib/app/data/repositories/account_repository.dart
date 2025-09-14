
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

abstract class AccountRepository {
  Future<AccountModel> fetchAccountDetails();
  Future<String> fetchAccountId();
  
}

class AccountRepositoryImpl extends AccountRepository {
  @override
  Future<AccountModel> fetchAccountDetails() async {
    return InjectionContainerItems.appAccountDataSource.fetchAccountDetails();
  }

  @override
  Future<String> fetchAccountId() {
    return InjectionContainerItems.appAccountDataSource.fetchAccountId();
  }
  
 
}
