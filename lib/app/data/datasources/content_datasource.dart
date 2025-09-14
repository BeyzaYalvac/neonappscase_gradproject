import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/core/dio_manager/api_client.dart';

class ContentDataSource {
  final api = ApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConfig.bearerToken}',
    },
  ).safe;

  // 2) Upload için ayrı client (upload.gofile.io)
  final uploadApi = ApiClient(
    baseUrl: 'https://upload.gofile.io',
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConfig.bearerToken}',
    },
  ).safe;

  Future<void> getContent() async {
    final Map<String, dynamic> accountData = await InjectionContainerItems
        .appAccountDataSource
        .fetchAccountDetails();
    debugPrint(accountData.toString());
    final String rootFolder = accountData['data']['rootFolder'];
    debugPrint(rootFolder);
    final res = await api.get<Map<String, dynamic>>('/contents/${rootFolder}');
    print(res.data);
    if (res.isSuccess && res.data != null) {
      final data = res.data;
      debugPrint(data.toString());
    } else if (res.isFailure) {
      debugPrint('Hata durumu: ${res.error?.message ?? 'Bilinmeyen hata'}');
    } else if (res.isFailure && res.error?.message == null) {
      debugPrint('Hata durumu: Bilinmeyen hata');
    } else {
      throw Exception(res.error?.message ?? 'Bilinmeyen hata');
    }
  }

  Future<Map<String, dynamic>> uploadImageContent(
    File file, {
    String? folderId,
  }) async {
    // multipart form
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : 'upload.bin',
      ),
      if (folderId != null && folderId.isNotEmpty) 'folderId': folderId,
    });

    final res = await uploadApi.post<Map<String, dynamic>>(
      '/uploadfile',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Authorization': 'Bearer ${AppConfig.bearerToken}'},
      ),
    );

    // Teşhis için status/body
    debugPrint('POST /uploadfile status: ${res.data.toString()}');

    if (res.isSuccess && res.data != null) {
      final data = res.data!['data'] as Map<String, dynamic>;
      // data: { id, name, size, mimetype, parentFolder, parentFolderCode, downloadPage, md5, servers, ... }
      debugPrint('Upload OK: $data');
      return data;
    } else {
      throw Exception(res.error?.message ?? 'Bilinmeyen hata');
    }
  }

  Future<Map<String, dynamic>> uploadFileContent(
    File file, {
    String? folderId,
  }) async {
    // multipart form
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : 'upload.bin',
      ),
      if (folderId != null && folderId.isNotEmpty) 'folderId': folderId,
    });

    final res = await uploadApi.post<Map<String, dynamic>>(
      '/uploadfile',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Authorization': 'Bearer ${AppConfig.bearerToken}'},
      ),
    );

    // Teşhis için status/body
    debugPrint('POST /uploadfile status: ${res.data.toString()}');

    if (res.isSuccess && res.data != null) {
      final data = res.data!['data'] as Map<String, dynamic>;
      // data: { id, name, size, mimetype, parentFolder, parentFolderCode, downloadPage, md5, servers, ... }
      debugPrint('Upload OK: $data');
      return data;
    } else {
      throw Exception(res.error?.message ?? 'Bilinmeyen hata');
    }
  }

}
