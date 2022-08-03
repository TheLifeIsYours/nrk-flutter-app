import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/app_routes.dart';

class SplashController extends GetxController {
  final switchDuration = 1500;

  late Timer navigationTimer;
  late Timer switchTimer;

  late List<String> images = [];
  int imageIndex = 0;

  @override
  void onInit() async {
    super.onInit();

    await initImageAssets();

    switchTimer = Timer.periodic(Duration(milliseconds: switchDuration), (timer) {
      imageIndex = (imageIndex + 1) % images.length;
      update();
    });

    navigationTimer = Timer(const Duration(seconds: 6), () {
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
