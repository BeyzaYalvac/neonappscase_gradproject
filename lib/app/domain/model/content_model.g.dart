// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentModelAdapter extends TypeAdapter<ContentModel> {
  @override
  final int typeId = 12;

  @override
  ContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as ContentType,
      parentFolderId: fields[3] as String?,
      ownerId: fields[4] as String?,
      createdAt: fields[5] as int?,
      updatedAt: fields[6] as int?,
      code: fields[7] as String?,
      size: fields[8] as int?,
      mimetype: fields[9] as String?,
      md5: fields[10] as String?,
      servers: (fields[11] as List?)?.cast<String>(),
      downloadPage: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ContentModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.parentFolderId)
      ..writeByte(4)
      ..write(obj.ownerId)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.code)
      ..writeByte(8)
      ..write(obj.size)
      ..writeByte(9)
      ..write(obj.mimetype)
      ..writeByte(10)
      ..write(obj.md5)
      ..writeByte(11)
      ..write(obj.servers)
      ..writeByte(12)
      ..write(obj.downloadPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentTypeAdapter extends TypeAdapter<ContentType> {
  @override
  final int typeId = 11;

  @override
  ContentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentType.folder;
      case 1:
        return ContentType.file;
      case 2:
        return ContentType.image;
      case 3:
        return ContentType.video;
      case 4:
        return ContentType.unknown;
      default:
        return ContentType.folder;
    }
  }

  @override
  void write(BinaryWriter writer, ContentType obj) {
    switch (obj) {
      case ContentType.folder:
        writer.writeByte(0);
        break;
      case ContentType.file:
        writer.writeByte(1);
        break;
      case ContentType.image:
        writer.writeByte(2);
        break;
      case ContentType.video:
        writer.writeByte(3);
        break;
      case ContentType.unknown:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
