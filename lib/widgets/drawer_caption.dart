import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nrk/widgets/drawer_divider.dart';

class DrawerCaption extends GetView {
  final String text;
  final bool divider;
  final bool endDivider;

  const DrawerCaption(
    this.text, {
    Key? key,
    this.divider = false,
    this.endDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (divider) const DrawerDivider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(
              color: context.theme.textTheme.caption?.color,
            ),
          ),
        ),
        if (endDivider) const DrawerDivider(),
      ],
    );
  }
}
