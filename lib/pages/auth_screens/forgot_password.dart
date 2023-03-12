import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';

import '../../utilities/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            PageNavigation().popPagesMultipleTimes(context: context, times: 1);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Forgot password",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your email\n"
              "We'll send a link "
              "for you to reset"
              "Your password",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
            SizedBox(height: size.height * 0.1),
            Center(
              child: CustomButton(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: size.width * 0.3,
                ),
                borderColor: Colors.black,
                color: Colors.black,
                borderRadius: 20,
                onTap: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
                  onPressed: () {},
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
