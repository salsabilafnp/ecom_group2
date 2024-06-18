import 'package:ecom_group2/app/modules/auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import '../../model/login_model.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginResponse? _loginResponse;
  bool _isLoading = false;
  String? _errorMessage;

  LoginResponse? get loginResponse => _loginResponse;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _loginResponse?.token;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _loginResponse = await _authService.login(username, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool get isLoggedIn => _loginResponse != null;
}
