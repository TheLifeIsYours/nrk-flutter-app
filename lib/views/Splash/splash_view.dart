import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/Splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (controller.images.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Image.asset(
                        controller.images[controller.imageIndex],
                        key: ValueKey('image_${controller.imageIndex}'),
                        height: 200.0,
                      ),
                    ),
                  ),
                ),
              Center(
                child: Image.asset(
                  'assets/NRK/Logo/NRK_negativ_rgb.png',
                  height: 48.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
