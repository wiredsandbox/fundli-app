import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_guard/utilities/constants.dart';

import '../models/user_auth_model.dart';

class AuthService {
  Future<UserAuthModel?> signUP({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      const String endpoint = "account/signup";

      final body = jsonEncode({
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
      });

      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        UserAuthModel userAuthModel = UserAuthModel(
          id: data['id'],
          email: data['email'],
          lastName: data['lastName'],
          firstName: data['firstName'],
          token: data['token'],
        );

        return userAuthModel;
      } else {
        debugPrint(
            "!------------Error sign up service code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return null;
    }
  }

  Future<UserAuthModel?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      const String endpoint = "account/login";

      final body = jsonEncode({
        "email": email,
        "password": password,
      });

      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        UserAuthModel userAuthModel = UserAuthModel(
          id: data['id'],
          email: data['email'],
          lastName: data['lastName'],
          firstName: data['firstName'],
          token: data['token'],
        );

        return userAuthModel;
      } else {
        debugPrint(
            "!------------Error login service code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with login service: $e");
      return null;
    }
  }

  Future<bool> sendPasswordResetLink({required String email}) async {
    try {
      String endpoint = "account/forgot-password";

      Dio dio = Dio();

      dio.options.headers.addAll({"Content-Type": "application/json"});

      await dio.post("$baseUrl$endpoint", data: {"email": email});

      return true;
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return false;
    }
  }

  Future<bool> forgotPasswordConfirmOtp({
    required String email,
    required String code,
  }) async {
    try {
      String endpoint = "account/forgot-password";

      Dio dio = Dio();

      dio.options.headers.addAll({"Content-Type": "application/json"});

      final response = await dio
          .post("$baseUrl$endpoint", data: {"email": email, "code": code});

      debugPrint(response.statusCode.toString());
      debugPrint("Otp confirmed: ${response.data}");

      return true;
    } catch (e) {
      debugPrint("Caught error with sign up service: $e");
      return false;
    }
  }

  Future createNewPassword({
    required String email,
    required String password,
    required int code,
  }) async {
    print("///////////Creating new password");
    print({"email": email, "password": password, "code": code});
    try {
      String endpoint = "account/reset-password/";

      Dio dio = Dio();

      dio.options.headers.addAll({"Content-Type": "application/json"});

      final response = await dio.post("$baseUrl$endpoint",
          data: {"email": email, "password": password, "code": code});

      debugPrint(response.statusCode.toString());
      debugPrint("Otp confirmed: ${response.data}");

      return true;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error code: ${e.response!.statusCode}");
        debugPrint("Error message: ${e.response!.data}");
      }

      debugPrint("Caught error with sign up service: $e");
      return false;
    }
  }

  Future<UserAuthModel?> fetchUserAccount({required String token}) async {
    String endpoint = "account/me/";

    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);

        return UserAuthModel(
            id: data['id'],
            email: data['email'],
            lastName: data['lastName'],
            firstName: data['firstName'],
            token: token);
      } else {
        debugPrint("Error fetchUserAccount service: ${response.statusCode}");
        debugPrint("Error Body: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetchUserAccount service: $e");
      return null;
    }
  }
}
