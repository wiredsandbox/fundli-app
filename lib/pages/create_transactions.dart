import 'package:flutter/material.dart';
import 'package:pocket_guard/models/user_auth_model.dart';
import 'package:pocket_guard/pages/transaction_calculator.dart';
import 'package:pocket_guard/provider/user_auth_provider.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';
import 'package:pocket_guard/widgets/add_transaction/add_transaction_category.dart';
import 'package:pocket_guard/widgets/regular_text_field.dart';
import 'package:provider/provider.dart';

import '../provider/transaction_provider.dart';
import '../widgets/circular_button.dart';

class CreateTransactions extends StatefulWidget {
  const CreateTransactions({Key? key}) : super(key: key);

  @override
  State<CreateTransactions> createState() => _CreateTransactionsState();
}

class _CreateTransactionsState extends State<CreateTransactions> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> kind = ["INCOME", "EXPENSE"];
  DateTime date = DateTime.now();
  int typeIndex = 0;
  int categoryIndex = 0;

  Future<DateTime?> pickDate() async => showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now());

  Future<TimeOfDay?> pickTime() async =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  pickDateTime() async {
    DateTime? newDate = await pickDate();
    if (newDate == null) return;

    TimeOfDay? newTime = await pickTime();
    if (newTime == null) return;

    setState(() {
      date = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        newTime.hour,
        newTime.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserAuthModel userAuthModel =
        context.read<UserAuthProvider>().getUserAuthModel;
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
                      onPressed: () async {
                        if (_amountController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty) {
                          await context
                              .read<TransactionProvider>()
                              .createTransaction(
                                  context: context,
                                  token: userAuthModel.token,
                                  name: _descriptionController.text,
                                  amount: double.parse(_amountController.text),
                                  time: date,
                                  kind: kind[typeIndex]);
                        } else {
                          showSnackBar(
                              context: context,
                              text: "Please make sure you enter all fields");
                        }
                      },
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
                        'color': Color(0xff53D258),
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
                        'color': Color(0xffE25C5C),
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
                RegularTextField(
                  controller: _descriptionController,
                  hintText: "Title",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                RegularTextField(
                  controller: _amountController,
                  hintText: "0",
                  textInputType: TextInputType.number,
                  suffix: InkWell(
                    onTap: () async {
                      double? amount = await PageNavigation().pushPage(
                        context: context,
                        page: const TransactionCalculator(),
                      );
                    },
                    child: const Icon(Icons.calculate_outlined),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: RegularTextField(
                        onTap: () async {
                          await pickDateTime();
                        },
                        readOnly: true,
                        controller: null,
                        hintText: "${date.day} - ${date.month} - ${date.year}",
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(Icons.calendar_month),
                      ),
                    ),
                    SizedBox(width: size.width * 0.1),
                    Expanded(
                      child: RegularTextField(
                        onTap: () async {
                          await pickDateTime();
                        },
                        readOnly: true,
                        controller: null,
                        hintText: "${date.hour} : ${date.minute}",
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
