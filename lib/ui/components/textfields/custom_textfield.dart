import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
   final IconData? prefixIcon;
   final VoidCallback? onEditingComplete;
   final IconData? suffixIcon;
   final ValueChanged<String>? onChanged;
   final VoidCallback? onSuffixTap;


  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.onEditingComplete,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon)!=null
            ?IconButton(
          icon: Icon(suffixIcon),
          onPressed: onSuffixTap,
        )
        :null,
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 0.5,
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
