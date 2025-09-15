import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/domain/model/create_folder_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_file_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_server_model.dart';
import 'package:neonappscase_gradproject/core/dio_manager/api_client.dart';
import 'package:path/path.dart' as p;

class ContentDataSource {
  // API (hesap/folder/file list vb. için)
  final api = ApiClient(
    baseUrl: AppConfig.apiBaseUrl, // örn: https://api-v2.ddownload.com/api
    headers: {'Accept': 'application/json'},
  ).safe;

  // Upload için ayrı client
  late var uploadApi = ApiClient(
    baseUrl: '', // seçilen upload server geldikten sonra set edilecek
    headers: {'Accept': 'application/json'},
  ).safe;

  /// 1) Yükleme sunucusunu seç
  Future<UploadServerModel> selectServerForUpload() async {
    final res = await api.get<Map<String, dynamic>>(
      '/upload/server',
      query: {'key': AppConfig.apiKey},
    );

    if (res.isSuccess && res.data != null) {
      final model = UploadServerModel.fromMap(res.data!);

      // uploadApi’yi bu URL ile yeniden kuruyoruz
      uploadApi = ApiClient(
        baseUrl: model.result, // örn: https://wwwNNN.ucdn.to/cgi-bin/upload.cgi
        headers: {'Accept': 'application/json'},
      ).safe;

      return model;
    } else {
      throw Exception(res.error?.message ?? 'Bilinmeyen hata');
    }
  }

  /// 2) Dosya yükle
  /// ddownload upload genelde multipart/form-data ister.
  /// Alan adı dokümana göre değişebilir: 'file', 'files[]', vs.
  Future<List<UploadFileModel>> uploadFile({
    required File file,
    int? targetFolderId, // gerekiyorsa form alanı ile gönder
  }) async {
    final uploadServer = await selectServerForUpload();

    // FormData hazırla (alan anahtarı dokümana göre değişebilir)
    final form = FormData.fromMap({
      // 'files[]': await MultipartFile.fromFile(file.path, filename: p.basename(file.path)),
      'file': await MultipartFile.fromFile(
        file.path,
        filename: p.basename(file.path),
      ),
      // Bazı servislerde sess_id form alanı olarak gerekir:
      'sess_id': uploadServer.sessId,
      // Klasöre yüklemek gerekiyorsa (dokümana bağlı):
      if (targetFolderId != null) 'fld_id': targetFolderId.toString(),
    });

    // uploadApi’nin baseUrl’i tam URL olduğundan boş path ile POST atıyoruz
    final resp = await uploadApi.post<dynamic>(
      '',
      data: form,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (resp.isSuccess && resp.data != null) {
      // Bu API bazı örneklerde upload sonrası dizi döndürüyor: [{file_code, file_status}]
      final data = resp.data;
      if (data is List) {
        return data
            .map((e) => UploadFileModel.fromMap(e as Map<String, dynamic>))
            .toList();
      } else if (data is Map<String, dynamic>) {
        // Tek obje dönerse
        return [UploadFileModel.fromMap(data)];
      } else {
        throw Exception('Beklenmeyen upload yanıtı');
      }
    } else {
      throw Exception(resp.error?.message ?? 'Upload başarısız');
    }
  }

  /// 3) Klasör içeriğini getir (root için fld_id=0 kullan)
  /// 1) Klasör içeriğini getir (root için fld_id=0 kullan)
  Future<List<FileFolderListModel>> getFolderList({int fldId = 0}) async {
    final res = await api.get<Map<String, dynamic>>(
      '/folder/list',
      query: {'key': AppConfig.apiKey, 'fld_id': fldId.toString()},
    );

    if (res.isSuccess && res.data != null) {
      final data = res.data!;
      // ddownload: { msg, status, result: { folders: [...], files: [...] } }
      final result = data['result'] as Map<String, dynamic>? ?? const {};
      final folders = (result['folders'] as List?) ?? const [];

      return folders
          .whereType<Map<String, dynamic>>()
          .map((e) => FileFolderListModel.fromMap(e))
          .toList();
    } else {
      throw Exception(res.error?.message ?? 'Klasör listesi alınamadı');
    }
  }

  /// 2) Dosya listesini getir (seçilen klasöre göre)
  Future<List<FileItem>> getFileList({
    required int fldId,
    int page = 1,
    int perPage = 20,
    int? isPublic,
    String? createdAfter,
    String? nameFilter,
  }) async {
    final res = await api.get<dynamic>(
      '/file/list',
      query: {
        'key': AppConfig.apiKey,
        'page': '$page',
        'per_page': '$perPage',
        'fld_id': '$fldId',
        if (isPublic != null) 'public': '$isPublic',
        if (createdAfter != null) 'created': createdAfter,
        if (nameFilter != null && nameFilter.isNotEmpty) 'name': nameFilter,
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.error?.message ?? 'Dosya listesi alınamadı');
    }

    final data = res.data;
    // Güvenli loglar:
    debugPrint('file/list dataType=${data.runtimeType}');
    // debugPrint('file/list body=$data'); // istersen aç

    if (data is Map<String, dynamic>) {
      final status = data['status'];
      if (status == 200 || status == '200' || status == 'ok') {
        final result = data['result'];
        final filesJson = (result is Map && result['files'] is List)
            ? (result['files'] as List).whereType<Map<String, dynamic>>()
            : const <Map<String, dynamic>>[];

        final items = filesJson
            .map((e) => FileItem.fromMap(e, fldIdOverride: fldId))
            .toList();

        debugPrint('Parsed files count: ${items.length}');
        return items;
      } else {
        throw Exception(
          '${status}: ${data['msg'] ?? data['message'] ?? 'Bilinmeyen hata'}',
        );
      }
    }

    // Bazı durumlarda düz liste gelebilir; yine de destekle:
    if (data is List) {
      final items = data
          .whereType<Map<String, dynamic>>()
          .map((e) => FileItem.fromMap(e, fldIdOverride: fldId))
          .toList();
      debugPrint('Parsed files count (list root): ${items.length}');
      return items;
    }

    return const <FileItem>[];
  }

  /// 5) Klasör oluştur
  Future<CreateFolderModel> createFolder(
    String folderName,
    String selectedFolderId,
  ) async {
    final res = await api.get<Map<String, dynamic>>(
      '/folder/create',
      query: {
        'key': AppConfig.apiKey,
        'parent_id': selectedFolderId,
        'name': folderName,
      },
    );

    if (res.isSuccess && res.data != null) {
      final model = CreateFolderModel.fromMap(res.data!);
      debugPrint('Klasör Oluşturma: $model');
      return model;
    } else {
      throw Exception(res.error?.message ?? 'Bilinmeyen hata');
    }
  }
}
