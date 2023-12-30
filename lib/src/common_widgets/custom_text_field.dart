import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  });

  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16,right: 16),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFE7EDEB),
          hintText: hintText,
          hintStyle: const TextStyle(color: tGreySnow),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey[600],
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
