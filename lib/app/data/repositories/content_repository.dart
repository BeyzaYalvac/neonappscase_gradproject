import 'dart:io';

import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';

abstract class ContentRepository {
  Future<void> getContent();
  Future<Map<String, dynamic>> uploadImageContent(
    File file, {
    String? folderId,
  });
  Future<Map<String, dynamic>> uploadFileContent(File file, {
    String? folderId,
  });
}

class ContentRepositoryImpl extends ContentRepository {
  @override
  Future<void> getContent() async {
    final data = await InjectionContainerItems.contentDataSource.getContent();
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
}
