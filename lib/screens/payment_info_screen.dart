import 'package:flutter/material.dart';
import '../models/contract.dart';

class PaymentInfoScreen extends StatelessWidget {
  final Contract contract;

  PaymentInfoScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    final totalAmountPaid = contract.payment.amount;
    final lastPaymentDate = contract.payment.createdAt;

    return Scaffold(
      appBar: AppBar(title: Text('Payment Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Paid: \$${totalAmountPaid.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            Text('Last Payment Date: $lastPaymentDate', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
