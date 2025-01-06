import 'package:flutter/material.dart';
import '../models/contract.dart';
import 'package:intl/intl.dart'; // For date formatting

class PaymentInfoScreen extends StatelessWidget {
  final Contract contract;

  PaymentInfoScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    // Calculate total amount paid
    final totalAmountPaid = contract.payments.fold(
        0.0, (sum, payment) => sum + payment.paymentAmount);

    // Find the last payment date
    final lastPaymentDate = contract.payments.isNotEmpty
        ? _formatDate(contract.payments
        .reduce((a, b) => a.createdAt.compareTo(b.createdAt) > 0 ? a : b)
        .createdAt)
        : 'لا توجد مدفوعات';

    // Create a NumberFormat instance for formatting numbers with commas
    final numberFormat = NumberFormat("#,###", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: Text('معلومات الدفع', style: TextStyle(color: Colors.white)),
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
              // Total Paid and Last Payment Date
              Text(
                'المبلغ المدفوع: ${numberFormat.format(totalAmountPaid)} دينار',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'تاريخ آخر دفعة: $lastPaymentDate',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.grey[300]),
              SizedBox(height: 20),

              // Payment History
              Text(
                'سجل المدفوعات:',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: contract.payments.isEmpty
                    ? Center(
                  child: Text(
                    'لا توجد مدفوعات متاحة.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: contract.payments.length,
                  itemBuilder: (context, index) {
                    final payment = contract.payments[index];
                    return Card(
                      color: Colors.blueGrey[700],
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          'المبلغ: ${numberFormat.format(payment.paymentAmount)} دينار',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'التاريخ: ${_formatDate(payment.createdAt)}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: payment.approved == 1
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.pending, color: Colors.orange),
                        onTap: () {
                          // Handle payment tap (e.g., navigate to payment details)
                        },
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

  // Helper method to format date (without time)
  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd', 'ar').format(dateTime); // Arabic locale, no time
    } catch (e) {
      return dateString; // Return the original string if parsing fails
    }
  }
}