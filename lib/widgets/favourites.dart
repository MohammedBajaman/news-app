import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/boxes.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/hive_article.dart';
import 'package:news_app/screens/read_article.dart';
import 'package:news_app/utils/functions.dart';
import 'package:news_app/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class Favourites extends StatefulWidget {
  final List<HiveArticle> articles;

  const Favourites({super.key, required this.articles});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return widget.articles.isEmpty
        ? noFavYet()
        : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
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
                                  newsArticle: Article(
                                      source: Source(
                                        id: article.sourceId,
                                        name: article.sourceName,
                                      ),
                                      author: article.author,
                                      title: article.title,
                                      description: article.description,
                                      url: article.url,
                                      urlToImage: article.urlToImage,
                                      publishedAt: article.publishedAt,
                                      content: article.content),
                                ),
                              ));
                        },
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
                    );
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          );
  }

  Widget noFavYet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: favColorLight,
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 120,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "No favourites yet!",
            style: TextStyle(
              fontSize: 25.px,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 1.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Text(
              "Like a news your see? Save them here to your favourites.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17.px,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addRemoveFavourite(
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
