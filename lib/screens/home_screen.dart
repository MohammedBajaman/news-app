import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/boxes.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/hive_article.dart';
import 'package:news_app/utils/functions.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/favourites.dart';
import 'package:news_app/widgets/news_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Dio dio = Dio();
  List<Article> articles = [];
  late final TabController _tabController = TabController(length: 2, vsync: this);
  bool isResponseOK = true;

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 1.h),

            // tab bar
            Container(
              height: 8.h,
              padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 23.px),
              child: _tabBar(),
            ),

            // views
            Expanded(child: _tabBarView()),
          ],
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        dividerHeight: 0.0,
        indicator: BoxDecoration(
          color: const Color(0xffEEF3FD),
          borderRadius: BorderRadius.circular(6),
        ),
        controller: _tabController,
        tabs: [
          // news tab
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/menu_icon.svg", width: 33.px, height: 23.px),
              SizedBox(width: 19.px),
              Text(
                "News",
                style: TextStyle(fontSize: 28.px, fontWeight: FontWeight.w700, color: const Color(0xff212121)),
              )
            ],
          ),

          // fav tab
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/fav_icon.png",
                width: 36.px,
                height: 32.px,
                color: favColor,
              ),
              SizedBox(width: 19.px),
              Text(
                "Favs",
                style: TextStyle(fontSize: 28.px, fontWeight: FontWeight.w700, color: const Color(0xff212121)),
              )
            ],
          ),
        ]);
  }

  TabBarView _tabBarView() {
    return TabBarView(controller: _tabController, children: [

      // NEWS Tab
      if (!isResponseOK)
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_circle_fill,
                color: Colors.red,
                size: 150.px,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Something went wrong!",
                style: TextStyle(
                  fontSize: 25.px,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 1.h),
              ElevatedButton(
                onPressed: () => _getNews(),
                child: const Text("Try again"),
              ),
            ],
          ),
        )
      else if (articles.isEmpty)
        ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => shimmerView(),
        )
      else
        RefreshIndicator(onRefresh: () => _getNews(), child: NewsWidget(articles: articles)),

      // FAV Tab
      ValueListenableBuilder<Box<HiveArticle>>(
        valueListenable: Boxes.getHiveArticles().listenable(),
        builder: (context, box, _) {
          final articles = box.values.toList().cast<HiveArticle>();
          return Favourites(articles: articles);
        },
      ),
    ]);
  }

  Future<void> _getNews() async {
    setStateMounted(() => isResponseOK = true);

    try {
      final response = await dio.get(newsApi);

      if (response.data['status'] == 'ok') {
        final articleJson = response.data['articles'] as List;
        setStateMounted(() {
          List<Article> newsArticle = articleJson.map((e) => Article.fromJson(e)).toList();

          // remove deleted articles
          newsArticle = newsArticle.where((element) => element.title != "[Removed]").toList();

          articles = newsArticle;
        });
      } else {
        setStateMounted(() => isResponseOK = false);
      }
    } catch (e) {
      setStateMounted(() => isResponseOK = false);
    }
  }

  void setStateMounted(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}
