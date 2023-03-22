import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_guard/utilities/rfc339.dart';

import '../models/transaction_model.dart';
import '../utilities/constants.dart';

class TransactionService {
  Future<List<TransactionModel>?> fetchTransactionList({
    required String token,
    required int page,
  }) async {
    try {
      String endpoint = "transaction?page=$page&per_page=30";

      final response = await http.get(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final transactions = data['transactions'];

        List<TransactionModel> transactionList =
            transactions.map<TransactionModel>((responseData) {
          return TransactionModel(
            id: responseData['id'],
            createdAt: DateTime.parse(responseData['createdAt']),
            amount: responseData['amount'],
            name: responseData['name'],
            kind: responseData['kind'],
            updatedAt: DateTime.parse(responseData['updatedAt']),
          );
        }).toList();

        return transactionList;
      } else {
        debugPrint("Error code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return null;
    }
  }

  Future<TransactionModel?> createTransaction({
    required String token,
    required String name,
    required double amount,
    required DateTime time,
    required String kind,
  }) async {
    try {
      String endpoint = "transaction";

      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Authorization": "Bearer $token"},
        body: jsonEncode({
          "name": name,
          "amount": amount,
          "timestamp": toRfc3339String(time),
          "kind": kind,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        print(data);
      } else {
        debugPrint("Error code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return null;
    }
  }
}
