import 'package:get/get.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/services/news_service.dart';
import 'package:nrk/views/home/home_controller.dart';

class SettingsDrawerController extends GetxController {
  NewsService newsService = Get.find();
  HomeController homeController = Get.find();

  void toggleAutoUpdateArticles(bool value) {
    newsService.settings.autoUpdateArticles = value;
    newsService.saveSettings();
    update();
  }

  void changeAutoUpdateInterval(num value) {
    newsService.settings.autoUpdateArticlesIntervalSeconds = value.toInt();
    newsService.saveSettings();
    update();
  }

  void toggleHideReadArticles(bool value) {
    newsService.settings.hideReadArticles = value;
    newsService.saveSettings();
    homeController.update();
    update();
  }

  void switchTheme(bool value) {
    Get.changeTheme(value ? AppTheme.dark : AppTheme.light);
    newsService.settings.useDarkTheme = value;
    newsService.saveSettings();
    update();
  }
}
