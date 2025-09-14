import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class UploadState extends Equatable {
  final XFile? imageFile;
  final PlatformFile? pickedFile; // Dosya yöneticisi (pdf/doc/xls ...)
  final String? error;

  final bool isLoading;

  const UploadState({
    this.imageFile,
    this.isLoading = false,
    this.pickedFile,
    this.error,
  });

  factory UploadState.initial() => const UploadState(isLoading: false);

  UploadState copyWith({
    XFile? file,
    bool? isLoading,
    PlatformFile? pickedFile,
  }) {
    return UploadState(
      imageFile: file ?? this.imageFile,
      isLoading: isLoading ?? this.isLoading,
      pickedFile: pickedFile ?? this.pickedFile,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    imageFile?.path,
    pickedFile?.name,
    pickedFile?.size,
    isLoading,
    error,
  ];
}
