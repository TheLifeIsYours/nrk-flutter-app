import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/services/settings.dart';
import 'package:webfeed/webfeed.dart';

class NewsService extends GetxService {
  final storage = GetStorage();
  late Settings settings;

  List<RssItem> articles = [];
  List<RssItem> displayedArticles = [];

  String currentArticleUrl = "";
  int currentArticleIndex = 0;
  RxBool hasNewArticles = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadSettings();
    Get.changeTheme(settings.useDarkTheme ? AppTheme.dark : AppTheme.light);
  }

  void toggleDisplayCompactList() {
    settings.displayCompactList = !settings.displayCompactList;
    saveSettings();
  }

  bool hasReadArticle(RssItem item) {
    return settings.readArticles.contains(item.guid);
  }

  void addReadArticle(RssItem item) {
    settings.readArticles.add(item.guid!);
    saveSettings();
  }

  void toggleReadArticle(RssItem item) {
    if (hasReadArticle(item)) {
      settings.readArticles.remove(item.guid);
    } else {
      settings.readArticles.add(item.guid!);
    }
    saveSettings();
  }

  Future<void> loadSettings() async {
    var settingsData = await storage.read("settings");

    if (settingsData != null) {
      settings = Settings.fromJson(settingsData);
    } else {
      settings = Settings()
        ..hideReadArticles = RxBool(false)
        ..readArticles = <String>{};
    }
  }

  void saveSettings() {
    storage.write('settings', settings.toJson());
  }
}
