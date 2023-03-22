import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';

import '../utilities/constants.dart';
import 'auth_screens/auth_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  navigate() async {
    const Duration duration = Duration(seconds: 2);
    Future.delayed(duration, () {
      timer = Timer(duration, () {
        PageNavigation().replacePage(
          context: context,
          page: const AuthHome(),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //navigate();

    return Scaffold(
      backgroundColor: kPrimary,
      body: FutureBuilder(
          future: navigate(),
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   debugPrint(snapshot.error.toString());
            //   return homePage(size);
            // } else if (snapshot.connectionState == ConnectionState.waiting) {
            //   return homePage(size);
            // }

            return Center(
              child: Image.asset(
                'assets/images/splash_logo.png',
                width: size.width * 0.5,
                height: size.height * 0.7,
              ),
            );
          }),
    );
  }
}
