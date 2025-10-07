import 'package:flutter/material.dart';
import '../models/user.dart' as AppUser;

class AuthProvider with ChangeNotifier {
  AppUser.User? _user;

  AppUser.User? get user => _user;

  Future<void> signIn(String email, String password) async {
    // Simular login
    await Future.delayed(Duration(seconds: 1));
    _user = AppUser.User(
      id: '1',
      email: email,
      name: 'Usuario Demo',
    );
    notifyListeners();
  }

  Future<void> signUp(String email, String password, String name) async {
    // Simular registro
    await Future.delayed(Duration(seconds: 1));
    _user = AppUser.User(
      id: '1',
      email: email,
      name: name,
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthState() async {
    // No hacer nada
  }
}