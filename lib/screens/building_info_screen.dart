import 'package:flutter/material.dart';
import '../models/contract.dart';
import '../widgets/category3_details.dart';
import '../widgets/category1_details.dart'; // Adjust the import path as needed

class BuildingInfoScreen extends StatelessWidget {
  final Building building;

  const BuildingInfoScreen({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'معلومات المبنى',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        elevation: 4,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('المعلومات العامة', textTheme, colorScheme),
                _buildDetailCard('رقم المبنى', building.buildingNumber, colorScheme, textTheme),
                _buildDetailCard('رقم المنزل', building.houseNumber, colorScheme, textTheme),
                _buildDetailCard('رقم البلوك', building.blockNumber, colorScheme, textTheme),
                _buildDetailCard('مساحة المبنى', building.buildingArea, colorScheme, textTheme),


                // Conditional content based on buildingCategoryId
                if (building.buildingCategoryId == 3)
                  Category3Details(colorScheme: colorScheme, textTheme: textTheme),
                if (building.buildingCategoryId == 1)
                  Category1Details(colorScheme: colorScheme, textTheme: textTheme),
                // Add more conditions for other categories
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: textTheme.titleLarge?.copyWith(
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