import 'package:flutter/material.dart';
import '../models/contract.dart'; // Adjust the import path as needed

class BuildingInfoScreen extends StatelessWidget {
  final Building building;

  const BuildingInfoScreen({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the theme colors
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
              minHeight: MediaQuery.of(context).size.height, // Ensure it fills the screen
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('المعلومات العامة', textTheme, colorScheme),
                _buildDetailCard('رقم المبنى', building.buildingNumber, colorScheme, textTheme),
                _buildDetailCard('رقم المنزل', building.houseNumber, colorScheme, textTheme),
                _buildDetailCard('رقم البلوك', building.blockNumber, colorScheme, textTheme),
                _buildDetailCard('مساحة المبنى', building.buildingArea, colorScheme, textTheme),
                _buildDetailCard('رقم الفئة', building.buildingCategoryId.toString(), colorScheme, textTheme),
                _buildDetailCard('رقم النوع', building.buildingTypeId.toString(), colorScheme, textTheme),
                _buildDetailCard('رقم التصنيف', building.classificationId.toString(), colorScheme, textTheme),
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
          color: colorScheme.onPrimary, // Use onPrimary for contrast with primary background
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