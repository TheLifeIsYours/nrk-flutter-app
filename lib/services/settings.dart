import 'package:get/get.dart';
import 'package:nrk/api/nrk/nrk_feed.dart';
import 'package:nrk/services/subscriptions.dart';
import 'package:webfeed/webfeed.dart';

class Settings {
  late NRKFeed feed;
  late bool autoUpdateArticles;
  late int autoUpdateArticlesIntervalSeconds;
  late bool displayCompactList;
  late bool useDarkTheme;
  late List<NRKFeed> feedOrder;
  late Set<Subscription> subscriptions;
  late Set<String> readArticles;
  late Rx<bool> hideReadArticles;

  Settings({
    this.feed = NRKFeed.innenriksMyheter,
    this.autoUpdateArticles = true,
    this.autoUpdateArticlesIntervalSeconds = 60,
    this.displayCompactList = false,
    this.useDarkTheme = false,
    this.feedOrder = const [
      NRKFeed.toppsaker,
      NRKFeed.siste,
      NRKFeed.innenriksMyheter,
      NRKFeed.urix,
      NRKFeed.nrkSapmi,
      NRKFeed.nrkSport,
      NRKFeed.kultur,
      NRKFeed.livsstil,
      NRKFeed.viten,
      NRKFeed.dokumentar,
      NRKFeed.ytring,
    ],
    Set<Subscription>? subscriptions,
    Set<String>? readArticles,
    Rx<bool>? hideReadArticles,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    var settings = Settings(
      feed: NRKFeed.values[json['feed'] ?? 0],
      autoUpdateArticles: json['autoUpdateArticles'] ?? false,
      autoUpdateArticlesIntervalSeconds: json['updateTimerIntervalSeconds'] ?? 60,
      displayCompactList: json['displayCompactList'] ?? false,
      useDarkTheme: json['useDarkTheme'] ?? false,
      feedOrder: List<NRKFeed>.from(
          json['feedOrder'] != null ? json['feedOrder'].map((x) => NRKFeed.values[x]).toList() : []),
    )
      ..subscriptions = Set<Subscription>.from(json['subscriptions'] ?? [])
      ..readArticles = Set<String>.from(json['readArticles'] ?? [])
      ..hideReadArticles = RxBool(json['hideReadArticles'] ?? false);

    return settings;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed'] = feed.index;
    data['autoUpdateArticles'] = autoUpdateArticles;
    data['autoUpdateArticlesIntervalSeconds'] = autoUpdateArticlesIntervalSeconds;
    data['displayCompactList'] = displayCompactList;
    data['useDarkTheme'] = useDarkTheme;
    data['feedOrder'] = feedOrder.map((x) => x.index).toList();
    data['subscriptions'] = subscriptions.toList();
    data['readArticles'] = readArticles.toList();
    data['hideReadArticles'] = hideReadArticles.value;
    return data;
  }
}
