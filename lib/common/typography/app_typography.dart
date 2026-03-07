import 'package:flutter/material.dart';
import 'package:repository_template/common/colors/app_colors.dart';



abstract class AppTypography {
  static const _fontName = 'SF Pro Display';

  static const regular14 = TextStyle(
    fontFamily: _fontName,
    fontSize: 14,
    color: AppColors.white,
  );

  static const bold16 = TextStyle(
    fontFamily: _fontName,
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w700
  );
}