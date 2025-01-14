import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp
import 'package:intl/intl.dart'; // For number formatting
import 'dart:async'; // For Timer
import 'package:dio/dio.dart'; // For API requests
import '../config.dart';
import '../models/NewsItem.dart';
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
    const phoneNumber =
        '+9647800007345'; // Replace with the desired phone number
    const message =
        'مرحباً هل يمكنكم مساعدتي حول معلومات العقد'; // Replace with your message
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Fallback: Open the URL in a web browser
      final webUrl =
          'https://web.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';
      if (await canLaunch(webUrl)) {
        await launch(webUrl);
      } else {
        // Show a snackbar if neither WhatsApp nor the web URL can be launched
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('لم نتمكن من فتح تطبيق الوتساب.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // Helper function to format numbers with commas and IQD
  String formatNumber(double number) {
    final formatter = NumberFormat(
        "#,###", "en_US"); // Use "en_US" for comma as thousand separator
    return '${formatter.format(number)} دينار';
  }

  @override
  Widget build(BuildContext context) {
    // Access the theme colors and text styles
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عقاراتي',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 4,
        centerTitle: true,
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
              opacity: 0.1, // Adjust the opacity to make it subtle
              child: Icon(
                Icons.home, // Replace with your desired icon
                size: 200, // Adjust the size of the icon
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          // Main Content
          Container(
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
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.onPrimary),
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
                                color: colorScheme.error,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'فشل في تحميل العقود',
                                style: textTheme.titleMedium
                                    ?.copyWith(color: colorScheme.onPrimary),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _contracts =
                                        DataSyncService().fetchContracts();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.surface,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: Text(
                                  'إعادة المحاولة',
                                  style: textTheme.titleMedium
                                      ?.copyWith(color: colorScheme.onSurface),
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
                            style: textTheme.titleMedium
                                ?.copyWith(color: colorScheme.onPrimary),
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
                          _buildContractDropdown(
                              contracts, colorScheme, textTheme),
                          _selectedContract == null
                              ? Center(
                                  child: Text(
                                    'اختر عقدًا',
                                    style: textTheme.titleMedium?.copyWith(
                                        color: colorScheme.onPrimary),
                                  ),
                                )
                              : Expanded(
                                  child: _buildContractDashboard(
                                      context, colorScheme, textTheme),
                                ),
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
        backgroundColor: Colors.green, // WhatsApp green color
        child: Icon(
          Icons.message, // WhatsApp icon
          color: Colors.white,
        ),
      ),
    );
  }

  // Define a model for the news item

  // Method to fetch news items from the API
  Future<List<NewsItem>> fetchNewsItems() async {
    final AuthService _authService = AuthService();
    final dio = Dio(); // Create a Dio instance
    try {
      String? token = await _authService.getAuthToken();
      print('Auth Token: $token'); // Debugging: Print the token

      final response = await dio.get(
        '${AppConfig.baseUrl}/newsfeed',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('API Response: ${response.statusCode}'); // Debugging: Print the status code
      print('API Data: ${response.data}'); // Debugging: Print the response data

      if (response.statusCode == 200) {
        // The response is a Map, not a List
        Map<String, dynamic> responseData = response.data;

        // Check if the 'success' field is true
        if (responseData['success'] == true) {
          // Extract the 'data' field, which is a List
          List<dynamic> data = responseData['data'];
          return data.map((item) => NewsItem.fromJson(item)).toList();
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to load news items: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Debugging: Print the error
      throw Exception('Failed to load news items: $e');
    }
  }

  // Build the News Feed Section with auto-scroll
  Widget _buildNewsFeed(ColorScheme colorScheme, TextTheme textTheme) {
    final PageController _pageController = PageController();
    int _currentPage = 0;

    return FutureBuilder<List<NewsItem>>(
      future: fetchNewsItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'فشل في تحميل الأخبار',
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
                ),
                SizedBox(height: 8), // Add some spacing
                Text(
                  'الخطأ: ${snapshot.error}', // Display the actual error message
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا توجد أخبار متاحة.',
              style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
            ),
          );
        }

        final newsItems = snapshot.data!;

        // Auto-scroll logic
        Timer.periodic(Duration(seconds: 5), (Timer timer) {
          if (_currentPage < newsItems.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });

        return Container(
          height: 200, // Adjust the height as needed
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
            controller: _pageController,
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
                      // Background Image
                      Image.network(
                        newsItem.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // News Text
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Text(
                          newsItem.text,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
  Widget _buildContractDropdown(
      List<Contract> contracts, ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          hint: Text(
            'اختر عقدًا',
            style:
                textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
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
                style: textTheme.titleMedium
                    ?.copyWith(color: colorScheme.onSurface),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Build the Contract Dashboard
  Widget _buildContractDashboard(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    if (_selectedContract == null) {
      return Center(
        child: Text(
          'اختر عقدًا',
          style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
        ),
      );
    }

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
          colorScheme: colorScheme,
          textTheme: textTheme,
        );
      },
    );
  }

  // Get the title for each dashboard tile
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

  // Get the icon for each dashboard tile
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

  // Get the information for each dashboard tile
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

  // Navigate to the appropriate screen based on the tile index
  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ContractDetailScreen(contract: _selectedContract!),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BuildingInfoScreen(building: _selectedContract!.building),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                InstallmentsInfoScreen(contract: _selectedContract!),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaymentInfoScreen(contract: _selectedContract!),
          ),
        );
        break;
    }
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

  const DashboardTile({
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
              colors: [
                colorScheme.surface,
                colorScheme.surface,
              ],
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
                color: colorScheme.onPrimary,
                size: 40,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                info,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
