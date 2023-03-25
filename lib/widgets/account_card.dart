import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/main_utilities.dart';

class AccountCard extends StatefulWidget {
  final String account;
  final double balance;
  const AccountCard({
    Key? key,
    required this.account,
    required this.balance,
  }) : super(key: key);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool view = true;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/card.png"),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total balance",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          view = !view;
                        });
                      },
                      child: Icon(
                        view
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ))
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ImageFiltered(
                  imageFilter: view
                      ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                      : ImageFilter.blur(sigmaX: 15, sigmaY: 1),
                  child: Text(
                    "₦${MainUtilities().formatAmount(widget.balance)}",
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: kBalanceText,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                widget.account,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
