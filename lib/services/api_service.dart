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
        final response = await _dio.get(
          '${AppConfig.baseUrl}/contracts',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Parse and save contracts to Hive
          List<Contract> contracts = (response.data['data'] as List)
              .map((contractData) {
            return Contract(
              id: contractData['id'],
              userIdCreate: contractData['user_id_create'],
              userIdUpdate: contractData['user_id_update'],
              contractCustomerId: contractData['contract_customer_id'],
              contractBuildingId: contractData['contract_building_id'],
              contractPaymentMethodId: contractData['contract_payment_method_id'],
              urlAddress: contractData['url_address'] ?? '',
              contractAmount: (contractData['contract_amount'] is String)
                  ? double.tryParse(contractData['contract_amount']) ?? 0.0
                  : (contractData['contract_amount'] as num).toDouble(),
              contractDate: contractData['contract_date'] ?? '',
              contractNote: contractData['contract_note'] ?? '',
              stage: contractData['stage'] ?? '',
              temporaryAt: contractData['temporary_at'] ?? '',
              acceptedAt: contractData['accepted_at'],
              authenticatedAt: contractData['authenticated_at'],
              createdAt: contractData['created_at'] ?? '',
              updatedAt: contractData['updated_at'] ?? '',
              synced: contractData['synced'] == 1,
              building: Building.fromJson(contractData['building']),
              customer: Customer.fromJson(contractData['customer']),
              contractInstallments: (contractData['contract_installments'] as List)
                  .map((installment) => Installment.fromJson(installment))
                  .toList(),
              payment: Payment.fromJson(contractData['payment']), // Added Payment parsing
            );
          }).toList();

          // Save contracts to Hive
          final box = await Hive.openBox<Contract>('contracts');
          await box.clear(); // Clear old data
          await box.addAll(contracts);

          return contracts;
        } else {
          throw Exception('Failed to load contracts from API');
        }
      } else {
        // If offline, fetch from Hive
        final box = await Hive.openBox<Contract>('contracts');
        return box.values.toList();
      }
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
