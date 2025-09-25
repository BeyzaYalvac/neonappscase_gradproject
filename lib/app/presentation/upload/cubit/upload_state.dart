import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

enum UploadStatus { uploading, success, failure }

class UploadState extends Equatable {
  final UploadStatus status;
  final XFile? imageFile;
  final PlatformFile? pickedFile; // pdf/doc/xls vs.
  final String? error;
  final bool isLoading;

  const UploadState({
    this.imageFile,
    this.pickedFile,
    this.error,
    this.isLoading = false,
    this.status = UploadStatus.success,
  });

  factory UploadState.initial() => const UploadState(isLoading: false);

  UploadState copyWith({
    XFile? imageFile,
    PlatformFile? pickedFile,
    String? error,
    bool? isLoading,
    UploadStatus? status,
  }) {
    return UploadState(
      imageFile: imageFile ?? this.imageFile,
      pickedFile: pickedFile ?? this.pickedFile,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    imageFile?.path,
    pickedFile?.name,
    pickedFile?.size,
    isLoading,
    error,
    status,
  ];
}
