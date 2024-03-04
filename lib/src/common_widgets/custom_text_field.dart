import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.controller, this.validator,
  });

  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 20
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 231, 231),
          hintText: hintText,
          hintStyle: const TextStyle(color: tGreySnow),
          errorStyle: const TextStyle(
            fontSize: 10.0
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey[600],
          ),
          suffixIcon: suffixIcon != null
              ? Icon(
                  suffixIcon,
                  color: Colors.grey[600],
                )
              : null,
              
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          
        ),
        
      ),
    );
  }
}
