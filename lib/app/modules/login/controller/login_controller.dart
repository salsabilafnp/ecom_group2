import 'dart:convert';
import 'package:ecom_group2/app/modules/login/model/login_model.dart';
import 'package:http/http.dart' as http;



class AuthService {
  final String baseUrl = "https://fakestoreapi.com";

  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Invalid username or password');
    } else {
      throw Exception('Failed to login');
    }
  }
}