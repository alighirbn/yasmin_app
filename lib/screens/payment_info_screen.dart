import 'package:flutter/material.dart';
import '../models/contract.dart';
import 'package:intl/intl.dart'; // For date formatting

class PaymentInfoScreen extends StatelessWidget {
  final Contract contract;

  PaymentInfoScreen({required this.contract});

  @override
  Widget build(BuildContext context) {
    // Access the theme colors and text styles
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
        title: Text(
          'معلومات الدفع',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Paid and Last Payment Date
              Text(
                'المبلغ المدفوع: ${numberFormat.format(totalAmountPaid)} دينار',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(height: 10),
              Text(
                'تاريخ آخر دفعة: $lastPaymentDate',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
                color: colorScheme.onSurface.withOpacity(0.2),
              ),
              SizedBox(height: 20),

              // Payment History
              Text(
                'سجل المدفوعات:',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: contract.payments.isEmpty
                    ? Center(
                  child: Text(
                    'لا توجد مدفوعات متاحة.',
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
                  ),
                )
                    : ListView.builder(
                  itemCount: contract.payments.length,
                  itemBuilder: (context, index) {
                    final payment = contract.payments[index];
                    return Card(
                      color: colorScheme.surface,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          'المبلغ: ${numberFormat.format(payment.paymentAmount)} دينار',
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                        ),
                        subtitle: Text(
                          'التاريخ: ${_formatDate(payment.createdAt)}',
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withOpacity(0.8)),
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