import 'package:webfeed/webfeed.dart';

class Subscription {
  final Set<RssCategory> category;
  Set<String> notifiedArticles = <String>{};

  Subscription({
    required this.category,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      category: Set<RssCategory>.from(json['category'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category.toList();
    return data;
  }
}
