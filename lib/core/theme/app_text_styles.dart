import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static  TextStyle headline0 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static  TextStyle headline1 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static  TextStyle headline2 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static TextStyle headline3 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static TextStyle large = TextStyle(fontSize: 20, color: AppColors.textPrimary);
  static  TextStyle body = TextStyle(fontSize: 16, color: AppColors.textPrimary);
  static  TextStyle caption = TextStyle(fontSize: 14, color: AppColors.textSecondary);

  static const TextStyle headline0Dark = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle headline1Dark = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white);
  static const TextStyle headline2Dark = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white);
  static const TextStyle headline3Dark = TextStyle(fontSize: 16, color: Colors.white);
  static const TextStyle bodyDark = TextStyle(fontSize: 14, color: Colors.white70);
  static const TextStyle captionDark = TextStyle(fontSize: 12, color: Colors.white60);


}