import 'package:flutter/material.dart';
import 'package:pocket_guard/services/transaction_service.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';

import '../models/transaction_model.dart';

List<TransactionModel> _transactionList = [];

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  List<TransactionModel> get getTransactionList => _transactionList;

  double getTotal(bool income) {
    double total = 0;

    for (var transaction in _transactionList) {
      if (transaction.kind == (income ? "INCOME" : "EXPENSE")) {
        total += transaction.amount;
      }
    }

    return total;
  }

  Future fetchUserTransactionList({
    required String token,
    required int page,
  }) async {
    List<TransactionModel>? transactionList = await _transactionService
        .fetchTransactionList(token: token, page: page);

    if (transactionList != null) {
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
      _transactionList.add(transactionModel);

      PageNavigation().popPagesMultipleTimes(context: context, times: 1);

      notifyListeners();
    } else {
      showSnackBar(context: context, text: "We couldn't process that");
    }
  }
}
