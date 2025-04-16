import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_haven/services/auth_service.dart';
import 'package:booking_haven/widgets/auth_form_field.dart';
import 'package:booking_haven/screens/auth/register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, dynamic> _errors = {};
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errors = {};
    });

    try {
      final result = await ref.read(authServiceProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (result['success'] == true) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => _errors = result['errors'] ?? {});
        _showErrorSnackbar(_errors);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackbar(Map<String, dynamic> errors) {
    final errorMessage = errors['general']?.first ?? 'Login failed';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthFormField(
                controller: _emailController,
                label: 'Email',
                errors: _errors['email'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthFormField(
                controller: _passwordController,
                label: 'Password',
                obscureText: true,
                errors: _errors['password'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterScreen()),
                        ),
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
