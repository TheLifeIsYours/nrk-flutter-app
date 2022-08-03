import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/fold/fold_controller.dart';
import 'package:nrk/views/home/widgets/article_list.dart';

class FoldView extends GetView<FoldController> {
  const FoldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoldController>(
      init: FoldController(),
      builder: (controller) {
        return TwoPane(
          startPane: const ArticleList(),
          endPane: PageView(
            controller: controller.pageController,
            physics: const PageScrollPhysics(),
            onPageChanged: controller.onPageChanged,
            children: controller.webViews,
          ),
        );
      },
    );
  }
}
