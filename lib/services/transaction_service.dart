import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      } else if (response.statusCode == 404) {
        return [];
      } else {
        debugPrint(
            "!------------Error transaction list code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return null;
    }
  }

  Future<TransactionModel?> createNewTransaction({
    required String token,
    required String name,
    required double amount,
    required DateTime time,
    required String kind,
  }) async {
    try {
      String endpoint = "transaction";

      Dio dio = Dio();

      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.post(
        "$baseUrl$endpoint",
        data: {
          "name": name,
          "amount": amount,
          "timestamp": time.toUtc().toIso8601String(),
          "kind": kind,
        },
      );

      final data = response.data;

      return TransactionModel(
          id: data['id'],
          createdAt: DateTime.parse(data['createdAt']),
          amount: data['amount'],
          name: data['name'],
          kind: data['kind'],
          updatedAt: DateTime.parse(data['updatedAt']));
    } catch (e) {
      debugPrint("Caught error with transaction service: $e");
      return null;
    }
  }
}
