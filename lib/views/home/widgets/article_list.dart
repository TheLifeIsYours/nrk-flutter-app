import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/home/home_controller.dart';
import 'package:nrk/views/home/widgets/article_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ArticleList extends GetView<HomeController> {
  const ArticleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_) {
        return controller.newsItems.isNotEmpty
            ? controller.newsService.settings.displayCompactList
                ? SliverToBoxAdapter(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: controller.newsItems.map((item) {
                          return Visibility(
                            visible: !controller.newsService.settings.hideReadArticles ||
                                controller.newsService.settings.hideReadArticles !=
                                    controller.newsService.hasReadArticle(item),
                            child: ArticleItem(
                              item: item,
                              index: controller.newsItems.indexOf(item),
                              hasRead: controller.newsService.hasReadArticle(item),
                              onTap: controller.openArticle,
                              handleOnLongPress: controller.openArticle,
                              onHandleReturn: controller.scrollToCurrentArticleIndex,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: ScrollablePositionedList.builder(
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        itemScrollController: controller.listViewController,
                        itemCount: controller.newsItems.length,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          var item = controller.newsItems[index];

                          return Visibility(
                            visible: !controller.newsService.settings.hideReadArticles ||
                                controller.newsService.settings.hideReadArticles !=
                                    controller.newsService.hasReadArticle(item),
                            child: ArticleItem(
                              item: item,
                              index: controller.newsItems.indexOf(item),
                              hasRead: controller.newsService.hasReadArticle(item),
                              onTap: controller.openArticle,
                              handleOnLongPress: controller.openArticle,
                              onHandleReturn: controller.scrollToCurrentArticleIndex,
                            ),
                          );
                        }),
                  )
            : !controller.isLoading
                ? const SliverFillRemaining(
                    child: Center(
                      child: Text('No news items'),
                    ),
                  )
                : const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
      },
    );
  }
}
