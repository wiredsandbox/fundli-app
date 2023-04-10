import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final Color color;
  final Widget child;
  final VoidCallback onTap;
  const CalculatorButton({
    Key? key,
    required this.color,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: widget.color,
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
