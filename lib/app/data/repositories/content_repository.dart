// lib/app/domain/repository/content_repository.dart
import 'dart:io';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/folder_process_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_file_model.dart';

abstract class ContentRepository {
  /// Root (veya belirtilen) klasörün içeriğini getirir
  Future<List<FileFolderListModel>> getFolderList({
    int fldId = 0,
    bool bustCache = false, // 👈 eklendi
  });

  /// Sadece dosya listesini (API'nin /file/list sonucunu) getirir
  Future<List<FileItem>> getFileList({
    required int fldId, // root için 0
    int page = 1,
    int perPage = 20,
    int? isPublic,
    String? createdAfter,
    String? nameFilter,
  });

  /// Dosya yükle (opsiyonel klasöre)
  Future<UploadFileModel> uploadFileContent(File file, {String? folderId});

  /// Klasör oluştur
  Future<FolderProcessModel> createFolder(
    String folderName,
    String selectedFolderId,
  );

  Future<void> downloadFile(String fileUrl);

  Future<FolderProcessModel> renameFolder(String folderId, String name);
}

class ContentRepositoryImpl extends ContentRepository {
  @override
  Future<List<FileFolderListModel>> getFolderList({
    int fldId = 0,
    bool bustCache = false, // 👈 eklendi
  }) {
    return InjectionContainerItems.contentDataSource.getFolderList(
      fldId: fldId,
      bustCache: bustCache, // 👈 passthrough
    );
  }

  @override
  Future<List<FileItem>> getFileList({
    required int fldId,
    int page = 1,
    int perPage = 20,
    int? isPublic,
    String? createdAfter,
    String? nameFilter,
  }) {
    return InjectionContainerItems.contentDataSource.getFileList(
      fldId: fldId,
      page: page,
      perPage: perPage,
      isPublic: isPublic,
      createdAfter: createdAfter,
      nameFilter: nameFilter,
    );
  }

  @override
  Future<UploadFileModel> uploadFileContent(File file, {String? folderId}) {
    return InjectionContainerItems.contentDataSource.uploadFile(
      file: file,
      fldId: folderId,
    );
  }

  @override
  Future<FolderProcessModel> createFolder(
    String folderName,
    String selectedFolderId,
  ) {
    return InjectionContainerItems.contentDataSource.createFolder(
      folderName,
      selectedFolderId,
    );
  }

  @override
  Future<void> downloadFile(String fileUrl) {
    return InjectionContainerItems.contentDataSource.downloadFile(fileUrl);
  }

  @override
  Future<FolderProcessModel> renameFolder(String folderId, String name9) {
    return InjectionContainerItems.contentDataSource.renameFolder(
      folderId,
      name9,
    );
  }
}
