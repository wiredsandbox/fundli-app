import 'package:flutter/material.dart';
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
  String equation = "";
  double answer = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Map> calculatorButtons = [
      {
        "text": "c",
        "function": () {
          equation = "";
          answer = 0;
        },
      },
      {
        "text": "+/-",
        "function": () {
          equation[0] == "-"
              ? equation = equation.substring(1, equation.length)
              : equation = "-$equation";
        },
      },
      {
        "text": "%",
        "color": kOTPTextField,
        "function": () {},
      },
      {
        "text": "÷",
        "function": () {
          equation += "÷";
        },
      },
      {
        "text": "7",
      },
      {
        "text": "8",
      },
      {
        "text": "9",
      },
      {
        "text": "x",
      },
      {
        "text": "4",
      },
      {
        "text": "5",
      },
      {
        "text": "6",
      },
      {
        "text": "-",
      },
      {
        "text": "1",
      },
      {
        "text": "2",
      },
      {
        "text": "3",
      },
      {
        "text": "+",
      },
      {
        "text": ".",
      },
      {
        "text": "0",
      },
      {
        "text": "x",
        "icon": Icons.backspace_outlined,
        "function": () {
          equation = equation.substring(0, equation.length - 1);
        },
      },
      {
        "text": "=",
        "function": () {},
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircularButton(
                      iconData: Icons.arrow_back_ios,
                      onPressed: () {
                        PageNavigation()
                            .popPagesMultipleTimes(context: context, times: 1);
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
              ),
              SizedBox(height: size.height * 0.06),
              Expanded(
                child: Column(
                  children: [
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
                                        fontSize: 28,
                                        color: Color(0xffCCD0D1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
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
                                      answer.toString(),
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
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                        child: GridView.builder(
                            itemCount: calculatorButtons.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 10 / 9),
                            itemBuilder: (context, index) {
                              return CalculatorButton(
                                onTap: () {
                                  if (calculatorButtons[index]
                                      .containsKey('function')) {
                                    calculatorButtons[index]['function']();
                                  } else {
                                    equation +=
                                        calculatorButtons[index]['text'];
                                  }

                                  setState(() {});
                                },
                                color: (index + 1) < 4
                                    ? const Color(0xffEEEFF0)
                                    : ((index + 1) % 4) == 0
                                        ? const Color(0xffCCD0D1)
                                        : const Color(0xffF9FAFA),
                                child:
                                    calculatorButtons[index].containsKey("icon")
                                        ? Icon(calculatorButtons[index]['icon'])
                                        : Text(
                                            calculatorButtons[index]['text'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                              );
                            }),
                      ),
                    ),
                  ],
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
                    onTap: () {},
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
