import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'upload_state.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final ImagePicker _picker = ImagePicker();
  UploadCubit() : super(UploadState.initial());

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(imageFile: image, error: null));
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(imageFile: image, error: null));
    }
  }

  /// Sadece galeriden seçip YÜKLER (tek adım)
  Future<void> uploadImageFromGallery({int? folderId}) async {
    await pickFromGallery();
    final img = state.imageFile;
    if (img == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final model = await InjectionContainerItems.contentRepository
          .uploadFileContent(File(img.path), folderId: folderId);

      // Doğru doğrulama:
      final info = await InjectionContainerItems.contentDataSource.getFileInfo(
        model.fileCode,
      ); // veya 65a3yjb8tsiu
      debugPrint(
        'INFO fld_id=${info['fld_id']}, owner=${info['owner'] ?? info['account_id']}, public=${info['public']}',
      );

      debugPrint('Doğrulandı => ${info['file_code'] ?? info['fileCode']}');
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Sadece kamera ile çekip YÜKLER
  Future<void> uploadImageFromCamera({int? folderId}) async {
    await pickFromCamera();
    final img = state.imageFile;
    if (img == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    try {
      await InjectionContainerItems.contentRepository.uploadFileContent(
        File(img.path),
        folderId: folderId,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Dosya yöneticisinden (pdf/doc/xls/jpg/png) seçer
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'ppt',
        'pptx',
        'xls',
        'xlsx',
        'txt',
        'jpg',
        'png',
      ],
      allowMultiple: false,
      withData: true, // web’de path olmayabilir -> bytes gelir
    );
    if (result == null) return; // kullanıcı iptal
    emit(state.copyWith(pickedFile: result.files.single, error: null));
  }

  /// Dosya yöneticisinden seçip YÜKLER
  Future<void> uploadFile({int? folderId}) async {
    await _pickFile();
    final pf = state.pickedFile;
    if (pf == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    try {
      File fileToUpload;

      if (pf.path != null) {
        // Android/iOS native: path var
        fileToUpload = File(pf.path!);
      } else if (pf.bytes != null) {
        // path yoksa (özellikle web), bytes'ı temp'e yaz
        final tmp = File('${Directory.systemTemp.path}/${pf.name}');
        await tmp.writeAsBytes(pf.bytes!);
        fileToUpload = tmp;
      } else {
        throw Exception('Dosya path ve bytes null.');
      }

      await InjectionContainerItems.contentRepository.uploadFileContent(
        fileToUpload,
        folderId: folderId,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
