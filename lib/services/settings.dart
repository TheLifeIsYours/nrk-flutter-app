import 'package:nrk/api/nrk/nrk_feed.dart';

class Settings {
  late NRKFeed feed;
  late bool autoUpdateArticles;
  late int autoUpdateArticlesIntervalSeconds;
  late bool displayCompactList;
  late bool hideReadArticles;
  late bool useDarkTheme;
  late List<NRKFeed> feedOrder;
  late Set<String> readArticles;

  Settings({
    this.feed = NRKFeed.innenriksMyheter,
    this.autoUpdateArticles = true,
    this.autoUpdateArticlesIntervalSeconds = 60,
    this.displayCompactList = false,
    this.hideReadArticles = false,
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
    this.readArticles = const <String>{},
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        feed: NRKFeed.values[json['feed'] ?? 0],
        autoUpdateArticles: json['autoUpdateArticles'] ?? false,
        autoUpdateArticlesIntervalSeconds: json['updateTimerIntervalSeconds'] ?? 60,
        displayCompactList: json['displayCompactList'] ?? false,
        hideReadArticles: json['hideReadArticles'] ?? false,
        useDarkTheme: json['useDarkTheme'] ?? false,
        feedOrder: List<NRKFeed>.from(
            json['feedOrder'] != null ? json['feedOrder'].map((x) => NRKFeed.values[x]).toList() : []),
        readArticles:
            Set<String>.from(json['readArticles'] != null ? json['readArticles'].map((x) => x).toList() : []),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed'] = feed.index;
    data['autoUpdateArticles'] = autoUpdateArticles;
    data['autoUpdateArticlesIntervalSeconds'] = autoUpdateArticlesIntervalSeconds;
    data['displayCompactList'] = displayCompactList;
    data['hideReadArticles'] = hideReadArticles;
    data['useDarkTheme'] = useDarkTheme;
    data['feedOrder'] = feedOrder.map((x) => x.index).toList();
    data['readArticles'] = readArticles.toList();
    return data;
  }
}
