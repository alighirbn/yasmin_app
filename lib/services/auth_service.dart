import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
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

        // Store the token in Hive
        final authBox = Hive.box('authBox');
        await authBox.put('auth_token', token);
        return true;
      }
    } on DioError catch (e) {
      print('Login failed: ${e.message}');
    } catch (e) {
      print('Unexpected error during login: $e');
    }
    return false;
  }



  Future<bool> isLoggedIn() async {
    final authBox = Hive.box('authBox');
    final token = authBox.get('auth_token');

    // Debug the token
    print('Token from Hive: $token');

    if (token == null || token.isEmpty ) {
      // Clear the invalid token
      await authBox.delete('auth_token');
      return false;
    }


      return true;

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
      final authBox = Hive.box('authBox');
      await authBox.delete('auth_token');
    }
  }

  Future<String?> getAuthToken() async {
    final authBox = Hive.box('authBox');
    return authBox.get('auth_token');
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
        final authBox = Hive.box('authBox');
        await authBox.put('auth_token', newToken);
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