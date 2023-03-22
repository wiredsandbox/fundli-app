import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import '../custom_button.dart';

class AddTransactionCategory extends StatefulWidget {
  final String categoryName;
  final int currentSelected;
  final List<Map> buttonDetails;
  const AddTransactionCategory({
    Key? key,
    required this.categoryName,
    required this.currentSelected,
    required this.buttonDetails,
  }) : super(key: key);

  @override
  State<AddTransactionCategory> createState() => _AddTransactionCategoryState();
}

class _AddTransactionCategoryState extends State<AddTransactionCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.categoryName,
          style: const TextStyle(
            color: kPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ...widget.buttonDetails.map((buttonData) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    borderColor: kBorder,
                    color: widget.buttonDetails.indexOf(buttonData) ==
                            widget.currentSelected
                        ? kBorder
                        : kScaffoldBackground,
                    borderRadius: 8,
                    onTap: buttonData['onTap'],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buttonData['icon']['containerIcon']
                            ? Container(
                                decoration: BoxDecoration(
                                  color: buttonData['icon']['color'],
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    buttonData['icon']['iconData'],
                                    color: kScaffoldBackground,
                                    size: 15,
                                  ),
                                ),
                              )
                            : Icon(
                                buttonData['icon']['iconData'],
                                color: kPrimary,
                                size: 15,
                              ),
                        const SizedBox(width: 8),
                        Text(
                          buttonData['label'],
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
