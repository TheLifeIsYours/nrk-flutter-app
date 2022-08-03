import 'package:flutter/material.dart';
import 'package:nrk/themes/custom_button_theme.dart';

class SquareButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  final ButtonStyle? style;
  final BoxDecoration? decoration;

  const SquareButton({
    Key? key,
    this.icon,
    this.onTap,
    this.style,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ?? CustomButtonThemes.squareButtonDecoration,
      child: TextButton(
        onPressed: onTap,
        style: style ?? CustomButtonThemes.squarebuttonStyle,
        child: Icon(
          icon ?? Icons.error,
          color: Colors.white,
        ),
      ),
    );
    // return InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     width: 32.0,
    //     height: 32.0,
    //     decoration: decoration ??
    //         BoxDecoration(
    //           borderRadius: const BorderRadius.all(Radius.circular(3.0)),
    //           border: Border.all(
    //             color: Colors.blue,
    //             width: 1.0,
    //           ),
    //           color: Colors.blue,
    //           boxShadow: const [
    //             BoxShadow(
    //               color: Colors.black26,
    //               blurRadius: 1.0,
    //               offset: Offset(0.0, 1.0),
    //             ),
    //           ],
    //         ),
    //     child: Center(
    //       child: Icon(
    //         icon ?? Icons.error,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}
