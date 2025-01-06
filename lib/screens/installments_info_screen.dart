import 'package:flutter/material.dart';
import '../models/contract.dart';

class InstallmentsInfoScreen extends StatelessWidget {
  final Contract contract;

  InstallmentsInfoScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    final installmentCount = contract.contractInstallments.length;
    final totalAmount = contract.contractInstallments
        .fold(0.0, (sum, installment) => sum + installment.amount);

    return Scaffold(
      appBar: AppBar(title: Text('Installments Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Installments: $installmentCount', style: TextStyle(fontSize: 18)),
            Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
