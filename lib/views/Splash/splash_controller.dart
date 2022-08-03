import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_routes.dart';

class SplashController extends GetxController {
  final switchDurationMillis = 1500;
  final navigationDurationSeconds = kDebugMode ? 0 : 6;

  late Timer navigationTimer;
  late Timer switchTimer;

  late List<String> images = [];
  int imageIndex = 0;

  @override
  void onInit() async {
    super.onInit();

    await initImageAssets();

    switchTimer = Timer.periodic(Duration(milliseconds: switchDurationMillis), (timer) {
      imageIndex = (imageIndex + 1) % images.length;
      update();
    });

    navigationTimer = Timer(Duration(seconds: navigationDurationSeconds), () {
      Get.offAndToNamed(AppRoutes.home);
    });
  }

  @override
  void onClose() {
    super.onClose();
    navigationTimer.cancel();
    switchTimer.cancel();
  }

  Future initImageAssets() async {
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    images = manifestMap.keys.where((path) => RegExp(r'assets/NRK/Sirkel/.*\.png').hasMatch(path)).toList();

    update();
  }
}
