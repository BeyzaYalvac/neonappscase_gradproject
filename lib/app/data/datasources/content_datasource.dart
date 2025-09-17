import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/domain/model/create_folder_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_file_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_server_model.dart';
import 'package:neonappscase_gradproject/core/dio_manager/api_client.dart';

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
    if (!res.isSuccess || res.data == null) {
      throw Exception(res.error?.message ?? 'Sunucu seçilemedi');
    }

    final model = UploadServerModel.fromMap(res.data!);

    // Örn: https://wwwNNN.ucdn.to/cgi-bin/upload.cgi
    uploadApi = ApiClient(
      baseUrl: model.result,
      headers: {'Accept': 'application/json'},
    ).safe;

    print("model.result: ${model.result}");
    return model;
  }

  Future<List<FileFolderListModel>> getFolderList({int fldId = 0}) async {
    final res = await api.get<Map<String, dynamic>>(
      '/folder/list',
      query: {'key': AppConfig.apiKey, 'fld_id': fldId.toString()},
    );
    if (res.isSuccess && res.data != null) {
      final data = res
          .data!; // ddownload: { msg, status, result: { folders: [...], files: [...] } }
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

  //load: { msg, status, result: { folders: [...], files: [...] } } final result = data['result'] as Map<String, dynamic>? ?? const {}; final folders = (result['folders'] as List?) ?? const []; return folders .whereType<Map<String, dynamic>>() .map((e) => FileFolderListModel.fromMap(e)) .toList(); } else { throw Exception(res.error?.message ?? 'Klasör listesi alınamadı'); } }
  Future<Map<String, dynamic>> getFileInfo(String fileCode) async {
    final res = await api.get<Map<String, dynamic>>(
      '/file/info',
      query: {'key': AppConfig.apiKey, 'file_code': fileCode},
    );
    if (!res.isSuccess || res.data == null) {
      throw Exception(res.error?.message ?? 'file/info alınamadı');
    }
    final data = res.data!;
    // Tipik ddownload cevabı: { status, msg, result: { file: {...} } } / varyasyon olabilir
    final result = (data['result'] as Map?) ?? const {};
    final file =
        (result['file'] as Map?) ??
        result; // bazı sunucular direkt file objesi döndürür
    debugPrint('FILE INFO => $file');
    return file.cast<String, dynamic>();
  }

  Future<int?> detectRootFolderId() async {
    final res = await api.get<Map<String, dynamic>>(
      '/folder/list',
      query: {
        'key': AppConfig.apiKey,
        'fld_id': '0', // sistem "hesabının kökü"nün altını döndürür
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.error?.message ?? 'folder/list alınamadı');
    }

    final data = res.data!;
    final result = data['result'] as Map? ?? const {};
    final folders = (result['folders'] as List?)?.whereType<Map>() ?? const [];

    // Varsayım: Buradaki tüm üst seviye klasörlerin parent_id’si "senin gerçek root id"’indir.
    final parentIds = folders
        .map((f) => int.tryParse('${f['parent_id'] ?? ''}'))
        .whereType<int>()
        .toSet();

    // En sık görülen durum: tek bir parent_id döner -> gerçek root id
    if (parentIds.isNotEmpty) {
      final rootId = parentIds.first;
      debugPrint('DETECTED ROOT ID => $rootId');
      return rootId;
    }

    // Hiç klasör yoksa parent_id çıkaramıyoruz -> null
    debugPrint('DETECTED ROOT ID => (yok - üst seviye klasör bulunamadı)');
    return null;
  }

  Future<UploadFileModel> uploadFile({required File file, String? fldId}) async {
    // 1) Upload server ve sess_id al
    final uploadServerModel = await selectServerForUpload();
    final sessId = uploadServerModel.sessId;
    final uploadUrl = uploadServerModel.result;

    // 2) FormData hazırla
    final formData = FormData.fromMap({
      'sess_id': sessId,
      'utype': 'prem',
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
      if (fldId != null) 'fld_id': fldId,
    });

    print("UPLOAD FORM FIELDS: ${formData.fields}");


    // 3) Post isteğini yap
    final response = await uploadApi.post(uploadUrl, data: formData);

    // 4) Response kontrol et
    if (response.isSuccess && response.data != null) {
      final data = response.data is List ? response.data[0] : response.data;

      if (data['file_status'] != 'OK') {
        throw Exception('Upload failed: ${data['file_status']}');
      }

      return UploadFileModel.fromMap(data);
    } else {
      throw Exception('Upload failed: ${response}');
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
