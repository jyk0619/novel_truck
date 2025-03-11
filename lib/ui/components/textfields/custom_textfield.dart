import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
   final IconData? prefixIcon;
   final VoidCallback? onEditingComplete;


  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textPrimary),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 0,
            style: BorderStyle.none,
            ),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        ),
    );
  }
}
