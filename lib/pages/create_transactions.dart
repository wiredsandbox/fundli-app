import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/widgets/add_transaction/add_transaction_category.dart';
import 'package:pocket_guard/widgets/custom_text_field.dart';

import '../widgets/circular_button.dart';

class CreateTransactions extends StatefulWidget {
  const CreateTransactions({Key? key}) : super(key: key);

  @override
  State<CreateTransactions> createState() => _CreateTransactionsState();
}

class _CreateTransactionsState extends State<CreateTransactions> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int typeIndex = 0;
  int categoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                      iconData: Icons.arrow_back_ios,
                      onPressed: () {
                        PageNavigation()
                            .popPagesMultipleTimes(context: context, times: 1);
                      },
                      internalPadding: const EdgeInsets.only(left: 5),
                    ),
                    const Text(
                      "Add Transaction",
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircularButton(
                      iconData: Icons.check,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AddTransactionCategory(
                  categoryName: "Type",
                  currentSelected: typeIndex,
                  buttonDetails: [
                    {
                      'label': 'Income',
                      'icon': const {
                        'iconData': Icons.arrow_upward_outlined,
                        'color': Colors.green,
                        'containerIcon': true,
                      },
                      'onTap': () {
                        setState(() {
                          typeIndex = 0;
                        });
                      }
                    },
                    {
                      'label': 'Expense',
                      'icon': const {
                        'iconData': Icons.arrow_downward_outlined,
                        'color': Colors.red,
                        'containerIcon': true,
                      },
                      'onTap': () {
                        setState(() {
                          typeIndex = 1;
                        });
                      }
                    }
                  ],
                ),
                AddTransactionCategory(
                  categoryName: "Category",
                  currentSelected: categoryIndex,
                  buttonDetails: [
                    {
                      'label': 'Shopping',
                      'icon': const {
                        'iconData': Icons.shopping_bag_outlined,
                        'color': Colors.green,
                        'containerIcon': false,
                      },
                      'onTap': () {
                        setState(() {
                          categoryIndex = 0;
                        });
                      }
                    },
                    {
                      'label': 'Food',
                      'icon': const {
                        'iconData': Icons.fastfood_outlined,
                        'color': Colors.green,
                        'containerIcon': false,
                      },
                      'onTap': () {
                        setState(() {
                          categoryIndex = 1;
                        });
                      }
                    },
                    {
                      'label': 'Transport',
                      'icon': const {
                        'iconData': Icons.car_repair_outlined,
                        'color': Colors.green,
                        'containerIcon': false,
                      },
                      'onTap': () {
                        setState(() {
                          categoryIndex = 2;
                        });
                      }
                    },
                  ],
                ),
                CustomTextField(
                  topPadding: 0,
                  label: "Amount",
                  controller: _amountController,
                  hintText: "0",
                  obscureText: false,
                  textInputType: TextInputType.number,
                  suffixWidget: null,
                  labelTextStyle: const TextStyle(
                    color: kPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Date",
                        controller: _amountController,
                        hintText: "16 - 04 - 2023",
                        obscureText: false,
                        textInputType: TextInputType.number,
                        suffixWidget: null,
                        labelTextStyle: const TextStyle(
                          color: kPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.1),
                    Expanded(
                      child: CustomTextField(
                        label: "Time",
                        controller: _amountController,
                        hintText: "12:24 AM",
                        obscureText: false,
                        textInputType: TextInputType.number,
                        suffixWidget: null,
                        labelTextStyle: const TextStyle(
                          color: kPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  maxLines: 4,
                  label: "Description",
                  controller: _descriptionController,
                  hintText: "More details",
                  obscureText: false,
                  textInputType: TextInputType.text,
                  suffixWidget: null,
                  labelTextStyle: const TextStyle(
                    color: kPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
