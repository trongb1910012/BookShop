import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../services/auth_service.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  Timer? _authTimer;
  String? _authEmail;

  final AuthService _authService = AuthService();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  bool get isAdmin {
    return _authEmail == 'admin@gmail.com';
  }

  String? get email {
    return _authEmail;
  }

  AuthToken? get authToken {
    return _authToken;
  }

  void _setEmail(String email) {
    _authEmail = email;
    notifyListeners();
  }

  void _setAuthToken(AuthToken token) {
    _authToken = token;
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    _setAuthToken(await _authService.signup(email, password));
  }

  Future<void> login(String email, String password) async {
    _setAuthToken(await _authService.login(email, password));
    _setEmail(email);
  }

  Future<bool> tryAutoLogin() async {
    final savedToken = await _authService.loadSavedAuthToken();
    if (savedToken == null) {
      return false;
    }

    _setAuthToken(savedToken);
    return true;
  }

  Future<void> logout() async {
    _authToken = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    _authService.clearSavedAuthToken();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry =
        _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
