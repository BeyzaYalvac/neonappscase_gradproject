import 'package:equatable/equatable.dart';

class UploadFileModel extends Equatable {
  final String fileCode;
  final String fileStatus;

  const UploadFileModel({
    required this.fileCode,
    required this.fileStatus,
  });

  factory UploadFileModel.fromMap(Map<String, dynamic> map) {
    return UploadFileModel(
      fileCode: map['file_code']?.toString() ?? '',
      fileStatus: map['file_status']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'file_code': fileCode,
      'file_status': fileStatus,
    };
  }

  @override
  List<Object?> get props => [fileCode, fileStatus];
}
