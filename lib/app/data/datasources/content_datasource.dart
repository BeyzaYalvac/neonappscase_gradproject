import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';
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

  final contentBox = Hive.box<ContentModel>('contentsBox');

Future<List<ContentModel>> getContentsByType(String type) async {
  final box = Hive.box<ContentModel>('contentsBox');

  ContentType? mapType(String t) {
    switch (t.toLowerCase()) {
      case 'folder':
        return ContentType.folder;
      case 'file':
        return ContentType.file;
      case 'image':
        return ContentType.image;
      case 'video':
        return ContentType.video;
      default:
        return null;
    }
  }

  final ContentType? targetType = mapType(type);

  if (targetType == null) {
    // bilinmeyen type
    return [];
  }

  // filtreleme
  final results = box.values.where((c) => c.type == targetType).toList();

  return results;
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

  Future<void> createFolder(String folderName) async {
    try {
      // 1) Hesap bilgisi -> rootFolderId'yi al
      final account = await InjectionContainerItems.appAccountDataSource
          .fetchAccountDetails(); // AccountModel
      // account.data.rootFolder gibi bir alanın olmalı (daha önce öyleydi)
      final String parentFolderId = account.rootFolder;

      // 2) Doğru JSON alan adları ve JSON content-type
      final res = await api.post<Map<String, dynamic>>(
        '/contents/createFolder',
        data: {
          'parentFolderId': parentFolderId, // ✅ doğru anahtar
          'folderName': folderName, // ✅ doğru anahtar
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (res.isSuccess && res.data != null) {
        final folderModel = ContentModel.fromGofileFolder(res.data!);
        await contentBox.put(folderModel.id, folderModel);
        debugPrint("klasörHive: ${contentBox.values.toList()}");
        debugPrint('Klasör oluşturuldu: ${res.data}');
      } else {
        debugPrint(
          'Klasör oluşturulamadı: ${res.error?.message ?? 'Bilinmeyen hata'}',
        );
      }
    } catch (e) {
      debugPrint('Hata oluştu: $e');
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
