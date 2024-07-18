import 'package:flutter/material.dart';

import '../theme/colors.dart';


class OutlinePrimaryButton extends StatelessWidget {
  const OutlinePrimaryButton({
    super.key,
    this.height,
    this.width,
    this.child,
    this.onPressed,
    required this.color,
  });

  final double? height;
  final double? width;
  final Widget? child;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: height,
          width: width,
          child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll<Color>(whiteColor),
              side: WidgetStateProperty.all(BorderSide(color: color)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: color),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            child: child!,
          ),
        ),
      ),
    ]);
  }
}
