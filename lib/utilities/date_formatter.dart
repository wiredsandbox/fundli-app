import 'package:flutter/services.dart';

class TimingTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var old = oldValue.text;

    String check = old.replaceAll("", "");
    check = check.replaceAll(":", "");
    check = check.replaceAll("-", "");

    var buffer = StringBuffer();

    if (text.length <= 1) {
      if (check == text) {
        if (check.length <= 1) {
          buffer.write("--:--");
        }
      } else {
        if (text == "1" || text == "0") {
          buffer.write('0$text:--');
        } else {
          buffer.write('0$text:--');
        }
      }
    } else if (text.length == 2) {
      if (check == text) {
        if (check.length == 2) {
          buffer.write("${text.substring(0, 1)}-:--");
        }
      } else {
        buffer.write('$text:--');
      }
    } else if (text.length == 3) {
      if (check == text) {
        if (check.length == 3) {
          buffer.write("${text.substring(0, 2)}:--");
        }
      } else {
        String firstPart = text.substring(0, 2);
        String secondPart = text.substring(2, 3);
        buffer.write('$firstPart:$secondPart-');
      }
    } else if (text.length == 4) {
      String firstPart = text.substring(0, 2);
      String secondPart = text.substring(2, 4);
      buffer.write('$firstPart:$secondPart');
    } else if (text.length > 4) {
      String firstTwo = text.substring(0, 2);
      //each individual values
      String latestValue = text.substring(text.length - 1, text.length);
      String fourthValue = text.substring(3, 4);
      String thirdValue = text.substring(2, 3);
      String secondValue = text.substring(1, 2);
      String firstValue = text.substring(0, 1);

      if (firstTwo == "01") {
        //String finalText = "10:$fourthValue$latestValue";

        String finalText =
            "${text.substring(1, 2)}$thirdValue:$fourthValue$latestValue";

        buffer.write(finalText);
      } else {
        String firstPart = text.substring(0, 2);
        String secondPart = text.substring(2, 4);
        buffer.write('$firstPart:$secondPart');
      }
    }

    var string = buffer.toString();

    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
