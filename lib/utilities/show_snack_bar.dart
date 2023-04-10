import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';

showSnackBar({
  required BuildContext context,
  required String text,
  final Color? color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? kPrimary,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}
