import 'package:flutter/material.dart';
import '../models/contract.dart';

class BuildingInfoScreen extends StatelessWidget {
  final Building building;

  BuildingInfoScreen({required this.building});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Building Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Building Number: ${building.number}', style: TextStyle(fontSize: 18)),
            Text('Address: ${building.address}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
