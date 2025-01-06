import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthService {
  final Dio _dio = Dio();

  // Perform the login request
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        //'https://yasmin.server.local/api/login',
        '${AppConfig.baseUrl}/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // If login is successful, store the token
        final token = response.data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return true;
      }
    } catch (e) {
      print('Login failed: $e');
    }
    return false;
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  // Log the user out by clearing the token
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Get the stored authentication token
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
