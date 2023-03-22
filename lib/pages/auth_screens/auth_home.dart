import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/auth_screens/login_screen.dart';
import 'package:pocket_guard/pages/auth_screens/sign_up_screen.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/widgets/custom_button.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  State<AuthHome> createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  final PageNavigation _navigation = PageNavigation();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/splash_logo.png',
                width: size.width * 0.5,
                height: size.height * 0.7,
              ),
            ),
          ),
          Container(
            height: size.height * 0.39,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Get your finances in order\n',
                        style: TextStyle(
                          color: kPrimary,
                          fontSize: size.width * 0.065,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: '\nTrack Expenses, Manage Accounts, Budget, '
                            'and Never Miss a Bill Payment!',
                        style: TextStyle(
                          color: kPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.124, vertical: 16),
                        borderColor: kPrimary,
                        color: kPrimary,
                        borderRadius: 8,
                        onTap: () {
                          _navigation.replacePage(
                            context: context,
                            page: const LoginScreen(),
                          );
                        },
                        child: const Text("Log in"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.124, vertical: 16),
                        borderColor: kPrimary,
                        color: Colors.white,
                        borderRadius: 8,
                        onTap: () {
                          _navigation.replacePage(
                            context: context,
                            page: const SignUp(),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: kPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
