import 'package:flutter/material.dart';
import 'package:pocket_guard/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

import '../models/user_auth_model.dart';
import '../provider/user_auth_provider.dart';
import '../utilities/constants.dart';
import '../utilities/page_navigation.dart';
import '../utilities/show_snack_bar.dart';
import '../widgets/circular_button.dart';
import '../widgets/regular_text_field.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _walletNumberController = TextEditingController();
  final TextEditingController _walletTypeController = TextEditingController();
  final TextEditingController _walletInitialBalanceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    UserAuthModel userAuthModel =
        context.read<UserAuthProvider>().getUserAuthModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                      iconData: Icons.arrow_back_ios,
                      onPressed: () {
                        PageNavigation().popPagesMultipleTimes(
                          context: context,
                          times: 1,
                        );
                      },
                      internalPadding: const EdgeInsets.only(left: 5),
                    ),
                    const Text(
                      "Add Account",
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircularButton(
                      iconData: Icons.check,
                      onPressed: () async {
                        if (_walletNameController.text.isNotEmpty) {
                          bool walletModel = await context
                              .read<WalletProvider>()
                              .createWallet(
                                  token: userAuthModel.token,
                                  name: _walletNameController.text);

                          await Future.delayed(duration, () {
                            showSnackBar(
                                context: context,
                                text: walletModel
                                    ? "Successfully created wallet"
                                    : "Error creating wallet");
                          });

                          await Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        } else {
                          showSnackBar(
                              context: context,
                              text: "Please make sure you enter all fields");
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RegularTextField(
                  controller: _walletNameController,
                  hintText: "Account Name",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                RegularTextField(
                  controller: _walletNumberController,
                  hintText: "Bank Account number",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 32),
                RegularTextField(
                  controller: _walletTypeController,
                  hintText: "Type",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                RegularTextField(
                  controller: _walletInitialBalanceController,
                  hintText: "Initial Balance",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
