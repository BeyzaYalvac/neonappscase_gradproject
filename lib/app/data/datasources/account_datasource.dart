import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/core/dio_manager/api_client.dart';

class AccountDatasource {
  final api = ApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConfig.bearerToken}',
    },
  ).safe;

  Future<Map<String, dynamic>> fetchAccountDetails() async {
    String accountId= await fetchAccountId();
    final resForFetchAcount = await api.get<Map<String, dynamic>>(
      '/accounts/${accountId}',
    );

    if (resForFetchAcount.isSuccess && resForFetchAcount.data != null) {
      final data = resForFetchAcount.data;
      debugPrint(data.toString());
      return data!;
    } else {
      throw Exception(resForFetchAcount.error?.message ?? 'Bilinmeyen hata');
    }
  }

  Future<String> fetchAccountId() async {
    final resresForFetchAcountId = await api.get<Map<String, dynamic>>(
      '/accounts/getid',
    );
    if (resresForFetchAcountId.isSuccess &&
        resresForFetchAcountId.data != null) {
      final data = resresForFetchAcountId.data;
      if (data != null) {
        final String id = (data['data'] as Map?)?['id'] as String;
        debugPrint(id);
        return id;
      }
      debugPrint(data.toString());
      return 'Bulunamadı';
    } else {
      throw Exception(
        resresForFetchAcountId.error?.message ?? 'Bilinmeyen hata',
      );
    }
  }
}
