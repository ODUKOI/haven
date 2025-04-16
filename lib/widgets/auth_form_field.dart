import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final dynamic errors;

  const AuthFormField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
    this.errors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            errorText: _getErrorText(),
          ),
          validator: validator,
        ),
        if (errors != null && errors is List)
          ...List<Widget>.from(
            (errors as List).map(
              (error) => Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  error,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String? _getErrorText() {
    if (errors is List && (errors as List).isNotEmpty) {
      return (errors as List).first;
    }
    return null;
  }
}
