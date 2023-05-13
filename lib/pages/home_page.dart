import 'package:flutter/material.dart';
import 'package:pocket_guard/models/user_auth_model.dart';
import 'package:pocket_guard/pages/create_account.dart';
import 'package:pocket_guard/pages/create_transactions.dart';
import 'package:pocket_guard/provider/transaction_provider.dart';
import 'package:pocket_guard/provider/user_auth_provider.dart';
import 'package:pocket_guard/provider/wallet_provider.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/widgets/account_card.dart';
import 'package:pocket_guard/widgets/transaction_list.dart';
import 'package:pocket_guard/widgets/wallet_widgets/wallet_card.dart';
import 'package:provider/provider.dart';

import '../models/wallet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    List<WalletModel> walletList =
        context.watch<WalletProvider>().getWalletList;

    WalletModel? currentWallet =
        context.watch<WalletProvider>().getCurrentWallet;

    UserAuthModel userAuthModel =
        context.read<UserAuthProvider>().getUserAuthModel;

    return Scaffold(
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
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBalanceText,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "${userAuthModel.firstName[0]}${userAuthModel.lastName[0]}",
                      style: const TextStyle(
                          color: kPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
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
            const SizedBox(height: 16),
            AccountCard(
              balance: context.watch<TransactionProvider>().getTotal(),
              account: "DEFAULT",
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Accounts',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...walletList.map((wallet) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: WalletCard(
                                    amount: 00,
                                    isEnabled: currentWallet == wallet,
                                    onTap: () {
                                      context
                                          .read<WalletProvider>()
                                          .setCurrentWallet(wallet);
                                    },
                                    color: kPrimary.withOpacity(0.3),
                                    iconData: Icons.account_balance_outlined,
                                    title: wallet.name,
                                  ),
                                );
                              }).toList(),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: TextButton(
                                  onPressed: () {
                                    PageNavigation().pushPage(
                                      context: context,
                                      page: const CreateWallet(),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 30,
                                        color: kPrimary,
                                      ),
                                      SizedBox(height: 6),
                                      Text("New Account"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
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
                            transactionList: context
                                .watch<TransactionProvider>()
                                .getTransactionList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
