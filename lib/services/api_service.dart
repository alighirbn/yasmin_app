import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../config.dart';
import '../models/contract.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fetch contracts from API or Hive
  Future<List<Contract>> fetchContracts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      throw Exception('No token found');
    }

    try {
      // Check if the device is online
      final bool isOnline = await _hasInternetConnection();

      if (isOnline) {
        // Fetch contracts from API
        final response = await _dio.get(
          '${AppConfig.baseUrl}/contracts',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Parse contracts from API response
          List<Contract> contracts = (response.data['data'] as List)
              .map((contractData) {
            return Contract.fromJson(contractData);
          }).toList();

          // Save contracts to Hive
          final box = await Hive.openBox<Contract>('contracts');
          await box.clear(); // Clear old data
          await box.addAll(contracts);

          return contracts;
        } else {
          throw Exception('Failed to load contracts from API: ${response.statusCode}');
        }
      } else {
        // If offline, fetch from Hive
        final box = await Hive.openBox<Contract>('contracts');
        if (box.isEmpty) {
          throw Exception('No contracts available offline');
        }
        return box.values.toList();
      }
    } on DioException catch (e) {
      throw Exception('API error: ${e.message}');
    } on HiveError catch (e) {
      throw Exception('Hive error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch contracts: $e');
    }
  }

  // Helper method to check internet connection
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}