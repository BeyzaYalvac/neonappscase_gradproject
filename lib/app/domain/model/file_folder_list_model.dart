import 'package:equatable/equatable.dart';

class FileFolderListModel extends Equatable {
  final String name;
  final String fldId;

  const FileFolderListModel({required this.name, required this.fldId});

  factory FileFolderListModel.fromMap(Map<String, dynamic> map) {
    return FileFolderListModel(
      name: map['name']?.toString() ?? '',
      fldId: map['fld_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'fld_id': fldId};
  }

  @override
  List<Object?> get props => [name, fldId];
}

class FileItem extends Equatable {
  final String link;
  final String uploaded;
  final String fileCode;
  final int fldId; // <-- int
  final String name;

  const FileItem({
    required this.link,
    required this.uploaded,
    required this.fileCode,
    required this.fldId,
    required this.name,
  });

  factory FileItem.fromMap(Map<String, dynamic> map, {int? fldIdOverride}) {
    int parsedFldId() {
      final raw = map['fld_id'];
      if (raw == null) return fldIdOverride ?? 0;
      if (raw is int) return raw;
      return int.tryParse(raw.toString()) ?? (fldIdOverride ?? 0);
    }

    return FileItem(
      link: map['link']?.toString() ?? '',
      uploaded: map['uploaded']?.toString() ?? '',
      fileCode: map['file_code']?.toString() ?? '',
      fldId: parsedFldId(),
      name: map['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'uploaded': uploaded,
      'file_code': fileCode,
      'fld_id': fldId,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [link, uploaded, fileCode, fldId, name];
}

class FolderListResult extends Equatable {
  final List<FileFolderListModel> folders;
  final List<FileItem> files;

  const FolderListResult({required this.folders, required this.files});

  factory FolderListResult.fromMap(Map<String, dynamic> map) {
    return FolderListResult(
      folders: (map['folders'] as List<dynamic>? ?? [])
          .map((e) => FileFolderListModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      files: (map['files'] as List<dynamic>? ?? [])
          .map((e) => FileItem.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folders': folders.map((e) => e.toMap()).toList(),
      'files': files.map((e) => e.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [folders, files];
}

class FolderListResponse extends Equatable {
  final String msg;
  final String serverTime;
  final int status;
  final FolderListResult result;

  const FolderListResponse({
    required this.msg,
    required this.serverTime,
    required this.status,
    required this.result,
  });

  factory FolderListResponse.fromMap(Map<String, dynamic> map) {
    return FolderListResponse(
      msg: map['msg']?.toString() ?? '',
      serverTime: map['server_time']?.toString() ?? '',
      status: map['status'] is int
          ? map['status']
          : int.tryParse(map['status'].toString()) ?? 0,
      result: FolderListResult.fromMap(map['result'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'server_time': serverTime,
      'status': status,
      'result': result.toMap(),
    };
  }

  @override
  List<Object?> get props => [msg, serverTime, status, result];
}

extension FileFolderListModelX on FileFolderListModel {
  FileFolderListModel copyWith({String? name}) {
    return FileFolderListModel(
      fldId: fldId,
      name: name ?? this.name,
      // varsa diğer alanları da buraya geçir
    );
  }
}