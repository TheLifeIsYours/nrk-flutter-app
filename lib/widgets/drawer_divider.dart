import 'package:flutter/material.dart';

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.grey,
      indent: 8.0,
      endIndent: 8.0,
    );
  }
}
