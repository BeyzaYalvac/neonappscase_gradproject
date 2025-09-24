import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_stats_model.dart';
import 'package:neonappscase_gradproject/core/dio_manager/api_client.dart';

class AccountDatasource {
  final api = ApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    headers: {
      'Accept': 'application/json',
    },
  ).safe;

  Future<AccountModel> fetchAccountDetails() async {
    final resForFetchAcount = await api.get<Map<String, dynamic>>(
      '/account/info?key=${AppConfig.apiKey}',
    );

    if (resForFetchAcount.isSuccess && resForFetchAcount.data != null) {
      final data = resForFetchAcount.data;
      //debugPrint(data.toString());
       final core = (data?['data'] is Map<String, dynamic>)
        ? (data?['data'] as Map<String, dynamic>)
        : data;
        final model = AccountModel.fromMap(core!);
      return model;
    } else {
      throw Exception(resForFetchAcount.error?.message ?? 'Bilinmeyen hata');
    }
  }

  Future<AccountStatsModel> fetchAccountStats() async {
    final resresForFetchAcountId = await api.get<Map<String, dynamic>>(
      '/account/stats?key=${AppConfig.apiKey}&last=7',
    );
    if (resresForFetchAcountId.isSuccess &&
        resresForFetchAcountId.data != null) {
      final data = resresForFetchAcountId.data;
      if (data != null) {
        debugPrint(data.toString());
        final core = (data['data'] is Map<String, dynamic>)
            ? (data['data'] as Map<String, dynamic>)
            : data;
        final model = AccountStatsModel.fromMap(core);
        return model;
      }
      debugPrint(data.toString());
      //Boş dönerse
      return AccountStatsModel.fromMap({});
    } else {
      throw Exception(
        resresForFetchAcountId.error?.message ?? 'Bilinmeyen hata',
      );
    }
  }
}
