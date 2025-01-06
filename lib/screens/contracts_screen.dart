import 'package:flutter/material.dart';
import '../services/data_sync_service.dart';
import '../models/contract.dart';
import 'contract_detail_screen.dart';
import 'building_info_screen.dart'; // A new screen for building info
import 'installments_info_screen.dart'; // A new screen for installments info
import 'payment_info_screen.dart'; // A new screen for payment info

class ContractsScreen extends StatefulWidget {
  @override
  _ContractsScreenState createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  late Future<List<Contract>> _contracts;
  Contract? _selectedContract;

  @override
  void initState() {
    super.initState();
    _contracts = DataSyncService().fetchContracts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عقاراتي', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey[100],
        child: FutureBuilder<List<Contract>>(
          future: _contracts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _contracts = DataSyncService().fetchContracts();
                        });
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No contracts found.', style: TextStyle(fontSize: 18, color: Colors.grey)),
              );
            }

            final contracts = snapshot.data!;

            // Auto select the first contract if not already selected
            if (_selectedContract == null && contracts.isNotEmpty) {
              _selectedContract = contracts[0];
            }

            return Column(
              children: [
                _buildContractDropdown(contracts),
                _selectedContract == null
                    ? Center(child: Text('Select a contract'))
                    : _buildContractDashboard(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContractDropdown(List<Contract> contracts) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueGrey[300]!),
        ),
        child: DropdownButton<Contract>(
          isExpanded: true,
          hint: Text('Select a Contract', style: TextStyle(color: Colors.blueGrey[800])),
          value: _selectedContract,
          onChanged: (Contract? newValue) {
            setState(() {
              _selectedContract = newValue;
            });
          },
          items: contracts.map<DropdownMenuItem<Contract>>((Contract contract) {
            return DropdownMenuItem<Contract>(
              value: contract,
              child: Text(
                'Contract ID: ${contract.id} - ${contract.building.number}',
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContractDashboard(BuildContext context) {
    final installmentCount = _selectedContract?.contractInstallments?.length ?? 0;
    final totalInstallmentAmount = _selectedContract?.contractInstallments
        ?.fold(0.0, (sum, installment) => sum + (installment.amount ?? 0.0)) ?? 0.0;
    final totalAmountPaid = _selectedContract?.payment?.amount ?? 0.0;
    final lastPaymentDate = _selectedContract?.payment?.createdAt ?? 'N/A';

    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2; // Adjust for tablets

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0, // Square tiles
      ),
      itemCount: 4, // Number of tiles
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return DashboardTile(
              title: 'Contract Info',
              icon: Icons.info,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContractDetailScreen(contract: _selectedContract!),
                  ),
                );
              },
              info: 'ID: ${_selectedContract?.id}',
            );
          case 1:
            return DashboardTile(
              title: 'Building Info',
              icon: Icons.home,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuildingInfoScreen(building: _selectedContract!.building),
                  ),
                );
              },
              info: 'Building: ${_selectedContract?.building.number}',
            );
          case 2:
            return DashboardTile(
              title: 'Installments Info',
              icon: Icons.payment,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstallmentsInfoScreen(contract: _selectedContract!),
                  ),
                );
              },
              info: 'Count: $installmentCount\nTotal: \$${totalInstallmentAmount.toStringAsFixed(2)}',
            );
          case 3:
            return DashboardTile(
              title: 'Payment Info',
              icon: Icons.credit_card,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentInfoScreen(contract: _selectedContract!),
                  ),
                );
              },
              info: 'Paid: \$${totalAmountPaid.toStringAsFixed(2)}\nLast: $lastPaymentDate',
            );
          default:
            return Container();
        }
      },
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String info;

  const DashboardTile({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.blueGrey[50]!, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue, size: 40),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(info, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.blueGrey[700])),
            ],
          ),
        ),
      ),
    );
  }
}