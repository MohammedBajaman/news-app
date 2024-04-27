import 'package:hive/hive.dart';
import 'package:news_app/models/hive_article.dart';

class Boxes{
  static Box<HiveArticle> getHiveArticles() =>
      Hive.box<HiveArticle>('hiveArticle');
}