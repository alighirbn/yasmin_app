import 'package:yasmin_app/models/contract.dart';
import 'package:flutter/material.dart';
import '../services/local_database_service.dart';

class AddContractScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _buildingNumberController = TextEditingController();
  final _contractAmountController = TextEditingController();
  final _contractDateController = TextEditingController();
  final _customerNameController = TextEditingController();
  final LocalDatabaseService _dbService = LocalDatabaseService();

  void _saveContract(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final contract = {
        'building_number': _buildingNumberController.text,
        'contract_amount': double.parse(_contractAmountController.text),
        'contract_date': _contractDateController.text,
        'customer_full_name': _customerNameController.text,
      };
      await _dbService.insertContract(contract as Contract);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contract')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _buildingNumberController,
                decoration: InputDecoration(labelText: 'Building Number'),
                validator: (value) => value!.isEmpty ? 'Enter building number' : null,
              ),
              TextFormField(
                controller: _contractAmountController,
                decoration: InputDecoration(labelText: 'Contract Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter contract amount' : null,
              ),
              TextFormField(
                controller: _contractDateController,
                decoration: InputDecoration(labelText: 'Contract Date'),
                validator: (value) => value!.isEmpty ? 'Enter contract date' : null,
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(labelText: 'Customer Full Name'),
                validator: (value) => value!.isEmpty ? 'Enter customer name' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveContract(context),
                child: Text('Save Contract'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
