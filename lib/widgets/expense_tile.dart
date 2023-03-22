import 'package:flutter/material.dart';
import 'package:pocket_guard/models/transaction_model.dart';
import 'package:timeago/timeago.dart' as ago;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: size.height * 0.08,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              height: size.height * 0.65,
              width: size.height * 0.065,
              decoration: BoxDecoration(
                color: const Color(0xffFFECEC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.attach_money,
                color: widget.transactionModel.kind == "INCOME"
                    ? Colors.green
                    : Colors.red,
                size: 27,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.transactionModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  ago.format(widget.transactionModel.createdAt),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff979797)),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${widget.transactionModel.kind == "INCOME" ? "" : "-"}₦${widget.transactionModel.amount}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.transactionModel.kind,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff979797)),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
