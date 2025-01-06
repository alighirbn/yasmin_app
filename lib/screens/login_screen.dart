import 'package:flutter/material.dart';
import 'package:yasmin_app/services/auth_service.dart'; // Adjust the import based on your folder structure
import 'contracts_screen.dart'; // Redirect to contracts screen after successful login

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // To show loading state

  // Handle the login action
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final email = _emailController.text;
      final password = _passwordController.text;

      bool success = await _authService.login(email, password);

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      if (success) {
        // On successful login, navigate to contracts screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ContractsScreen()),
        );
      } else {
        // Show error if login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[600]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/logo.png', // Replace with your logo path
                        height: 200, // Adjust the height as needed
                        width: 200, // Adjust the width as needed
                      ),
                      SizedBox(height: 20),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(Icons.email, color: Colors.blueGrey[800]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blueGrey[800]!),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'يرجى إدخال البريد الإلكتروني' : null,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: Icon(Icons.lock, color: Colors.blueGrey[800]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blueGrey[800]!),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'يرجى إدخال كلمة المرور' : null,
                        obscureText: true,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 24),
                      _isLoading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[800]!),
                      )
                          : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[800],
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}