import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/home/home_controller.dart';
import 'package:nrk/views/fold/fold_view.dart';
import 'package:nrk/widgets/main_drawer/main_drawer.dart';
import 'package:nrk/views/home/widgets/article_list.dart';
import 'package:nrk/widgets/settings_drawer/settings_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: MainDrawer(
            scaffoldKey: controller.scaffoldKey,
          ),
          endDrawer: const SettingsDrawer(),
          endDrawerEnableOpenDragGesture: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: (controller.newsService.hasNewArticles
              ? Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Dismissible(
                    key: const Key('has_new_articles'),
                    onDismissed: (direction) => controller.newsService.hasNewArticles = false,
                    child: TextButton(
                      onPressed: controller.fetchNrkFeed,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(context.theme.colorScheme.primary),
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        fixedSize: MaterialStateProperty.all(const Size(120, 40)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Refresh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null),
          body: RefreshIndicator(
            onRefresh: controller.fetchNrkFeed,
            backgroundColor: context.theme.colorScheme.primary,
            color: Colors.white,
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: 100.0,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => {
                              controller.scrollToTop(),
                              controller.fetchNrkFeed(),
                            },
                            child: Image.asset(
                              'assets/NRK/Logo/NRK_negativ_rgb.png',
                              fit: BoxFit.contain,
                              height: 16.0,
                            ),
                          ),
                        ),
                        titlePadding: const EdgeInsets.only(bottom: 48.0),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(48.0),
                        child: Container(
                          color: context.theme.colorScheme.surface,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: controller.openDrawer,
                              ),
                              Text(
                                controller.newsService.settings.feed.name,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () => Get.toNamed('/search'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.view_list,
                            progress: controller.animation,
                          ),
                          onPressed: controller.toggleDisplayCompactList,
                        ),
                      ],
                    ),
                    if (controller.newsItems.isEmpty || controller.isLoading)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      Visibility(
                        visible: controller.hasHinge && controller.isFoldedOpen,
                        replacement: const ArticleList(),
                        child: const FoldView(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
