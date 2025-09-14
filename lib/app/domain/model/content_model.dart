// lib/app/domain/model/content_model.dart
import 'package:hive/hive.dart';
part 'content_model.g.dart';

@HiveType(typeId: 11)
enum ContentType {
  @HiveField(0) folder,
  @HiveField(1) file,
  @HiveField(2) image,   // file ama görüntü -> tab filtreleri için sugar
  @HiveField(3) video,   // istersen
  @HiveField(4) unknown,
}

@HiveType(typeId: 12)
class ContentModel extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String name;
  @HiveField(2) final ContentType type;
  @HiveField(3) final String? parentFolderId;
  @HiveField(4) final String? ownerId;
  @HiveField(5) final int? createdAt;   // epoch seconds (gofile createTime)
  @HiveField(6) final int? updatedAt;   // modTime
  @HiveField(7) final String? code;     // folder veya parentFolderCode
  @HiveField(8) final int? size;        // sadece file için
  @HiveField(9) final String? mimetype; // image/jpeg gibi
  @HiveField(10) final String? md5;
  @HiveField(11) final List<String>? servers;
  @HiveField(12) final String? downloadPage; // sadece file için

  ContentModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentFolderId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.size,
    this.mimetype,
    this.md5,
    this.servers,
    this.downloadPage,
  });

  bool get isFolder => type == ContentType.folder;
  bool get isImage  => type == ContentType.image || (mimetype?.startsWith('image/') ?? false);
  bool get isFile   => type == ContentType.file || type == ContentType.image || type == ContentType.video;

  ContentModel copyWith({
    String? name,
    int? updatedAt,
  }) => ContentModel(
    id: id,
    name: name ?? this.name,
    type: type,
    parentFolderId: parentFolderId,
    ownerId: ownerId,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    code: code,
    size: size,
    mimetype: mimetype,
    md5: md5,
    servers: servers,
    downloadPage: downloadPage,
  );

  // GoFile MAP -> Model (folder)
  factory ContentModel.fromGofileFolder(Map<String, dynamic> m) {
    final data = m['data'] as Map<String, dynamic>;
    return ContentModel(
      id: data['id'],
      name: data['name'],
      type: ContentType.folder,
      parentFolderId: data['parentFolder'],
      ownerId: data['owner'],
      createdAt: data['createTime'],
      updatedAt: data['modTime'],
      code: data['code'],
    );
  }

  // GoFile MAP -> Model (file)
  factory ContentModel.fromGofileFile(Map<String, dynamic> m) {
    final data = m['data'] as Map<String, dynamic>;
    final mm = (data['mimetype'] as String?) ?? '';
    final isImg = mm.startsWith('image/');
    return ContentModel(
      id: data['id'],
      name: data['name'],
      type: isImg ? ContentType.image : ContentType.file,
      parentFolderId: data['parentFolder'],
      ownerId: null, // dosyada dönmüyor, istersen root çağrılarından doldur
      createdAt: data['createTime'],
      updatedAt: data['modTime'],
      code: data['parentFolderCode'],
      size: data['size'],
      mimetype: mm,
      md5: data['md5'],
      servers: (data['servers'] as List?)?.cast<String>(),
      downloadPage: data['downloadPage'],
    );
  }
}
