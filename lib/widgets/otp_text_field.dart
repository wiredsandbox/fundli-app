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
  List<String> values = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: size.height * 0.115,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return _OTPTextFieldCell(
              size: size,
              onChanged: (pin) {
                setState(() {
                  values.length <= index + 1
                      ? values.add(pin)
                      : values[index] = pin;
                });

                if (values.length >= index && pin.isNotEmpty) {
                  FocusScope.of(context).nextFocus();
                }
                widget.onChanged(values.join(""));
              },
            );
          }),
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
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
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
                  hintText: "_",
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
      ),
    );
  }
}
