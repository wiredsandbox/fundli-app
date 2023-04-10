import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_auth_provider.dart';
import '../../utilities/constants.dart';
import '../../utilities/page_navigation.dart';
import '../../utilities/show_snack_bar.dart';
import '../../widgets/circular_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CreateNewPassword extends StatefulWidget {
  final String email;
  final String code;
  const CreateNewPassword({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

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
                      obscureText: showPassword,
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
                      obscureText: showNewPassword,
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
                          print("incursion");
                          if (_newPasswordController.text.isNotEmpty &&
                              _confirmPasswordController.text ==
                                  _newPasswordController.text) {
                            print("Making request");
                            print(widget.code);

                            bool success = await context
                                .read<UserAuthProvider>()
                                .createNewPassword(
                                  email: widget.email,
                                  code: int.parse(widget.code),
                                  password: _confirmPasswordController.text,
                                );

                            await Future.delayed(
                                const Duration(milliseconds: 100), () {
                              if (success) {
                                showSnackBar(
                                    context: context,
                                    text: "Successfully changed password,"
                                        "\nlogin with your new password");

                                PageNavigation().popPagesMultipleTimes(
                                    context: context, times: 3);
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
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
