import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nrk/app_routes.dart';
import 'package:nrk/app_theme.dart';
import 'package:nrk/services/news_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nrk/services/notifications_service.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Get.put(NewsService());
    Get.put(NotificationsService());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NRK',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
