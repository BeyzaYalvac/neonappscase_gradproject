// lib/app/domain/repository/content_repository.dart
import 'dart:io';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/create_folder_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/domain/model/upload_file_model.dart';

abstract class ContentRepository {
  /// Root (veya belirtilen) klasörün içeriğini getirir
  Future<List<FileFolderListModel>> getFolderList({int fldId = 0});

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
  Future<CreateFolderModel> createFolder(
    String folderName,
    String selectedFolderId,
  );
}

class ContentRepositoryImpl extends ContentRepository {
  @override
  Future<List<FileFolderListModel>> getFolderList({int fldId = 0}) {
    return InjectionContainerItems.contentDataSource.getFolderList(
      fldId: fldId,
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
  Future<CreateFolderModel> createFolder(
    String folderName,
    String selectedFolderId,
  ) {
    return InjectionContainerItems.contentDataSource.createFolder(
      folderName,
      selectedFolderId,
    );
  }
}
