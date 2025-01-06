import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import '../models/contract.dart';

class InstallmentsInfoScreen extends StatelessWidget {
  final Contract contract;

  InstallmentsInfoScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    final installmentCount = contract.contractInstallments.length;
    final totalAmount = contract.contractInstallments
        .fold(0.0, (sum, installment) => sum + installment.installmentAmount);

    // Create a NumberFormat instance for formatting numbers with commas
    final numberFormat = NumberFormat("#,###", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: Text('معلومات الأقساط', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[800],
        iconTheme: IconThemeData(color: Colors.white),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display total installments and total amount
              Text(
                'إجمالي الأقساط: $installmentCount',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'المبلغ الإجمالي: ${numberFormat.format(totalAmount)} دينار',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20), // Add some spacing

              // Display a list of installments
              Expanded(
                child: ListView.builder(
                  itemCount: contract.contractInstallments.length,
                  itemBuilder: (context, index) {
                    final installment = contract.contractInstallments[index];
                    return Card(
                      color: Colors.blueGrey[700],
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          'القسط ${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المبلغ: ${numberFormat.format(installment.installmentAmount)} دينار',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'تاريخ الاستحقاق: ${installment.installmentDate}', // Updated field name
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),

                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}