import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/api/nrk/nrk_feed.dart';
import 'package:nrk/services/news_service.dart';
import 'package:nrk/views/home/home_controller.dart';

class MainDrawerController extends GetxController {
  NewsService newsService = Get.find();
  HomeController homeController = Get.find();

  void openDrawer() {
    homeController.scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    homeController.scaffoldKey.currentState?.closeDrawer();
  }

  void openEndDrawer() {
    homeController.scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    homeController.scaffoldKey.currentState?.closeEndDrawer();
  }

  void reorderFeedOrder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final NRKFeed item = newsService.settings.feedOrder.removeAt(oldIndex);
    newsService.settings.feedOrder.insert(newIndex, item);
    newsService.saveSettings();
    update();
  }

  void setFeed(NRKFeed feed) {
    newsService.settings.feed = feed;
    newsService.saveSettings();
    homeController.fetchNrkFeed();
  }
}
