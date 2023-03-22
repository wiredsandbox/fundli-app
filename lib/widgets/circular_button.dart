import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';

class CircularButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? internalPadding;
  const CircularButton(
      {Key? key,
      required this.iconData,
      required this.onPressed,
      this.internalPadding})
      : super(key: key);

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Padding(
            padding: widget.internalPadding ?? const EdgeInsets.only(),
            child: Icon(
              widget.iconData,
              color: kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
