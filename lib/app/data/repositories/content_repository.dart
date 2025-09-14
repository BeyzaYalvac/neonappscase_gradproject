import 'dart:io';

import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';

abstract class ContentRepository {
  Future<void> getContent();
  Future<Map<String, dynamic>> uploadImageContent(
    File file, {
    String? folderId,
  });
  Future<Map<String, dynamic>> uploadFileContent(File file, {String? folderId});
  Future<void> createFolder(String folderName);
  Future<List<ContentModel>> getContentsByType(String type);
}

class ContentRepositoryImpl extends ContentRepository {
  @override
  Future<void> getContent() async {
    //await InjectionContainerItems.contentDataSource.getContent();
  }

  @override
  Future<Map<String, dynamic>> uploadImageContent(
    File file, {
    String? folderId,
  }) {
    return InjectionContainerItems.contentDataSource.uploadImageContent(
      file,
      folderId: folderId,
    );
  }

  @override
  Future<Map<String, dynamic>> uploadFileContent(
    File file, {
    String? folderId,
  }) {
    return InjectionContainerItems.contentDataSource.uploadFileContent(
      file,
      folderId: folderId,
    );
  }

  @override
  Future<void> createFolder(String folderName) {
    return InjectionContainerItems.contentDataSource.createFolder(folderName);
  }

  @override
  Future<List<ContentModel>> getContentsByType(String type) {
    return InjectionContainerItems.contentDataSource.getContentsByType(type);
  }
}
