import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String claveFija = "admin", usuarioFijo = "admin";

  Future<bool> signIn(String user, String pass) async {
    if (pass == claveFija && user == usuarioFijo) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user', user);
      return true;
    }
    notifyListeners();
    return false;
  }
}
