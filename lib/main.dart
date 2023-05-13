import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guard/pages/splash_screen.dart';
import 'package:pocket_guard/provider/transaction_provider.dart';
import 'package:pocket_guard/provider/wallet_provider.dart';
import 'package:pocket_guard/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'provider/user_auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///init hive
  await Hive.initFlutter();

  ///open box
  await Hive.openBox("storage");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: kScaffoldBackground,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black, // set the desired color here
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
