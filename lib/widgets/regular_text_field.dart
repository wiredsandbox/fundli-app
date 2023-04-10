import 'package:flutter/material.dart';

class RegularTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool? readOnly;
  final TextInputType textInputType;
  const RegularTextField({
    Key? key,
    required this.textInputType,
    required this.controller,
    required this.hintText,
    this.readOnly,
    this.onTap,
    this.suffix,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<RegularTextField> createState() => _RegularTextFieldState();
}

class _RegularTextFieldState extends State<RegularTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      readOnly: widget.readOnly ?? false,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
