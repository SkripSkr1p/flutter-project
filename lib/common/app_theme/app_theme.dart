import 'package:flutter/material.dart';
import 'package:repository_template/common/colors/app_colors.dart';
import 'package:repository_template/common/typography/app_typography.dart';

abstract class AppTheme{
  static final base = ThemeData(
    textTheme: const TextTheme(
      bodyMedium: AppTypography.regular14,
      titleMedium: AppTypography.bold16,
      headlineMedium: AppTypography.bold16,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.black,
  );
}