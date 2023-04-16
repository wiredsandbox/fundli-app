import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pocket_guard/widgets/calculator_button.dart';
import 'package:pocket_guard/widgets/custom_button.dart';

import '../utilities/constants.dart';
import '../utilities/page_navigation.dart';
import '../widgets/circular_button.dart';

class TransactionCalculator extends StatefulWidget {
  const TransactionCalculator({Key? key}) : super(key: key);

  @override
  State<TransactionCalculator> createState() => _TransactionCalculatorState();
}

class _TransactionCalculatorState extends State<TransactionCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  CircularButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      PageNavigation().popPagesMultipleTimes(
                        context: context,
                        times: 1,
                      );
                    },
                    internalPadding: const EdgeInsets.only(left: 5),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Calculator",
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.1),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.transparent,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Text(
                                equation,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xffCCD0D1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.transparent,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Text(
                                result,
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: [
                        CalculatorButton(
                            onTap: () => buttonPressed("C"),
                            color: const Color(0xffCCD0D1).withOpacity(0.55),
                            text: "C"),
                        CalculatorButton(
                          onTap: () {
                            if (result.startsWith("-")) {
                              // Remove negative sign
                              result = result.substring(1);
                            } else {
                              // Add negative sign
                              result = "-$result";
                            }
                            // Update the UI
                            setState(() {});
                          },
                          color: const Color(0xffCCD0D1).withOpacity(0.55),
                          text: "+/-",
                        ),
                        CalculatorButton(
                          onTap: () {
                            final double value = double.parse(result);
                            result = (value / 100).toString();
                            // Update the UI
                            setState(() {});
                          },
                          color: const Color(0xffCCD0D1).withOpacity(0.55),
                          text: "%",
                        ),

                        CalculatorButton(
                            onTap: () => buttonPressed("÷"),
                            color: const Color(0xffCCD0D1),
                            text: "÷"),
                        // CalculatorButton(
                        //     onTap: () => buttonPressed("00"),
                        //     color: const Color(0xffCCD0D1),
                        //     text: "00"),
                      ]),
                      Row(children: [
                        CalculatorButton(
                            onTap: () => buttonPressed("7"),
                            color: const Color(0xffEEEFF0),
                            text: "7"),
                        CalculatorButton(
                            onTap: () => buttonPressed("8"),
                            color: const Color(0xffEEEFF0),
                            text: "8"),
                        CalculatorButton(
                            onTap: () => buttonPressed("9"),
                            color: const Color(0xffEEEFF0),
                            text: "9"),
                        CalculatorButton(
                            onTap: () => buttonPressed("×"),
                            color: const Color(0xffCCD0D1),
                            text: "×"),
                      ]),
                      Row(children: [
                        CalculatorButton(
                            onTap: () => buttonPressed("4"),
                            color: const Color(0xffEEEFF0),
                            text: "4"),
                        CalculatorButton(
                            onTap: () => buttonPressed("5"),
                            color: const Color(0xffEEEFF0),
                            text: "5"),
                        CalculatorButton(
                            onTap: () => buttonPressed("6"),
                            color: const Color(0xffEEEFF0),
                            text: "6"),
                        CalculatorButton(
                            onTap: () => buttonPressed("-"),
                            color: const Color(0xffCCD0D1),
                            text: "-"),
                      ]),
                      Row(children: [
                        CalculatorButton(
                            onTap: () => buttonPressed("1"),
                            color: const Color(0xffEEEFF0),
                            text: "1"),
                        CalculatorButton(
                            onTap: () => buttonPressed("2"),
                            color: const Color(0xffEEEFF0),
                            text: "2"),
                        CalculatorButton(
                            onTap: () => buttonPressed("3"),
                            color: const Color(0xffEEEFF0),
                            text: "3"),
                        CalculatorButton(
                            onTap: () => buttonPressed("+"),
                            color: const Color(0xffCCD0D1),
                            text: "+"),
                      ]),
                      Row(children: [
                        CalculatorButton(
                            onTap: () => buttonPressed("."),
                            color: const Color(0xffEEEFF0),
                            text: "."),
                        CalculatorButton(
                            onTap: () => buttonPressed("0"),
                            color: const Color(0xffEEEFF0),
                            text: "0"),
                        CalculatorButton(
                            onTap: () => buttonPressed("⌫"),
                            color: const Color(0xffEEEFF0),
                            text: "⌫"),
                        CalculatorButton(
                            onTap: () => buttonPressed("="),
                            color: const Color(0xffCCD0D1),
                            text: "="),
                      ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    borderColor: kPrimary,
                    color: kPrimary,
                    borderRadius: 8,
                    onTap: () {
                      Navigator.pop(context, result);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Add amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
