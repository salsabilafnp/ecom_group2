import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  final String apiUrl = 'https://fakestoreapi.com/users';

  Future<void> addUser(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      print('User added successfully: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to add user');
    }
  }
}
