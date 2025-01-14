import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../config.dart';
import '../models/NewsItem.dart';
import '../services/auth_service.dart';
import '../services/data_sync_service.dart';
import '../models/contract.dart';
import 'contract_detail_screen.dart';
import 'building_info_screen.dart';
import 'installments_info_screen.dart';
import 'payment_info_screen.dart';
import 'login_screen.dart';

// Constants for repeated values
const kWhatsAppNumber = '+9647800007345';
const kWhatsAppMessage = 'مرحباً هل يمكنكم مساعدتي حول معلومات العقد';
const kDefaultPadding = 16.0;

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  _ContractsScreenState createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  late Future<List<Contract>> _contracts;
  Contract? _selectedContract;

  @override
  void initState() {
    super.initState();
    _loadContracts();
  }

  // Load contracts from the API
  void _loadContracts() {
    setState(() {
      _contracts = DataSyncService().fetchContracts();
    });
  }

  // Handle user logout
  void _logout(BuildContext context) {
    AuthService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Open WhatsApp with a predefined message
  void _openWhatsApp() async {
     var url = 'https://wa.me/$kWhatsAppNumber?text=${Uri.encodeComponent(kWhatsAppMessage)}';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لم نتمكن من فتح تطبيق الوتساب.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  // Format numbers with commas and IQD
  String formatNumber(double number) {
    final formatter = NumberFormat("#,###", "en_US");
    return '${formatter.format(number)} دينار';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('عقاراتي', style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.onPrimary),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Watermark Icon
          Positioned(
            bottom: 16,
            right: 16,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.home, size: 200, color: colorScheme.onPrimary),
            ),
          ),
          // Main Content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // News Feed Section
                _buildNewsFeed(colorScheme, textTheme),
                // Contracts Section
                Expanded(
                  child: FutureBuilder<List<Contract>>(
                    future: _contracts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error.toString(), colorScheme, textTheme);
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('لا توجد عقود متاحة.', style: textTheme.titleMedium));
                      }

                      final contracts = snapshot.data!;
                      if (_selectedContract == null && contracts.isNotEmpty) {
                        _selectedContract = contracts[0];
                      }

                      return Column(
                        children: [
                          _buildContractDropdown(contracts, colorScheme, textTheme),
                          _selectedContract == null
                              ? Center(child: Text('اختر عقدًا', style: textTheme.titleMedium))
                              : Expanded(child: _buildContractDashboard(context, colorScheme, textTheme)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openWhatsApp,
        backgroundColor: Colors.green,
        child: Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  // Build the News Feed Section
  Widget _buildNewsFeed(ColorScheme colorScheme, TextTheme textTheme) {
    final PageController pageController = PageController();
    int currentPage = 0;

    return FutureBuilder<List<NewsItem>>(
      future: fetchNewsItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString(), colorScheme, textTheme);
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('لا توجد أخبار متاحة.', style: textTheme.titleMedium));
        }

        final newsItems = snapshot.data!;

        // Auto-scroll logic
        Timer.periodic(Duration(seconds: 5), (Timer timer) {
          if (currentPage < newsItems.length - 1) {
            currentPage++;
          } else {
            currentPage = 0;
          }
          pageController.animateToPage(
            currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });

        return Container(
          height: 200,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              final newsItem = newsItems[index];
              return Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        newsItem.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Icon(Icons.error, color: Colors.red));
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Text(
                          newsItem.text,
                          style: textTheme.titleMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Build the Contract Dropdown
  Widget _buildContractDropdown(List<Contract> contracts, ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
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
          hint: Text('اختر عقدًا', style: textTheme.titleMedium),
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
                style: textTheme.titleMedium,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Build the Contract Dashboard
  Widget _buildContractDashboard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    final installmentCount = _selectedContract!.contractInstallments.length;
    final totalInstallmentAmount = _selectedContract!.contractInstallments
        .fold(0.0, (sum, installment) => sum + installment.installmentAmount);
    final totalAmountPaid = _selectedContract!.payments
        .fold(0.0, (sum, payment) => sum + payment.paymentAmount);
    final lastPaymentDate = _selectedContract!.payments.isNotEmpty
        ? _selectedContract!.payments
        .reduce((a, b) => a.createdAt.compareTo(b.createdAt) > 0 ? a : b)
        .createdAt
        : 'غير متاح';

    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return GridView.builder(
      padding: EdgeInsets.all(kDefaultPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        childAspectRatio: 1.0,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return DashboardTile(
          title: _getTileTitle(index),
          icon: _getTileIcon(index),
          onTap: () => _navigateToScreen(context, index),
          info: _getTileInfo(index, installmentCount, totalInstallmentAmount, totalAmountPaid, lastPaymentDate),
          colorScheme: colorScheme,
          textTheme: textTheme,
        );
      },
    );
  }

  // Helper methods for dashboard tiles
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

  String _getTileInfo(
      int index,
      int installmentCount,
      double totalInstallmentAmount,
      double totalAmountPaid,
      String lastPaymentDate) {
    switch (index) {
      case 0:
        return 'رقم العقد: ${_selectedContract!.id}';
      case 1:
        return 'المبنى: ${_selectedContract!.building.buildingNumber}';
      case 2:
        return 'عدد الأقساط: $installmentCount\nالمجموع: ${formatNumber(totalInstallmentAmount)}';
      case 3:
        return 'المدفوع: ${formatNumber(totalAmountPaid)}\nآخر دفع: $lastPaymentDate';
      default:
        return '';
    }
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContractDetailScreen(contract: _selectedContract!)));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingInfoScreen(building: _selectedContract!.building)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => InstallmentsInfoScreen(contract: _selectedContract!)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentInfoScreen(contract: _selectedContract!)));
        break;
    }
  }

  // Fetch news items from the API
  Future<List<NewsItem>> fetchNewsItems() async {
    final dio = Dio();
    try {
      String? token = await AuthService().getAuthToken();
      final response = await dio.get(
        '${AppConfig.baseUrl}/newsfeed',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => NewsItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load news items');
      }
    } catch (e) {
      throw Exception('Failed to load news items: $e');
    }
  }

  // Build error widget
  Widget _buildErrorWidget(String error, ColorScheme colorScheme, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: colorScheme.error, size: 48),
          SizedBox(height: 16),
          Text('فشل في تحميل البيانات', style: textTheme.titleMedium),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadContracts,
            child: Text('إعادة المحاولة', style: textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}

// Dashboard Tile Widget
class DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String info;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const DashboardTile({super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.info,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [colorScheme.surface, colorScheme.surface],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: colorScheme.onPrimary, size: 40),
              SizedBox(height: 12),
              Text(title, style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary)),
              SizedBox(height: 8),
              Text(info, textAlign: TextAlign.center, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}