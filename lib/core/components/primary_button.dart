import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.child,
    this.onPressed,
  });

  final double? height;
  final double? width;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 6.h,
          width: width,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor:blueColor,
              disabledBackgroundColor: outlineGrayColor, //Note: change with input validator 
            ),
            child: child,
          ),
        ),
      ),
    ]);
  }
}