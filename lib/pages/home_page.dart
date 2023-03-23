import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocket_guard/models/user_auth_model.dart';
import 'package:pocket_guard/pages/create_transactions.dart';
import 'package:pocket_guard/provider/transaction_provider.dart';
import 'package:pocket_guard/provider/user_auth_provider.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/widgets/account_card.dart';
import 'package:pocket_guard/widgets/transaction_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserAuthModel userAuthModel;
  int page = 0;

  fetchData() async {
    await context.read<UserAuthProvider>().fetchUserAccount();

    await Future.delayed(const Duration(milliseconds: 0), () async {
      userAuthModel = context.read<UserAuthProvider>().getUserAuthModel;

      await context
          .read<TransactionProvider>()
          .fetchUserTransactionList(token: userAuthModel.token, page: page);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    userAuthModel = context.watch<UserAuthProvider>().getUserAuthModel;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: Text(
                  "${userAuthModel.firstName[0]}${userAuthModel.lastName[0]}",
                  style: const TextStyle(color: kPrimary),
                ),
              ),
            ),
            const SizedBox(width: 13),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Hello 👋\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  TextSpan(
                    text: 'Hey ${userAuthModel.firstName}!',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.search,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
        centerTitle: false,
        elevation: 0,
        backgroundColor: kScaffoldBackground,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimary,
        onPressed: () {
          PageNavigation().pushPage(
            context: context,
            page: const CreateTransactions(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountCard(
              balance: context.watch<TransactionProvider>().getTotal(),
              account: "DEFAULT",
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TransactionList(
                transactionList:
                    context.watch<TransactionProvider>().getTransactionList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
