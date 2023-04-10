import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/home_page.dart';
import 'package:pocket_guard/services/auth_service.dart';
import 'package:pocket_guard/services/storage_service.dart';
import 'package:pocket_guard/utilities/show_snack_bar.dart';

import '../models/user_auth_model.dart';
import '../utilities/page_navigation.dart';

late UserAuthModel _userAuthModel;

class UserAuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

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

      await _storageService.storeUserToken(token: userAuthModel.token);

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

      await _storageService.storeUserToken(token: userAuthModel.token);

      notifyListeners();

      PageNavigation().replacePage(
        context: context,
        page: const HomePage(),
      );
    } else {
      showSnackBar(context: context, text: "An error occurred");
    }
  }

  Future forgotPasswordLink({
    required String email,
  }) async {
    final response = await _authService.sendPasswordResetLink(email: email);

    return response;
  }

  Future forgotPasswordConfirmOTP({
    required String code,
    required String email,
  }) async {
    final response =
        await _authService.forgotPasswordConfirmOtp(email: email, code: code);

    return response;
  }

  Future createNewPassword({
    required String email,
    required String password,
    required int code,
  }) async {
    bool response = await _authService.createNewPassword(
        email: email, password: password, code: code);

    return response;
  }

  Future fetchUserAccount() async {
    try {
      String? userToken = await _storageService.getToken;

      if (userToken != null) {
        UserAuthModel? fetchedData =
            await _authService.fetchUserAccount(token: userToken);

        if (fetchedData != null) {
          _userAuthModel = fetchedData;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
