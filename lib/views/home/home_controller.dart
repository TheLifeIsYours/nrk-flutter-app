import 'dart:async';
import 'dart:ui';

import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/api/nrk/nrk_feed.dart';
import 'package:nrk/views/home/widgets/reload_dismissible/reload_dismissible.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:webfeed/webfeed.dart';
import 'package:nrk/api/nrk/nrk_api.dart';
import 'package:nrk/services/news_service.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  NewsService newsService = Get.find();
  bool isLoading = true;

  final listViewController = ItemScrollController();
  final scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget? reloadArticlesDismissible;

  //Foldable phone states
  bool hasHinge = true;
  bool previusFoldedOpen = true;
  bool isFoldedOpen = true;
  bool foldViewEnabled = false;

  Timer? autoUpdateArticlesTimer;

  late final AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeIn,
  );

  @override
  void onInit() async {
    super.onInit();
    await fetchNrkFeed();

    hasHinge = MediaQueryHinge(MediaQuery.of(Get.context!)).hinge != null;
    if (hasHinge) {
      initDualScreen();
    }

    newsService.settings.hideReadArticles.listen((_) {
      updateArticleList();
    });

    initAutoUpdate();
  }

  void updateArticleList() {
    if (newsService.settings.hideReadArticles.value) {
      newsService.displayedArticles =
          newsService.articles.where((item) => !newsService.hasReadArticle(item)).toList();
    } else {
      newsService.displayedArticles = newsService.articles;
    }

    update();
  }

  @override
  void onClose() {
    super.onClose();
    autoUpdateArticlesTimer?.cancel();
  }

  void initDualScreen() {
    newsService.settings.foldViewEnabled.listen((foldViewEnabled) {
      this.foldViewEnabled = foldViewEnabled;
      update();
    });

    DualScreenInfo.hingeAngleEvents.listen((double hingeAngle) {
      isFoldedOpen = (hingeAngle > 0);

      if (isFoldedOpen != previusFoldedOpen) {
        previusFoldedOpen = isFoldedOpen;
        update();
      }
    });
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void initAutoUpdate() {
    startAutoUpdateTimer();

    //Listen for new articles when autoUpdateArticles is false
    newsService.settings.autoUpdateArticles.obs.listen((autoUpdateArticles) {
      if (!autoUpdateArticles) {
        autoUpdateArticlesTimer?.cancel();
      } else {
        startAutoUpdateTimer();
      }
    });

    //Listen for hasNewArticles is true
    newsService.hasNewArticles.listen((hasNewArticles) {
      if (hasNewArticles) {
        reloadArticlesDismissible = const ReloadDismissible();
      }
    });
  }

  void startAutoUpdateTimer() {
    if (newsService.settings.autoUpdateArticles) {
      if (autoUpdateArticlesTimer != null) {
        autoUpdateArticlesTimer?.cancel();
      }

      autoUpdateArticlesTimer = Timer.periodic(
        Duration(
          seconds: newsService.settings.autoUpdateArticlesIntervalSeconds,
        ),
        (timer) {
          if (newsService.settings.autoUpdateArticles) {
            updateNewArticles();
          }
        },
      );
    }
  }

  void updateNewArticles() async {
    final feed = await NRKAPI.getNrkFeed(newsService.settings.feed);

    var feedItems = feed.items ?? [];

    //check for new articles
    if (feedItems.isNotEmpty && newsService.articles.isNotEmpty) {
      if (newsService.articles.first.guid != feedItems.first.guid) {
        newsService.hasNewArticles.value = true;
        update();
      }
    }
  }

  void toggleDisplayCompactList() {
    newsService.toggleDisplayCompactList();
    newsService.settings.displayCompactList ? animationController.forward() : animationController.reverse();
    update();
  }

  void setFeed(NRKFeed feed) {
    newsService.settings.feed = feed;
    newsService.saveSettings();
    fetchNrkFeed();
  }

  Future<void> fetchNrkFeed() async {
    RssFeed rssFeed;
    isLoading = true;
    update();

    try {
      rssFeed = await NRKAPI.getNrkFeed(newsService.settings.feed);
      newsService.articles = rssFeed.items ?? [];
      newsService.hasNewArticles.value = false;
      reloadArticlesDismissible = null;
      updateArticleList();
    } catch (e) {
      Get.snackbar(
        'Feil',
        'Kunne ikke hente nyheter, ${e.toString()}',
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 7),
        margin: const EdgeInsets.all(8),
      );
    }

    isLoading = false;
    update();
  }

  bool hasHighEmphasis(RssItem item) {
    var categories = item.categories ?? [];

    for (var category in categories) {
      if (category.domain == "emphasis" && category.value == "high") {
        return true;
      }
    }

    return false;
  }

  void scrollToCurrentArticleIndex() async {
    if (newsService.settings.displayCompactList) {
      scrollController.animateTo(
        (Get.context!.height / 4) * (newsService.currentArticleIndex / 2),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      listViewController.scrollTo(
        index: newsService.currentArticleIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTop() {
    listViewController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void openArticle(int index, RssItem item) {
    Get.toNamed(
      '/news/$index',
      arguments: {'articleUrl': item.link},
    )?.then((_) {
      scrollToCurrentArticleIndex();
      newsService.settings.hideReadArticles.value ? updateArticleList() : null;
      update();
    });
  }
}

extension MediaQueryHinge on MediaQueryData {
  DisplayFeature? get hinge {
    for (final DisplayFeature e in displayFeatures) {
      if (e.type == DisplayFeatureType.hinge || e.type == DisplayFeatureType.fold) {
        return e;
      }
    }

    return null;
  }
}
