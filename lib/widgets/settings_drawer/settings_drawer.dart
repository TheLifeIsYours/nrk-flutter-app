import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/widgets/drawer_number_input/drawer_number_input.dart';
import 'package:nrk/widgets/drawer_caption.dart';
import 'package:nrk/widgets/settings_drawer/settings_drawer_controller.dart';

class SettingsDrawer extends GetView<SettingsDrawerController> {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsDrawerController>(
      init: SettingsDrawerController(),
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
                  children: const [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const DrawerCaption(
                'Auto Update Articles',
              ),
              SwitchListTile(
                title: const Text('Enabled'),
                value: controller.newsService.settings.autoUpdateArticles,
                onChanged: controller.toggleAutoUpdateArticles,
                activeColor: context.theme.colorScheme.onBackground,
              ),
              DrawerNumberInput(
                title: 'Every (Seconds)',
                value: controller.newsService.settings.autoUpdateArticlesIntervalSeconds,
                onChanged: controller.changeAutoUpdateInterval,
                controlsEnabled: true,
              ),
              const DrawerCaption(
                'Hide read articles',
                divider: true,
              ),
              SwitchListTile(
                title: const Text('Hide'),
                value: controller.newsService.settings.hideReadArticles.value,
                onChanged: controller.toggleHideReadArticles,
                activeColor: context.theme.colorScheme.onBackground,
              ),
              const DrawerCaption(
                'Enable Folded View',
                divider: true,
              ),
              SwitchListTile(
                title: const Text('Enabled'),
                value: controller.newsService.settings.foldViewEnabled.value,
                onChanged: controller.toggleFoldView,
                activeColor: context.theme.colorScheme.onBackground,
              ),
              const DrawerCaption(
                'Theme',
                divider: true,
              ),
              SwitchListTile(
                title: const Text('Use Dark Theme'),
                value: controller.newsService.settings.useDarkTheme,
                onChanged: controller.switchTheme,
                activeColor: context.theme.colorScheme.onBackground,
              ),
            ],
          ),
        );
      },
    );
  }
}
