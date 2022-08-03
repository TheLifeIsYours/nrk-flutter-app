import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nrk/api/nrk/nrk_feed.dart';
import 'package:webfeed/webfeed.dart';

class NRKAPI {
  static Future<RssFeed> getNrkFeed(NRKFeed feed) async {
    final response = await http.get(Uri.parse(feed.url));

    if (response.statusCode == 200) {
      final feed = RssFeed.parse(const Utf8Decoder().convert(response.bodyBytes));
      return feed;
    } else {
      throw Exception('Failed to load feed');
    }
  }

  static getNrkFeedStub() async {
    //Read stub rss file
    final response = await rootBundle.loadString("assets/stub/nrk.xml");

    //Parse rss file
    final feed = RssFeed.parse(const Utf8Decoder().convert(utf8.encode(response)));
    return feed;
  }
}
