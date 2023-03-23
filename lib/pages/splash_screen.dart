import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/home_page.dart';
import 'package:pocket_guard/services/storage_service.dart';
import 'package:pocket_guard/utilities/page_navigation.dart';

import '../utilities/constants.dart';
import 'auth_screens/auth_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() async {
    String? token = await StorageService().getToken;

    const Duration duration = Duration(seconds: 4);
    await Future.delayed(duration, () {
      PageNavigation().replacePage(
        context: context,
        page: token != null ? const HomePage() : const AuthHome(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimary,
      body: FutureBuilder(
          future: navigate(),
          builder: (context, snapshot) {
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
