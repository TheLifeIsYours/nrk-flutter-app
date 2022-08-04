import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/views/home/widgets/reload_dismissible/reload_dismissible_controller.dart';

class ReloadDismissible extends GetView<ReloadDismissibleController> {
  const ReloadDismissible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReloadDismissibleController>(
      init: ReloadDismissibleController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Dismissible(
            key: const Key('has_new_articles'),
            onDismissed: controller.handleOnDismissed,
            child: TextButton(
              onPressed: controller.handleOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Get.context!.theme.colorScheme.primary),
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
        );
      },
    );
  }
}
