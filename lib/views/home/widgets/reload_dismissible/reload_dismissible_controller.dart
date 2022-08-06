import 'package:get/get.dart';
import 'package:nrk/services/news_service.dart';
import 'package:nrk/views/home/home_controller.dart';

class ReloadDismissibleController extends GetxController {
  NewsService newsService = Get.find();
  HomeController homeController = Get.find();

  void dismiss() {
    homeController.newsService.hasNewArticles.value = false;
    homeController.reloadArticlesDismissible = null;
  }

  void handleOnPressed() {
    homeController.fetchNrkFeed();
    homeController.reloadArticlesDismissible = null;
  }

  void handleOnDismissed(direction) => dismiss();
}
