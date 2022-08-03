import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/themes/custom_button_theme.dart';
import 'package:nrk/widgets/drawer_number_input/drawer_number_input_controller.dart';
import 'package:nrk/widgets/square_button.dart';

class DrawerNumberInput extends GetView<DrawerNumberInputController> {
  final String title;
  final num value;
  final bool controlsEnabled;
  final Function(num)? onChanged;

  const DrawerNumberInput({
    Key? key,
    required this.title,
    required this.value,
    required this.controlsEnabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawerNumberInputController>(
      init: DrawerNumberInputController(),
      builder: (controller) {
        controller.value = value;
        controller.onChanged = onChanged;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (controlsEnabled)
                    SquareButton(
                      onTap: controller.decrement,
                      icon: Icons.remove,
                      style: CustomButtonThemes.squarebuttonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          context.theme.colorScheme.onBackground,
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      decoration: CustomButtonThemes.squareButtonDecoration.copyWith(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(4.0),
                        ),
                      ),
                    ),
                  Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: context.theme.colorScheme.onBackground,
                          width: 1.0,
                        ),
                        top: BorderSide(
                          color: context.theme.colorScheme.onBackground,
                          width: 1.0,
                        ),
                      ),
                      color: context.theme.colorScheme.background,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        controller: controller.textController,
                        onChanged: (value) {
                          controller.value = num.tryParse(value) ?? 0;
                          onChanged?.call(controller.value);
                        },
                      ),
                    ),
                  ),
                  if (controlsEnabled)
                    SquareButton(
                      onTap: controller.increment,
                      icon: Icons.add,
                      style: CustomButtonThemes.squarebuttonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          context.theme.colorScheme.onBackground,
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      decoration: CustomButtonThemes.squareButtonDecoration.copyWith(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(4.0),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
