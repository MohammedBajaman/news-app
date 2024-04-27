// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_article.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveArticleAdapter extends TypeAdapter<HiveArticle> {
  @override
  final int typeId = 0;

  @override
  HiveArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveArticle()
      ..sourceId = fields[0] as String?
      ..sourceName = fields[1] as String?
      ..author = fields[2] as String?
      ..title = fields[3] as String?
      ..description = fields[4] as String?
      ..url = fields[5] as String?
      ..urlToImage = fields[6] as String?
      ..publishedAt = fields[7] as String?
      ..content = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveArticle obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.sourceId)
      ..writeByte(1)
      ..write(obj.sourceName)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.urlToImage)
      ..writeByte(7)
      ..write(obj.publishedAt)
      ..writeByte(8)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
