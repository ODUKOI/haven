import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_haven/services/auth_service.dart';
import 'package:booking_haven/widgets/auth_form_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Map<String, dynamic> _errors = {};

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final result = await ref.read(authServiceProvider).register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          passwordConfirmation: _confirmPasswordController.text.trim(),
        );

    if (result['success'] == true) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _errors = result['errors'] ?? {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthFormField(
                controller: _nameController,
                label: 'Name',
                errors: _errors['name'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthFormField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
