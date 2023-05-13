import 'package:flutter/material.dart';
import 'package:pocket_guard/models/wallet_model.dart';
import 'package:pocket_guard/services/wallet_service.dart';

WalletModel? _currentWallet;
List<WalletModel> _walletList = [];

class WalletProvider with ChangeNotifier {
  final WalletService _walletService = WalletService();

  WalletModel? get getCurrentWallet => _currentWallet;
  List<WalletModel> get getWalletList => _walletList;

  setCurrentWallet(WalletModel? walletModel) {
    _currentWallet = walletModel;
    notifyListeners();
  }

  Future<bool> createWallet({
    required String token,
    required String name,
  }) async {
    WalletModel? walletModel =
        await _walletService.createWallet(token: token, name: name);

    if (walletModel != null) {
      _walletList.add(walletModel);
    }

    notifyListeners();

    return walletModel != null;
  }

  Future fetchWalletList({
    required String token,
    required int page,
  }) async {
    List<WalletModel>? fetchedWalletList =
        await _walletService.fetchWalletList(token: token, page: page);

    if (fetchedWalletList != null) {
      for (var item in fetchedWalletList) {
        if (_walletList.contains(item) == false) {
          _walletList.add(item);
        }
      }
    }

    notifyListeners();
  }
}
