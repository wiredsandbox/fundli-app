import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/home_page.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:provider/provider.dart';

import '../models/user_auth_model.dart';
import '../provider/transaction_provider.dart';
import '../provider/user_auth_provider.dart';
import '../provider/wallet_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  fetchData() async {
    await context.read<UserAuthProvider>().fetchUserAccount();

    UserAuthModel userAuthModel =
        context.read<UserAuthProvider>().getUserAuthModel;

    await Future.delayed(duration, () async {
      userAuthModel = context.read<UserAuthProvider>().getUserAuthModel;

      context
          .read<TransactionProvider>()
          .fetchUserTransactionList(token: userAuthModel.token, page: 1);

      await context
          .read<WalletProvider>()
          .fetchWalletList(token: userAuthModel.token, page: 1);
    });

    await Future.delayed(const Duration(seconds: 3), () {
      PageNavigation().replacePage(context: context, page: const HomePage());
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: kPrimary,
        ),
      ),
    );
  }
}
