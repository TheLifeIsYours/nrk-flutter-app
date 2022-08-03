import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_routes.dart';
import 'package:nrk/services/news_service.dart';
import 'package:nrk/views/news/widgets/news_item.dart';
import 'package:webfeed/webfeed.dart';

class NewsController extends GetxController {
  NewsService newsService = Get.find();
  String? pageIndex = Get.parameters['index'];

  PageController pageController = PageController();
  List<NewsItem> webViews = [];

  late void Function(int index) upadteKeepAlive;

  @override
  void onInit() {
    super.onInit();
    getArticleUrl();
    getParams();

    setWebViewItems();
  }

  @override
  void onReady() {
    super.onReady();
    setWebViewItems();

    var index = newsService.articles.indexWhere((article) => article.link == newsService.currentArticleUrl);
    pageController.jumpToPage(index);
    newsService.addReadArticle(newsService.articles[index]);
  }

  void getArticleUrl() {
    try {
      newsService.currentArticleUrl = Get.arguments['articleUrl'];
    } catch (e) {
      Get.offAndToNamed(AppRoutes.home);
    }
  }

  void getParams() {
    if (pageIndex != null) {
      var index = int.parse(pageIndex!);
      newsService.currentArticleIndex = index;
    }
  }

  void setWebViewItems() {
    if (newsService.settings.hideReadArticles.value) {
      webViews = newsService.articles
          .where((item) => !newsService.hasReadArticle(item))
          .map((item) => NewsItem(
                item: item,
                index: newsService.articles.indexOf(item),
                builder: (BuildContext context, void Function(int index) setKeepAlive) {
                  upadteKeepAlive = setKeepAlive;
                },
              ))
          .toList();
    } else {
      webViews = newsService.articles
          .map((item) => NewsItem(
                item: item,
                index: newsService.articles.indexOf(item),
                builder: (BuildContext context, void Function(int index) setKeepAlive) {
                  upadteKeepAlive = setKeepAlive;
                },
              ))
          .toList();
    }

    update();
  }

  void onPageChanged(int index) {
    newsService.hasReadArticle(newsService.articles[index])
        ? null
        : newsService.addReadArticle(newsService.articles[index]);

    upadteKeepAlive.call(index);
    newsService.currentArticleIndex = index;
    update();
  }
}
