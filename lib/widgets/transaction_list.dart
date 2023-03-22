import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as ago;

import '../models/transaction_model.dart';
import 'expense_tile.dart';

class TransactionList extends StatefulWidget {
  final List<TransactionModel> transactionList;
  const TransactionList({Key? key, required this.transactionList})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.transactionList.length,
      itemBuilder: (context, index) {
        final transaction = widget.transactionList[index];

        return ExpenseTile(
          title: transaction.name,
          time: ago.format(transaction.createdAt),
          amount: transaction.amount,
          type: transaction.kind,
        );
      },
    );
  }
}
