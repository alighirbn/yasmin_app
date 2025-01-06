import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/contract.dart';
import 'services/auth_service.dart';
import 'screens/contracts_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the box
  await Hive.initFlutter();
  Hive.registerAdapter(ContractAdapter());
  Hive.registerAdapter(BuildingAdapter());
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(InstallmentAdapter());
  Hive.registerAdapter(PaymentAdapter());
  // Open the contracts box
  await Hive.openBox<Contract>('contractsBox');

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? ContractsScreen() : LoginScreen(),
    );
  }
}
