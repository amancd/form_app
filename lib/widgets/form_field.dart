import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Function(String?) validator;

  const CustomFormField({super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.deepOrange.shade600),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange.withOpacity(0.5)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.deepOrange.withOpacity(0.7)),
      ),
      style: TextStyle(color: Colors.deepOrange.shade600),
      validator: (value) => validator(value),
    );
  }
}
