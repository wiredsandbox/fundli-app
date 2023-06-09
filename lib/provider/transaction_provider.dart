import 'package:flutter/material.dart';
import 'package:pocket_guard/services/transaction_service.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';

import '../models/transaction_model.dart';

List<TransactionModel> _transactionList = [];

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  List<TransactionModel> get getTransactionList => _transactionList;

  double getTotal() {
    double total = 0;

    for (var transaction in _transactionList) {
      transaction.kind == "INCOME"
          ? total += transaction.amount
          : total -= transaction.amount;
    }

    return total;
  }

  Future fetchUserTransactionList({
    required String token,
    required int page,
  }) async {
    List<TransactionModel>? fetchedTransactionList = await _transactionService
        .fetchTransactionList(token: token, page: page);

    if (fetchedTransactionList != null) {
      fetchedTransactionList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      List<TransactionModel> transactionList =
          fetchedTransactionList.reversed.toList();

      for (var transaction in transactionList) {
        if (_transactionList.contains(transaction)) {
          int index = _transactionList.indexOf(transaction);

          _transactionList[index] = transaction;
        } else {
          _transactionList.add(transaction);
        }
      }
    }

    notifyListeners();
  }

  Future createTransaction({
    required context,
    required String token,
    required String name,
    required double amount,
    required DateTime time,
    required String kind,
  }) async {
    TransactionModel? transactionModel =
        await _transactionService.createNewTransaction(
            token: token, name: name, amount: amount, time: time, kind: kind);

    if (transactionModel != null) {
      _transactionList.insert(0, transactionModel);

      PageNavigation().popPagesMultipleTimes(context: context, times: 1);

      notifyListeners();
    } else {
      showSnackBar(context: context, text: "We couldn't process that");
    }
  }
}
