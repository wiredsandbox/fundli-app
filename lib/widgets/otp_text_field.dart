import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_guard/utilities/constants.dart';

class OTPTextField extends StatefulWidget {
  final Function(String) onChanged;
  const OTPTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  String value1 = '';
  String value2 = '';
  String value3 = '';
  String value4 = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _OTPTextFieldCell(
            size: size,
            onChanged: (pin) {
              value1 = pin;

              if (value1.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
          _OTPTextFieldCell(
            size: size,
            onChanged: (pin) {
              value2 = pin;

              if (value2.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
          _OTPTextFieldCell(
            size: size,
            onChanged: (pin) {
              value3 = pin;

              if (value3.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
          _OTPTextFieldCell(
            size: size,
            onChanged: (pin) {
              value4 = pin;

              if (value4.isNotEmpty) {
                FocusScope.of(context).nextFocus();
                widget.onChanged(value1 + value2 + value3 + value4);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _OTPTextFieldCell extends StatelessWidget {
  final Size size;
  final Function(String) onChanged;
  const _OTPTextFieldCell({
    Key? key,
    required this.size,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.12,
      decoration: BoxDecoration(
        color: kOTPTextField,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
                hintText: "-",
                hintStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
          Container(
            height: 3,
            width: double.infinity,
            color: kOTPTextField,
          ),
        ],
      ),
    );
  }
}
