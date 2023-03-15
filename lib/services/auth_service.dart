import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

      print(body);

      Clipboard.setData(ClipboardData(text: body));

      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        print(data);

        UserAuthModel userAuthModel = UserAuthModel(
          id: data['id'],
          email: data['email'],
          lastName: data['last_name'],
          firstName: data['first_name'],
          token: data['token'],
        );

        return userAuthModel;
      } else {
        debugPrint("Error code: ${response.statusCode}");
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
          lastName: data['last_name'],
          firstName: data['first_name'],
          token: data['token'],
        );

        return userAuthModel;
      } else {
        debugPrint("Error code: ${response.statusCode}");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      debugPrint("Caught error with login service: $e");
      return null;
    }
  }
}
