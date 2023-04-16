import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;
  const CalculatorButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Container(
          height: size.height * 0.088,
          width: size.width * 0.19,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: widget.color,
          ),
          child: Center(
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}
