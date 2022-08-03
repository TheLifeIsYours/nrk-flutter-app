import 'package:get/get.dart';
import 'package:nrk/views/Splash/splash_controller.dart';
import 'package:nrk/views/Splash/splash_view.dart';
import 'package:nrk/views/home/home_controller.dart';
import 'package:nrk/views/home/home_view.dart';
import 'package:nrk/views/news/news_controller.dart';
import 'package:nrk/views/news/news_view.dart';

class AppRoutes {
  static String home = '/';
  static String splash = '/splash';
  static String news = '/news/:index';

  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(
        () => SplashController(),
      ),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    GetPage(
      name: news,
      page: () => const NewsView(),
      binding: BindingsBuilder.put(
        () => NewsController(),
      ),
    ),
  ];
}
