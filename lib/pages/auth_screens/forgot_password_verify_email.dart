import 'package:flutter/material.dart';
import 'package:pocket_guard/widgets/otp_text_field.dart';
import 'package:provider/provider.dart';

import '../../provider/user_auth_provider.dart';
import '../../utilities/constants.dart';
import '../../utilities/page_navigation.dart';
import '../../utilities/show_snack_bar.dart';
import '../../widgets/circular_button.dart';
import '../../widgets/custom_button.dart';
import 'create_new_password.dart';

class ForgotPasswordVerifyEmail extends StatefulWidget {
  final String email;
  const ForgotPasswordVerifyEmail({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ForgotPasswordVerifyEmail> createState() =>
      _ForgotPasswordVerifyEmailState();
}

class _ForgotPasswordVerifyEmailState extends State<ForgotPasswordVerifyEmail> {
  String code = "";
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
                    "Verify email",
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
                      child: Image.asset("assets/images/mailbox.png"),
                    ),
                    SizedBox(height: size.height * 0.089),
                    const Text(
                      "Verify email address",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Please input the 4 digit code sent to "
                      "${widget.email}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    OTPTextField(onChanged: (value) {
                      setState(() {
                        code = value;
                      });
                    }),
                    const SizedBox(height: 32),
                    Center(
                      child: CustomButton(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        borderColor: kPrimary,
                        color: kPrimary,
                        borderRadius: 8,
                        onTap: () async {
                          if (code.isNotEmpty && code.length == 6) {
                            bool success = await context
                                .read<UserAuthProvider>()
                                .forgotPasswordConfirmOTP(
                                  email: widget.email,
                                  code: code,
                                );

                            await Future.delayed(
                                const Duration(milliseconds: 100), () {
                              if (success) {
                                PageNavigation().pushPage(
                                  context: context,
                                  page: CreateNewPassword(
                                    email: widget.email,
                                    code: code,
                                  ),
                                );
                              }
                            });
                          } else {
                            showSnackBar(
                                context: context, text: "Enter the full code");
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
                    TextButton(
                      onPressed: () async {
                        bool success = await context
                            .read<UserAuthProvider>()
                            .forgotPasswordLink(email: widget.email);

                        Future.delayed(const Duration(milliseconds: 100), () {
                          showSnackBar(
                              context: context,
                              text: success
                                  ? "We sent the code to: ${widget.email}"
                                  : "We couldn't process that");
                        });
                      },
                      child: const Text(
                        "Resend code",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
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
