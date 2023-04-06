import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/services/news_service.dart';
import 'package:nrk/views/news/widgets/news_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:webfeed/webfeed.dart';

class FoldController extends GetxController {
  NewsService newsService = Get.find();
  PageController pageController = PageController();
  final listViewController = ItemScrollController();
  List<NewsItem> webViews = [];

  late void Function(int index) updateKeepAlive;

  @override
  void onInit() {
    super.onInit();
    setWebViewItems();
  }

  void openPage(int index, RssItem item) {
    newsService.currentArticleIndex = index;
    newsService.currentArticleUrl = item.link!;
    pageController.jumpToPage(index);
    update();
  }

  void onPageChanged(int index) {
    updateKeepAlive.call(index);
    newsService.currentArticleIndex = index;
    scrollToCurrentArticleIndex();
    update();
  }

  void scrollToCurrentArticleIndex() {
    listViewController.scrollTo(
      index: newsService.currentArticleIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void setWebViewItems() {
    webViews = newsService.articles.map((item) {
      return NewsItem(
        item: item,
        index: newsService.articles.indexOf(item),
        builder: (BuildContext context, void Function(int index) setKeepAlive) {
          updateKeepAlive = setKeepAlive;
        },
      );
    }).toList();

    update();
  }
}
