import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yasmin_app/services/auth_service.dart';  // Adjust the import based on your folder structure
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

  // Handle the login action
  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      bool success = await _authService.login(email, password);

      if (success) {
        // On successful login, navigate to contracts screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ContractsScreen()),
        );
      } else {
        // Show error if login failed
        Fluttertoast.showToast(msg: 'Login failed. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
