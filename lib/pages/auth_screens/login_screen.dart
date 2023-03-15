import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/auth_screens/sign_up_screen.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:pocket_guard/widgets/custom_button.dart';
import 'package:pocket_guard/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../provider/user_auth_provider.dart';
import '../../utilities/page_navigation.dart';
import '../../utilities/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log in",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: kScaffoldBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: "Enter your email",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixWidget: null,
                    ),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      hintText: "Enter your password",
                      obscureText: showPassword,
                      textInputType: TextInputType.visiblePassword,
                      suffixWidget: InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: size.width * 0.3,
              ),
              borderColor: Colors.black,
              color: Colors.black,
              borderRadius: 20,
              onTap: () async {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  await context.read<UserAuthProvider>().loginUser(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                } else {
                  showSnackBar(
                    context: context,
                    text: "Please make sure all forms are filled",
                  );
                }
              },
              child: const Text(
                "Log in",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     PageNavigation().pushPage(
            //       context: context,
            //       page: const ForgotPassword(),
            //     );
            //   },
            //   child: const Text(
            //     "Forgot password",
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    PageNavigation().replacePage(
                      context: context,
                      page: const SignUp(),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
