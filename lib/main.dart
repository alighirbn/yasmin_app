import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/contract.dart';
import 'services/auth_service.dart';
import 'screens/contracts_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart'; // Custom theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the boxes
  await Hive.initFlutter();
  Hive.registerAdapter(ContractAdapter());
  Hive.registerAdapter(BuildingAdapter());
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(InstallmentAdapter());
  Hive.registerAdapter(PaymentAdapter());
  await Hive.openBox<Contract>('contractsBox');
  await Hive.openBox('authBox'); // Box for authentication token

  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contract App',
      theme: AppTheme.lightTheme, // Use custom light theme
      darkTheme: AppTheme.darkTheme, // Use custom dark theme
      themeMode: ThemeMode.system, // Follow system theme
      home: isLoggedIn ? ContractsScreen() : LoginScreen(),
    );
  }
}