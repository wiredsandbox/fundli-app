import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/widgets/account_card.dart';
import 'package:pocket_guard/widgets/expense_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "SpielerEinzig";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: '✌️ ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              TextSpan(
                text: 'Hey $name!',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
        backgroundColor: kScaffoldBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AccountCard(balance: 237282.52, account: "Default"),
            const SizedBox(height: 16),
            const Text(
              "Today’s Transactions",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ExpenseTile(
                    title: "Github",
                    time: "11: 00 AM",
                    amount: 60.01,
                    type: "Debit",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
