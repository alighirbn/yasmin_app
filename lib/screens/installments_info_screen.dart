import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For number formatting
import '../models/contract.dart';

class InstallmentsInfoScreen extends StatelessWidget {
  final Contract contract;

  InstallmentsInfoScreen({required this.contract});

  // Function to check if the installment is due
  bool isInstallmentDue(String installmentDate) {
    final now = DateTime.now();
    final dueDate = DateTime.parse(installmentDate);
    return dueDate.isBefore(now);
  }

  @override
  Widget build(BuildContext context) {
    // Access the theme colors and text styles
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final installmentCount = contract.contractInstallments.length;
    final totalAmount = contract.contractInstallments
        .fold(0.0, (sum, installment) => sum + installment.installmentAmount);

    // Calculate the total remaining amount (unpaid installments)
    final totalRemainingAmount = contract.contractInstallments
        .where((installment) => installment.paid != 1) // Filter unpaid installments
        .fold(0.0, (sum, installment) => sum + installment.installmentAmount);

    // Create a NumberFormat instance for formatting numbers with commas
    final numberFormat = NumberFormat("#,###", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'معلومات الأقساط',
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
              // Display total installments and total amount
              Text(
                'إجمالي الأقساط: $installmentCount',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
              ),
              Text(
                'المبلغ الإجمالي: ${numberFormat.format(totalAmount)} دينار',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
              ),
              Text(
                'المبلغ المتبقي: ${numberFormat.format(totalRemainingAmount)} دينار',
                style: textTheme.titleMedium?.copyWith(
                  color: totalRemainingAmount > 0 ?  colorScheme.onPrimary : Colors.green, // Highlight remaining amount
                ),
              ),
              SizedBox(height: 20), // Add some spacing

              // Display a list of installments
              Expanded(
                child: ListView.builder(
                  itemCount: contract.contractInstallments.length,
                  itemBuilder: (context, index) {
                    final installment = contract.contractInstallments[index];
                    final isDue = isInstallmentDue(installment.installmentDate);

                    return Card(
                      color: colorScheme.surface,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          'القسط ${index + 1}',
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المبلغ: ${numberFormat.format(installment.installmentAmount)} دينار',
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withOpacity(0.8)),
                            ),
                            Text(
                              'تاريخ الاستحقاق: ${installment.installmentDate}',
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withOpacity(0.8)),
                            ),
                            // Show if the installment is paid or not
                            Row(
                              children: [
                                Icon(
                                  installment.paid == 1 ? Icons.check_circle : Icons.cancel,
                                  color: installment.paid == 1 ? Colors.green : Colors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  installment.paid == 1 ? 'مدفوع' : 'غير مدفوع',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: installment.paid == 1 ? Colors.green : Colors.red,
                                  ),
                                ),
                                // Show due icon if the installment is due and not paid
                                if (isDue && installment.paid != 1)
                                  Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.warning,
                                        color: Colors.orange,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'مستحق',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
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