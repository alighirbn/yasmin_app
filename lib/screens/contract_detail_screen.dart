import 'package:flutter/material.dart';
import '../models/contract.dart';

class ContractDetailScreen extends StatelessWidget {
  final Contract contract;

  ContractDetailScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    // Access the theme colors and text styles
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل العقد',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('معلومات العقد', textTheme, colorScheme),
                _buildDetailCard('رقم العقار', contract.building.buildingNumber, colorScheme, textTheme),
                _buildDetailCard('مبلغ العقد', '\$${contract.contractAmount}', colorScheme, textTheme),
                _buildDetailCard('تأريخ العقد', contract.contractDate, colorScheme, textTheme),
                _buildDetailCard('ملاحظات', contract.contractNote, colorScheme, textTheme),

                SizedBox(height: 24),
                _buildSectionTitle('معلومات العميل', textTheme, colorScheme),
                _buildDetailCard('الاسم الكامل', contract.customer.customerFullName, colorScheme, textTheme),
                _buildDetailCard('الهاتف', contract.customer.customerPhone, colorScheme, textTheme),
                _buildDetailCard('البريد الإلكتروني', contract.customer.customerEmail, colorScheme, textTheme),
                _buildDetailCard('رقم البطاقة', contract.customer.customerCardNumber, colorScheme, textTheme),
                _buildDetailCard('جهة الإصدار', contract.customer.customerCardIssudAuth, colorScheme, textTheme),
                _buildDetailCard('تاريخ الإصدار', contract.customer.customerCardIssudDate, colorScheme, textTheme),
                _buildDetailCard('اسم الأم', contract.customer.motherFullName, colorScheme, textTheme),
                _buildDetailCard('العنوان الكامل', contract.customer.fullAddress, colorScheme, textTheme),
                _buildDetailCard('رقم العنوان', contract.customer.addressCardNumber, colorScheme, textTheme),
                _buildDetailCard('البائع', contract.customer.saleman, colorScheme, textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: textTheme.headlineSmall?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, ColorScheme colorScheme, TextTheme textTheme) {
    return Card(
      color: colorScheme.surface,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: colorScheme.primary,
              size: 28,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                '$label: $value',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}