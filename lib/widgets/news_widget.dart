import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/boxes.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/hive_article.dart';
import 'package:news_app/screens/read_article.dart';
import 'package:news_app/utils/functions.dart';
import 'package:news_app/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class NewsWidget extends StatefulWidget {
  final List<Article> articles;

  const NewsWidget({super.key, required this.articles});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: ListView.builder(
              itemCount: widget.articles.length,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                var article = widget.articles[index];
                return Padding(
                  padding: EdgeInsets.only(top: 2.h, right: 20.px),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewArticle(
                              newsArticle: article,
                            ),
                          ));
                    },
                    child: Slidable(
                      endActionPane: ActionPane(motion: const ScrollMotion(), extentRatio: 0.23, children: [
                        // SlidableAction(
                        //   onPressed: (context) {
                        //     addToFavourite(
                        //       article.source?.id,
                        //       article.source?.name,
                        //       article.author,
                        //       article.title,
                        //       article.description,
                        //       article.url,
                        //       article.urlToImage,
                        //       article.publishedAt,
                        //       article.content,
                        //     );
                        //   },
                        //   borderRadius: BorderRadius.only(bottomRight: Radius.circular(11.61.px), topRight: Radius.circular(11.61.px)),
                        //   icon: CupertinoIcons.heart_fill,
                        //   label: 'Add to fav',
                        //   backgroundColor: favColorLight,
                        //   foregroundColor: favColor,
                        // ),

                        InkWell(
                          onTap: () {
                            addToFavourite(
                              article.source?.id,
                              article.source?.name,
                              article.author,
                              article.title,
                              article.description,
                              article.url,
                              article.urlToImage,
                              article.publishedAt,
                              article.content,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 41.px, right: 19.px, bottom: 41.px, left: 19.px),
                            decoration: BoxDecoration(
                              color: favColorLight,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(11.61.px), topRight: Radius.circular(11.61.px)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/fav_icon.png",
                                  width: 27.px,
                                  height: 24.px,
                                ),
                                SizedBox(height: 7.93.px),
                                Text(
                                  "Add to \nFavorite",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.px,
                                    color: const Color(0xff000000),
                                    overflow: TextOverflow.clip,
                                    height: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                      child: Container(
                        padding: EdgeInsets.only(top: 12.58.px, right: 17.42.px, bottom: 12.58.px, left: 17.42.px),
                        margin: EdgeInsets.only(
                          left: 20.px,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11.61.px),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 17.42),
                              blurRadius: 85.15,
                              spreadRadius: -3.87,
                              color: Color.fromRGBO(24, 39, 74, 0.24),
                            ),
                            BoxShadow(
                              offset: Offset(0, 7.74),
                              blurRadius: 27.09,
                              spreadRadius: -5.81,
                              color: Color.fromRGBO(24, 39, 74, 0.19),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(7.74.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.px),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    height: 96.px,
                                    width: 96.px,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      highlightColor: Colors.grey.shade50,
                                      baseColor: Colors.grey.shade200,
                                      child: Container(
                                        height: 96.px,
                                        width: 96.px,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.px)),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      "assets/placeholder_image.png",
                                      height: 96.px,
                                      width: 96.px,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 16.45.px),

                              // title | desc | date time
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title
                                    Text(
                                      article.title ?? '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 15.48.px,
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff212121),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    SizedBox(height: 3.px),

                                    // desc
                                    Text(
                                      article.description ?? '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 15.48.px,
                                        height: 1.2,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff212121),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    SizedBox(height: 3.px),

                                    // date time
                                    publishedDate(article.publishedAt ?? ''),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 4.h),
        ],
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Already exists in Favourites"),
          backgroundColor: favColor,
        ),
      );
    } else {
      box.add(hiveArticle);
    }
  }
}
