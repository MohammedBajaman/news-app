import 'package:hive/hive.dart';
part 'hive_article.g.dart';

@HiveType(typeId: 0)
class HiveArticle extends HiveObject{

  @HiveField(0)
  String? sourceId;

  @HiveField(1)
  String? sourceName;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? url;

  @HiveField(6)
  String? urlToImage;

  @HiveField(7)
  String? publishedAt;

  @HiveField(8)
  String? content;
}

