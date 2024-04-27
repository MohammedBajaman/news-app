import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/hive_article.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(HiveArticleAdapter());
  await Hive.openBox<HiveArticle>('hiveArticle');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return
        MaterialApp(
          title: 'News app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: favColor),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
