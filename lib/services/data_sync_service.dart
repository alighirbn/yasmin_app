import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/contract.dart';
import '../config.dart';
import 'auth_service.dart';

class DataSyncService {
  final Dio _dio = Dio();
  final AuthService _authService = AuthService();

  // Fetch contracts from API or Hive
  Future<List<Contract>> fetchContracts() async {
    try {
      // Check for internet connection
      final bool isOnline = await _hasInternetConnection();

      if (isOnline) {
        // Get the auth token
        String? token = await _authService.getAuthToken();

        if (token != null) {
          final response = await _dio.get(
            '${AppConfig.baseUrl}/contracts',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );

          if (response.statusCode == 200) {
            final List<dynamic> contractsJson = response.data['data'];

            // Map the JSON list to a list of Contract objects
            final List<Contract> contracts =
            contractsJson.map((json) => Contract.fromJson(json)).toList();

            // Save contracts to Hive
            final box = await Hive.openBox<Contract>('contracts');
            await box.clear(); // Clear old data
            await box.addAll(contracts);

            return contracts;
          } else {
            throw Exception('Failed to fetch contracts from API, status code: ${response.statusCode}');
          }
        } else {
          throw Exception('User is not authenticated. Please login again.');
        }
      } else {
        // If offline, fetch from Hive
        final box = await Hive.openBox<Contract>('contracts');
        return box.values.toList();
      }
    } catch (e) {
      print('Error fetching contracts: $e');
      rethrow;
    }
  }

  // Helper method to check internet connection
  Future<bool> _hasInternetConnection() async {
    try {
      // Try to connect to a reliable host (e.g., Google's DNS server)
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
