import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/services/settings.dart';
import 'package:nrk/services/subscriptions.dart';
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

    hasNewArticles.listen((_) {
      if (hasNewArticles.value) {
        //Check for subscriptions
        checkForSubscribedArticles();
      }
    });
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

  void toggleSubscription(Set<RssCategory> category) {
    var subscription = Subscription(category: category);

    settings.subscriptions.contains(subscription)
        ? settings.subscriptions.remove(subscription)
        : settings.subscriptions.add(subscription);
    saveSettings();
  }

  void checkForSubscribedArticles() {
    var subscriptions = settings.subscriptions.toList();

    for (var article in articles) {
      var categories = article.categories;

      if (categories != null) {
        for (var subscription in subscriptions) {
          if (subscription.category.containsAll(categories)) {}
        }
      }
    }

    hasNewArticles.value = false;
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
