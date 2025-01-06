import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp
import '../services/auth_service.dart';
import '../services/data_sync_service.dart';
import '../models/contract.dart';
import 'contract_detail_screen.dart';
import 'building_info_screen.dart';
import 'installments_info_screen.dart';
import 'payment_info_screen.dart';
import 'login_screen.dart'; // Assuming you have a login screen to navigate to after logout

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

  // Method to handle logout
  void _logout(BuildContext context) {
    AuthService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Method to open WhatsApp
  void _openWhatsApp() async {
    const phoneNumber = '+9647800007345'; // Replace with the desired phone number
    const message = 'مرحباً هل يمكنكم مساعدتي حول معلومات العقد '; // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Fallback: Open the URL in a web browser
      final webUrl = 'https://web.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';
      if (await canLaunch(webUrl)) {
        await launch(webUrl);
      } else {
        // Show a snackbar if neither WhatsApp nor the web URL can be launched
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('لم نتمكن من فتح تطبيق الوتساب.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عقاراتي',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[600]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Contract>>(
          future: _contracts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'فشل في تحميل العقود',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _contracts = DataSyncService().fetchContracts();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[700],
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد عقود متاحة.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              );
            }

            final contracts = snapshot.data!;

            // Auto-select the first contract if not already selected
            if (_selectedContract == null && contracts.isNotEmpty) {
              _selectedContract = contracts[0];
            }

            return Column(
              children: [
                _buildContractDropdown(contracts),
                _selectedContract == null
                    ? Center(
                  child: Text(
                    'اختر عقدًا',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                )
                    : Expanded(
                  child: _buildContractDashboard(context),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openWhatsApp,
        backgroundColor: Colors.green, // WhatsApp green color
        child: Icon(
          Icons.message, // WhatsApp icon
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildContractDropdown(List<Contract> contracts) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButton<Contract>(
          isExpanded: true,
          hint: Text(
            'اختر عقدًا',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textDirection: TextDirection.rtl,
          ),
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
                'العقد ID: ${contract.id} - المبنى ${contract.building.buildingNumber}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textDirection: TextDirection.rtl,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContractDashboard(BuildContext context) {
    if (_selectedContract == null) {
      return Center(
        child: Text(
          'اختر عقدًا',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
      );
    }

    final installmentCount = _selectedContract!.contractInstallments.length;
    final totalInstallmentAmount = _selectedContract!.contractInstallments
        .fold(0.0, (sum, installment) => sum + installment.installmentAmount);

    final totalAmountPaid = _selectedContract!.payments.fold(
        0.0, (sum, payment) => sum + payment.paymentAmount);

    final lastPaymentDate = _selectedContract!.payments.isNotEmpty
        ? _selectedContract!.payments
        .reduce((a, b) => a.createdAt.compareTo(b.createdAt) > 0 ? a : b)
        .createdAt
        : 'غير متاح';

    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2; // Adjust for tablets

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.0, // Square tiles
      ),
      itemCount: 4, // Number of tiles
      itemBuilder: (context, index) {
        return DashboardTile(
          title: _getTileTitle(index),
          icon: _getTileIcon(index),
          onTap: () => _navigateToScreen(context, index),
          info: _getTileInfo(index, installmentCount, totalInstallmentAmount,
              totalAmountPaid, lastPaymentDate),
        );
      },
    );
  }

  String _getTileTitle(int index) {
    switch (index) {
      case 0:
        return 'معلومات العقد';
      case 1:
        return 'معلومات المبنى';
      case 2:
        return 'معلومات الأقساط';
      case 3:
        return 'معلومات الدفع';
      default:
        return '';
    }
  }

  IconData _getTileIcon(int index) {
    switch (index) {
      case 0:
        return Icons.info;
      case 1:
        return Icons.home;
      case 2:
        return Icons.payment;
      case 3:
        return Icons.credit_card;
      default:
        return Icons.error;
    }
  }

  String _getTileInfo(int index, int installmentCount, double totalInstallmentAmount,
      double totalAmountPaid, String lastPaymentDate) {
    switch (index) {
      case 0:
        return 'رقم العقد: ${_selectedContract!.id}';
      case 1:
        return 'المبنى: ${_selectedContract!.building.buildingNumber}';
      case 2:
        return 'عدد الأقساط: $installmentCount\nالمجموع: ${totalInstallmentAmount.toStringAsFixed(2)} ر.س';
      case 3:
        return 'المدفوع: ${totalAmountPaid.toStringAsFixed(2)} ر.س\nآخر دفع: $lastPaymentDate';
      default:
        return '';
    }
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractDetailScreen(contract: _selectedContract!),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuildingInfoScreen(building: _selectedContract!.building),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InstallmentsInfoScreen(contract: _selectedContract!),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentInfoScreen(contract: _selectedContract!),
          ),
        );
        break;
    }
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.blueGrey[700]!, Colors.blueGrey[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 8),
              Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}