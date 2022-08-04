import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NrkProgressindicatorController extends GetxController {
  late Duration switchDuration;
  late Duration transitionDuration;
  late Timer switchTimer;

  late List<String> images = [];
  int imageIndex = 0;

  @override
  void onInit() async {
    super.onInit();

    await initImageAssets();

    switchTimer = Timer.periodic(switchDuration, (timer) {
      imageIndex = (imageIndex + 1) % images.length;
      update();
    });
  }

  @override
  void onClose() {
    super.onClose();
    switchTimer.cancel();
  }

  Future initImageAssets() async {
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    images = manifestMap.keys.where((path) => RegExp(r'assets/NRK/Sirkel/.*\.png').hasMatch(path)).toList();

    update();
  }
}
