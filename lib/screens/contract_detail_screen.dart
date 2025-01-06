import 'package:flutter/material.dart';
import '../models/contract.dart';

class ContractDetailScreen extends StatelessWidget {
  final Contract contract;

  ContractDetailScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل العقد', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[800],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[600]!],
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
                _buildSectionTitle('معلومات العقد'),
                _buildDetailCard('رقم العقار', contract.building.buildingNumber),
                _buildDetailCard('مبلغ العقد', '\$${contract.contractAmount}'),
                _buildDetailCard('تأريخ العقد', contract.contractDate),
                _buildDetailCard('ملاحظات', contract.contractNote),

                SizedBox(height: 24),
                _buildSectionTitle('معلومات العميل'),
                _buildDetailCard('الاسم الكامل', contract.customer.customerFullName),
                _buildDetailCard('الهاتف', contract.customer.customerPhone),
                _buildDetailCard('البريد الإلكتروني', contract.customer.customerEmail),
                _buildDetailCard('رقم البطاقة', contract.customer.customerCardNumber),
                _buildDetailCard('جهة الإصدار', contract.customer.customerCardIssudAuth),
                _buildDetailCard('تاريخ الإصدار', contract.customer.customerCardIssudDate),
                _buildDetailCard('اسم الأم', contract.customer.motherFullName),
                _buildDetailCard('العنوان الكامل', contract.customer.fullAddress),
                _buildDetailCard('رقم العنوان', contract.customer.addressCardNumber),
                _buildDetailCard('البائع', contract.customer.saleman),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      color: Colors.blueGrey[700],
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info, color: Colors.lightBlue, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                '$label: $value',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}