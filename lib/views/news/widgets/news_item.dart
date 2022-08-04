import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nrk/widgets/nrk_progressIndicator/nrk_progressindicator.dart';
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
      keepAlive = (widget.index - currentIndex).abs() < 5 ? true : false;

      updateKeepAlive();
    });
  }

  late WebViewController? webViewController;
  bool isLoading = true;

  Future<void> reloadWebView() => webViewController!.reload();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    widget.builder.call(context, (int index) => setKeepAlive);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Stack(
            children: [
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProgress: (progress) {
                  setState(() {
                    isLoading = progress < 70;
                  });
                },
                initialUrl: widget.item.link,
                gestureRecognizers: <Factory<VerticalDragGestureRecognizer>>{
                  Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())
                },
              ),
              if (isLoading)
                const NrkProgressindicator(
                  height: 80.0,
                  switchDuration: Duration(milliseconds: 700),
                  transitionDuration: Duration(milliseconds: 200),
                )
            ],
          ),
        ),
      ],
    );
  }
}
