import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/auth_screens/login_screen.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/user_auth_provider.dart';
import '../../utilities/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'First name',
                      controller: _firstNameController,
                      hintText: "Enter your First name",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixWidget: null,
                    ),
                    CustomTextField(
                      label: 'Last name',
                      controller: _lastNameController,
                      hintText: "Enter your last name",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixWidget: null,
                    ),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: "Enter your email",
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                            size: 17,
                          ),
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
                    _passwordController.text.isNotEmpty &&
                    _firstNameController.text.isNotEmpty &&
                    _lastNameController.text.isNotEmpty) {
                  await context.read<UserAuthProvider>().signUpUser(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                      );
                } else {
                  showSnackBar(
                    context: context,
                    text: "Please make sure all forms are filled",
                  );
                }
              },
              child: const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Or",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    PageNavigation().replacePage(
                      context: context,
                      page: const LoginScreen(),
                    );
                  },
                  child: const Text(
                    "Log in",
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
