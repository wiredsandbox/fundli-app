import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final Color color;
  final double borderRadius;
  final VoidCallback onTap;
  final Widget child;
  const CustomButton({
    Key? key,
    required this.padding,
    required this.borderColor,
    required this.color,
    required this.borderRadius,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          padding,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      child: child,
    );
  }
}
