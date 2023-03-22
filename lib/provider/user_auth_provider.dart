import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/home_page.dart';
import 'package:pocket_guard/services/auth_service.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';

import '../models/user_auth_model.dart';
import '../utilities/page_navigation.dart';

late UserAuthModel _userAuthModel;

class UserAuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserAuthModel get getUserAuthModel => _userAuthModel;

  Future signUpUser({
    required context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    UserAuthModel? userAuthModel = await _authService.signUP(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);

    if (userAuthModel != null) {
      _userAuthModel = userAuthModel;
      notifyListeners();

      PageNavigation().replacePage(
        context: context,
        page: const HomePage(),
      );
    } else {
      showSnackBar(context: context, text: "An error occurred");
    }
  }

  Future loginUser({
    required context,
    required String email,
    required String password,
  }) async {
    UserAuthModel? userAuthModel =
        await _authService.logIn(email: email, password: password);

    if (userAuthModel != null) {
      _userAuthModel = userAuthModel;
      notifyListeners();

      PageNavigation().replacePage(
        context: context,
        page: const HomePage(),
      );
    } else {
      showSnackBar(context: context, text: "An error occurred");
    }
  }

  Future fetchUserAccount() async {
    try {
      UserAuthModel? fetchedData =
          await _authService.fetchUserAccount(token: _userAuthModel.token);

      if (fetchedData != null) {
        _userAuthModel = fetchedData;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
