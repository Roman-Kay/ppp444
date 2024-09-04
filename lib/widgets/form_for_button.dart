import 'package:flutter/material.dart';

class FormForButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Function()? onPressed;
  final Widget child;

  const FormForButton({
    super.key,
    this.borderRadius,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        side: const BorderSide(
          width: 0,
          color: Color(0x00000000),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
