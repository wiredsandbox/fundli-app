import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final Color? color;
  final int? maxLines;
  final TextStyle? labelTextStyle;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  final Widget? suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final double? topPadding;
  const CustomTextField({
    Key? key,
    this.maxLines,
    this.inputFormatters,
    this.color,
    this.topPadding,
    this.labelTextStyle,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
    required this.suffixWidget,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    // Color kPrimary = widget.color == null
    //     ? Colors.black.withOpacity(0.8)
    //     : widget.color!.withOpacity(0.8);

    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding ?? size.height * 0.019),
        Text(
          widget.label,
          style: widget.labelTextStyle ??
              TextStyle(
                fontSize: 18,
                color: kPrimary.withOpacity(1),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: widget.maxLines ?? 1,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          style: TextStyle(color: kPrimary.withOpacity(0.8)),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: kPrimary.withOpacity(0.7)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.2,
                color: kPrimary.withOpacity(0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.2,
                color: kPrimary.withOpacity(0.4),
              ),
            ),
            suffix: widget.suffixWidget,
          ),
        ),
      ],
    );
  }
}
