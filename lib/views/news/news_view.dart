import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/news/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NewsController(),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('NRK'),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const PageScrollPhysics(),
                onPageChanged: controller.onPageChanged,
                children: controller.webViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
