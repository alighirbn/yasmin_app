import 'package:flutter/material.dart';
import '../models/contract.dart';

class ContractDetailScreen extends StatelessWidget {
  final Contract contract;

  ContractDetailScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل العقد', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailSection('رقم العقار', contract.building.number),
                _buildDetailSection('الاسم', contract.customer.fullName),
                _buildDetailSection('مبلغ العقد', '\$${contract.contractAmount}'),
                _buildDetailSection('تأريخ العقد', contract.contractDate),
                _buildDetailSection('ملاحظات', contract.contractNote),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.lightBlue, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Text('$label: $value', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
