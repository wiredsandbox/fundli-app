import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/widgets/circular_button.dart';
import 'package:provider/provider.dart';

import '../../provider/user_auth_provider.dart';
import '../../utilities/constants.dart';
import '../../utilities/show_snack_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'forgot_password_verify_email.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularButton(
                      internalPadding: const EdgeInsets.only(left: 6),
                      iconData: Icons.arrow_back_ios,
                      onPressed: () {
                        PageNavigation()
                            .popPagesMultipleTimes(context: context, times: 1);
                      }),
                  const Text(
                    "Forgot password",
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.09,
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: size.height * 0.06),
                    SizedBox(
                      height: size.height * 0.123,
                      width: size.width * 0.24,
                      child: Image.asset(
                        "assets/images/forgot-password-lock.png",
                      ),
                    ),
                    SizedBox(height: size.height * 0.089),
                    const Text(
                      "Forgot password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please enter your email  to receive a"
                      " verification code to set a new password ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: "Enter your email",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixWidget: null,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: CustomButton(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        borderColor: kPrimary,
                        color: kPrimary,
                        borderRadius: 8,
                        onTap: () async {
                          if (_emailController.text.isNotEmpty) {
                            bool success = await context
                                .read<UserAuthProvider>()
                                .forgotPasswordLink(
                                    email: _emailController.text);

                            await Future.delayed(
                                const Duration(milliseconds: 100), () {
                              if (success) {
                                PageNavigation().pushPage(
                                  context: context,
                                  page: ForgotPasswordVerifyEmail(
                                      email: _emailController.text),
                                );
                              } else {
                                showSnackBar(
                                    context: context,
                                    text: "We couldn't process that");
                              }
                            });
                          } else {
                            showSnackBar(
                                context: context, text: "Enter your email");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Or",
                    //       style: TextStyle(
                    //         color: Colors.grey[600],
                    //       ),
                    //     ),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: const Text(
                    //         "Log in",
                    //         style: TextStyle(
                    //           decoration: TextDecoration.underline,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
