import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/wallet_model.dart';
import '../utilities/constants.dart';

class WalletService {
  Future<WalletModel?> createWallet({
    required String token,
    required String name,
  }) async {
    try {
      String endpoint = "wallet";

      Dio dio = Dio();

      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.post(
        "$baseUrl$endpoint",
        data: {"name": name},
      );

      final wallet = response.data;

      return WalletModel(
        id: wallet['id'],
        name: wallet['name'],
        createdAt: DateTime.parse(wallet['createdAt']),
        updatedAt: DateTime.parse(wallet['updatedAt']),
      );
    } catch (e) {
      if (e is DioError) {
        debugPrint("Code: ${e.response?.statusCode.toString()}");
        debugPrint(e.message);
      } else {
        debugPrint("Caught error with transaction service: $e");
      }
      return null;
    }
  }

  Future<List<WalletModel>?> fetchWalletList({
    required String token,
    required int page,
  }) async {
    try {
      String endpoint = "wallet?page=$page&per_page=30";

      final response = await http.get(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        final data = body['wallets'];

        return data.map<WalletModel>((wallet) {
          return WalletModel(
            id: wallet['id'],
            name: wallet['name'],
            createdAt: DateTime.parse(wallet['createdAt']),
            updatedAt: DateTime.parse(wallet['updatedAt']),
          );
        }).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        debugPrint(
            "!------------Error transaction list code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with wallet service: $e");
      return null;
    }
  }
}
