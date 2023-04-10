import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import '../../utilities/page_navigation.dart';
import '../../widgets/circular_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool showPassword = false;
  bool showNewPassword = false;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                    SizedBox(height: size.height * 0.055),
                    SizedBox(
                      height: size.height * 0.123,
                      width: size.width * 0.24,
                      child: Image.asset(
                        "assets/images/forgot-password-lock.png",
                      ),
                    ),
                    SizedBox(height: size.height * 0.085),
                    const Text(
                      "New password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your New Password Must be Different "
                      "From Previously Used Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    CustomTextField(
                      label: 'New password',
                      controller: _newPasswordController,
                      hintText: "xxxxxxx",
                      obscureText: false,
                      textInputType: TextInputType.text,
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
                    CustomTextField(
                      label: 'Confirm password',
                      controller: _confirmPasswordController,
                      hintText: "xxxxxxx",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixWidget: InkWell(
                        onTap: () {
                          setState(() {
                            showNewPassword = !showNewPassword;
                          });
                        },
                        child: Icon(
                          showNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: CustomButton(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        borderColor: kPrimary,
                        color: kPrimary,
                        borderRadius: 8,
                        onTap: () async {
                          // if (_emailController.text.isNotEmpty) {
                          //   bool success = await context
                          //       .read<UserAuthProvider>()
                          //       .forgotPasswordLink(
                          //           email: _emailController.text);
                          //
                          //   await Future.delayed(
                          //       const Duration(milliseconds: 100), () {
                          //     if (success) {
                          //       PageNavigation().pushPage(
                          //           context: context,
                          //           page: const ForgotPasswordOTP());
                          //     } else {
                          //       showSnackBar(
                          //           context: context,
                          //           text: "We couldn't process that");
                          //     }
                          //   });
                          // } else {
                          //   showSnackBar(
                          //       context: context, text: "Enter your email");
                          // }
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
