import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DrawerNumberInputController extends GetxController {
  final textController = TextEditingController();

  late Function(num)? onChanged;

  num _value = 0;
  num get value => _value;

  @override
  void onInit() {
    super.onInit();

    textController.text = _value.toString();

    textController.addListener(() {
      _value = num.tryParse(textController.text) ?? 0;
      update();
    });
  }

  set value(num value) {
    _value = value;
    textController.text = _value.toString();

    update();
  }

  void increment() {
    _value++;
    textController.text = _value.toString();
    onChanged?.call(_value);
    update();
  }

  void decrement() {
    _value--;
    textController.text = _value.toString();
    onChanged?.call(_value);
    update();
  }
}
