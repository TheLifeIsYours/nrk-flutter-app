import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/home/home_controller.dart';
import 'package:nrk/views/home/widgets/article_item.dart';
import 'package:nrk/widgets/nrk_progressIndicator/nrk_progressindicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ArticleList extends GetView<HomeController> {
  const ArticleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_) {
        return controller.newsService.displayedArticles.isNotEmpty
            ? controller.newsService.settings.displayCompactList
                ? SliverToBoxAdapter(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: controller.newsService.displayedArticles.map((item) {
                          return ArticleItem(
                            item: item,
                            index: controller.newsService.displayedArticles.indexOf(item),
                            hasRead: controller.newsService.hasReadArticle(item),
                            onTap: controller.openArticle,
                            handleOnLongPress: controller.openArticle,
                            onHandleReturn: controller.scrollToCurrentArticleIndex,
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
                        itemCount: controller.newsService.displayedArticles.length,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          var item = controller.newsService.displayedArticles[index];

                          return ArticleItem(
                            item: item,
                            index: controller.newsService.displayedArticles.indexOf(item),
                            hasRead: controller.newsService.hasReadArticle(item),
                            onTap: controller.openArticle,
                            handleOnLongPress: controller.openArticle,
                            onHandleReturn: controller.scrollToCurrentArticleIndex,
                          );
                        }),
                  )
            : !controller.isLoading
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Ingen flere nyheter',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Vis gjømte nyheter:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Switch(
                                value: !controller.newsService.settings.hideReadArticles.value,
                                onChanged: (value) =>
                                    controller.newsService.settings.hideReadArticles.value = !value,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const SliverFillRemaining(
                    child: NrkProgressindicator(
                      height: 100.0,
                      switchDuration: Duration(milliseconds: 700),
                      transitionDuration: Duration(milliseconds: 200),
                    ),
                  );
      },
    );
  }
}
