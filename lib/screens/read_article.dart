import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/boxes.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/hive_article.dart';
import 'package:news_app/utils/functions.dart';
import 'package:news_app/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ViewArticle extends StatefulWidget {
  final Article newsArticle;

  const ViewArticle({super.key, required this.newsArticle});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  var hiveBox = Boxes.getHiveArticles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.chevron_back,
                size: 25.92.px,
              ),
              Text(
                "Back",
                style: TextStyle(fontSize: 14.px, fontWeight: FontWeight.w700, color: const Color(0xff232323)),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.px),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // image
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.28.px),
                    child: CachedNetworkImage(
                      imageUrl: widget.newsArticle.urlToImage ?? '',
                      width: 361.px,
                      height: 201.58.px,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        highlightColor: Colors.grey.shade50,
                        baseColor: Colors.grey.shade200,
                        child: Container(
                          width: 361.px,
                          height: 201.58.px,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.28.px)),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/placeholder_image.png",
                        width: 361.px,
                        height: 201.58.px,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.43.px, right: 17.48.px),
                    child: InkWell(
                      onTap: () {
                        addToFavourite(
                          widget.newsArticle.source?.id,
                          widget.newsArticle.source?.name,
                          widget.newsArticle.author,
                          widget.newsArticle.title,
                          widget.newsArticle.description,
                          widget.newsArticle.url,
                          widget.newsArticle.urlToImage,
                          widget.newsArticle.publishedAt,
                          widget.newsArticle.content,
                        );
                      },
                      child: Image.asset(
                        "assets/fav_icon.png",
                        width: 30.85.px,
                        height: 26.74.px,
                        color: hiveBox.values.where((element) => element.url == widget.newsArticle.url).isNotEmpty ? favColor : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1.h),

              // title
              Text(
                widget.newsArticle.title ?? '',
                style: TextStyle(
                  fontSize: 24.68.px,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff212121),
                ),
              ),

              SizedBox(height: 3.px),

              publishedDate(widget.newsArticle.publishedAt ?? ''),

              SizedBox(height: 2.5.h),

              Text(
                widget.newsArticle.description.toString() * 10,
                style: TextStyle(
                  fontSize: 15.92.px,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff212121),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addToFavourite(
    String? sourceId,
    String? sourceName,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  ) async {
    final hiveArticle = HiveArticle()
      ..sourceId = sourceId
      ..sourceName = sourceName
      ..author = author
      ..title = title
      ..description = description
      ..url = url
      ..urlToImage = urlToImage
      ..publishedAt = publishedAt
      ..content = content;

    final box = Boxes.getHiveArticles();

    if (box.values.where((element) => element.url == url).isNotEmpty) {
      box.values.where((element) => element.url == url).first.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Removed from Favourites"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {});
    } else {
      box.add(hiveArticle);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added to Favourites"),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    }
  }
}
