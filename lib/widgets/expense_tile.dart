import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_guard/models/transaction_model.dart';

class ExpenseTile extends StatefulWidget {
  final TransactionModel transactionModel;
  const ExpenseTile({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = widget.transactionModel.createdAt;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: size.width * 0.07,
                backgroundColor: const Color(0xff89A1F7),
                child: const Icon(
                  Icons.apple_outlined,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              title: Text(
                widget.transactionModel.name,
                style: const TextStyle(
                  //fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                //ago.format(widget.transactionModel.createdAt),
                DateFormat("h:mma").format(date),
                style: const TextStyle(
                  color: Color(0xff81878C),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.transactionModel.kind == "INCOME" ? "+" : "-"}"
                    " ₦${widget.transactionModel.amount}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: widget.transactionModel.kind == "INCOME"
                          ? const Color(0xff53D258)
                          : const Color(0xffE25C5C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${date.day}-${date.month}-${date.year}",
                    style: const TextStyle(
                      color: Color(0xff81878C),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )),
        const Divider(),
      ],
    );
  }
}
