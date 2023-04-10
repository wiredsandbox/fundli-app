import 'dart:convert';

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
