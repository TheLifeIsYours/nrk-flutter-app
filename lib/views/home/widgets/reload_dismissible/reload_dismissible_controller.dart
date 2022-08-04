import 'package:get/get.dart';
import 'package:nrk/views/home/home_controller.dart';

class ReloadDismissibleController extends GetxController {
  HomeController homeController = Get.find();

  void handleOnPressed() {
    homeController.fetchNrkFeed();
    homeController.reloadArticlesDismissible = null;
  }

  void handleOnDismissed(direction) {
    homeController.newsService.hasNewArticles.value = false;
    homeController.reloadArticlesDismissible = null;
  }
}
