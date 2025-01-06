import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../config.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${AppConfig.baseUrl}/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];

        // Debug the token received from the server
        print('Token from server: $token');

        if (token == null || token.isEmpty) {
          throw Exception('Token is null or empty');
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return true;
      }
    } on DioError catch (e) {
      print('Login failed: ${e.message}');
    } catch (e) {
      print('Unexpected error during login: $e');
    }
    return false;
  }

  bool _isValidJwt(String token) {
    final parts = token.split('.');
    return parts.length == 3; // A valid JWT has 3 parts
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    // Debug the token
    print('Token from SharedPreferences: $token');

    if (token == null || token.isEmpty || !_isValidJwt(token)) {
      // Clear the invalid token
      await prefs.remove('auth_token');
      return false;
    }

    try {
      return !JwtDecoder.isExpired(token);
    } catch (e) {
      print('Error decoding token: $e');
      // Clear the invalid token
      await prefs.remove('auth_token');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(
        '${AppConfig.baseUrl}/logout',
        options: Options(headers: {
          'Authorization': 'Bearer ${await getAuthToken()}',
        }),
      );
    } on DioError catch (e) {
      print('Logout failed: ${e.message}');
    } catch (e) {
      print('Unexpected error during logout: $e');
    } finally {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    }
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> refreshToken() async {
    try {
      final response = await _dio.post(
        '${AppConfig.baseUrl}/refresh-token',
        options: Options(headers: {
          'Authorization': 'Bearer ${await getAuthToken()}',
        }),
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', newToken);
        return true;
      }
    } on DioError catch (e) {
      print('Token refresh failed: ${e.message}');
    } catch (e) {
      print('Unexpected error during token refresh: $e');
    }
    return false;
  }
}