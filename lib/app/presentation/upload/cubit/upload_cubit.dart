import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final ImagePicker _picker = ImagePicker();
  UploadCubit() : super(UploadState.initial());

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(file: image));
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(file: image));
    }
  }

  void UploadImage() async {
    await pickFromGallery();

    if (state.imageFile != null) {
      emit(state.copyWith(isLoading: true));
      await InjectionContainerItems.contentRepository.uploadImageContent(
        File(state.imageFile!.path),
      );
      emit(state.copyWith(isLoading: false));
    }
  }

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
      withData: true, // path'in olmadığı (özellikle web) durumlar için
    );
    if (result == null) return; // kullanıcı iptal etti

    final file = result.files.single;
    // debug:
    // debugPrint('name: ${file.name} / ext: ${file.extension} / size: ${file.size} / path: ${file.path}');
    emit(state.copyWith(pickedFile: file));
  }

  void uploadFile() async {
    await _pickFile();
    emit(state.copyWith(pickedFile: state.pickedFile));
    if (state.pickedFile != null) {
      emit(state.copyWith(isLoading: true));
      await InjectionContainerItems.contentRepository.uploadImageContent(
        File(state.pickedFile!.path!),
      );
      emit(state.copyWith(isLoading: false));
    }
  }
}
