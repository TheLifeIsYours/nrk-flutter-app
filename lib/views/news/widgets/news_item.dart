import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef NewsItemBuilder = void Function(BuildContext context, void Function(int index) setKeepAlive);

class NewsItem extends StatefulWidget {
  final RssItem item;
  final int index;
  final NewsItemBuilder builder;

  const NewsItem({Key? key, required this.item, required this.index, required this.builder}) : super(key: key);

  @override
  State<NewsItem> createState() => NewsItemState();
}

class NewsItemState extends State<NewsItem> with AutomaticKeepAliveClientMixin {
  late bool keepAlive = true;

  @override
  bool get wantKeepAlive => keepAlive;

  void setKeepAlive(int currentIndex) {
    setState(() {
      if ((widget.index - currentIndex).abs() < 5) {
        keepAlive = true;
      } else {
        keepAlive = false;
      }

      updateKeepAlive();
    });
  }

  late WebViewController? webViewController;

  Future<void> reloadWebView() {
    return webViewController!.reload();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    widget.builder.call(context, (int index) => setKeepAlive);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: WebView(
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            initialUrl: widget.item.link,
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ],
    );
  }
}
