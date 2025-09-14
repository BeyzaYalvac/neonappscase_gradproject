import 'dart:io';

import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';

abstract class AccountRepository {
  Future<Map<String, dynamic>> fetchAccountDetails();
  Future<String> fetchAccountId();
}

class AccountRepositoryImpl extends AccountRepository {
  @override
  Future<Map<String, dynamic>> fetchAccountDetails() async {
    return InjectionContainerItems.appAccountDataSource.fetchAccountDetails();
  }

  @override
  Future<String> fetchAccountId() {
    return InjectionContainerItems.appAccountDataSource.fetchAccountId();
  }
  
 
}
