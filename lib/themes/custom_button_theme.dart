import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonThemes {
  static ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      elevation: MaterialStateProperty.all(0.5),
      backgroundColor: MaterialStateProperty.all(Get.theme.primaryColor),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Get.theme.primaryColor.withOpacity(0.1);
          }

          return null;
        },
      ),
    ),
  );

  static ButtonStyle squarebuttonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.square(32.0)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: MaterialStateProperty.all(const Size.square(12.0)),
  );

  static BoxDecoration squareButtonDecoration = const BoxDecoration(
    boxShadow: [
      BoxShadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
        color: Colors.black12,
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  );
}
