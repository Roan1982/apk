import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as AppUser;

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser.User? _user;

  AppUser.User? get user => _user;

  AuthProvider() {
    checkAuthState();
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = AppUser.User(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName ?? 'Usuario',
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      _user = AppUser.User(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: name,
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  void checkAuthState() {
    _auth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _user = AppUser.User(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          name: firebaseUser.displayName ?? 'Usuario',
        );
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }
}