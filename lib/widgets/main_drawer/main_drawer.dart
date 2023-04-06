import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/widgets/main_drawer/main_drawer_controller.dart';

class MainDrawer extends GetView<MainDrawerController> {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainDrawerController>(
      init: MainDrawerController(),
      builder: (controller) {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                ),
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/NRK/Logo/NRK_negativ_rgb.png',
                        fit: BoxFit.contain,
                        height: 24.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: controller.openEndDrawer,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Nyhets Kilde',
                ),
              ),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: controller.reorderFeedOrder,
                children: controller.newsService.settings.feedOrder
                    .map((feed) => ListTile(
                          key: ValueKey(feed.name),
                          title: Text(feed.name),
                          leading: const Icon(
                            Icons.rss_feed_outlined,
                            color: AppTheme.blue,
                          ),
                          onTap: () {
                            controller.setFeed(feed);
                            controller.closeDrawer();
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
