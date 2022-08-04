import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/widgets/nrk_progressIndicator/nrk_progressindicator_controller.dart';

class NrkProgressindicator extends GetView<NrkProgressindicatorController> {
  final double? height;
  final Duration? switchDuration;
  final Duration? transitionDuration;

  const NrkProgressindicator({
    Key? key,
    this.height,
    this.switchDuration,
    this.transitionDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NrkProgressindicatorController>(
      init: NrkProgressindicatorController(),
      builder: (controller) {
        controller.switchDuration = switchDuration ?? const Duration(milliseconds: 1500);
        controller.transitionDuration = transitionDuration ?? const Duration(milliseconds: 700);

        return Stack(
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
                      height: height ?? 200.0,
                    ),
                  ),
                ),
              ),
            Center(
              child: Image.asset(
                'assets/NRK/Logo/NRK_negativ_rgb.png',
                height: (height ?? 200.0) / 4,
              ),
            ),
          ],
        );
      },
    );
  }
}
