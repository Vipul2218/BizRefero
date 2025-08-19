import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display Styles
  static const displayLarge = TextStyle(
    fontSize: 57,
    height: 1.12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static const displayMedium = TextStyle(
    fontSize: 45,
    height: 1.16,
    fontWeight: FontWeight.w400,
  );

  static const displaySmall = TextStyle(
    fontSize: 36,
    height: 1.22,
    fontWeight: FontWeight.w400,
  );

  // Headline Styles
  static const headlineLarge = TextStyle(
    fontSize: 32,
    height: 1.25,
    fontWeight: FontWeight.w400,
  );

  static const headlineMedium = TextStyle(
    fontSize: 28,
    height: 1.29,
    fontWeight: FontWeight.w400,
  );

  static const headlineSmall = TextStyle(
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w400,
  );

  // Title Styles
  static const titleLarge = TextStyle(
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w400,
  );

  static const titleMedium = TextStyle(
    fontSize: 16,
    height: 1.50,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.10,
  );

  // Label Styles
  static const labelLarge = TextStyle(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.10,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.50,
  );

  static const labelSmall = TextStyle(
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.50,
  );

  // Body Styles
  static const bodyLarge = TextStyle(
    fontSize: 16,
    height: 1.50,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.40,
  );

  // Custom App-specific Styles
  static const appTitle = TextStyle(
    fontSize: 28,
    height: 1.29,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const sectionTitle = TextStyle(
    fontSize: 20,
    height: 1.40,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static const cardTitle = TextStyle(
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w600,
  );

  static const cardSubtitle = TextStyle(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  static const caption = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.40,
  );

  static const overline = TextStyle(
    fontSize: 10,
    height: 1.60,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.50,
  );

  // Button Styles
  static const buttonLarge = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static const buttonMedium = TextStyle(
    fontSize: 14,
    height: 1.29,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );

  static const buttonSmall = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.50,
  );

  // Price Styles
  static const priceRange = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
  );

  static const priceLarge = TextStyle(
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w700,
  );

  // Rating Styles
  static const ratingLarge = TextStyle(
    fontSize: 18,
    height: 1.22,
    fontWeight: FontWeight.w700,
  );

  static const ratingMedium = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
  );

  static const ratingSmall = TextStyle(
    fontSize: 14,
    height: 1.29,
    fontWeight: FontWeight.w600,
  );

  // Error Styles
  static const errorText = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.40,
  );

  // Success Styles
  static const successText = TextStyle(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  // Light Theme Text Theme
  static final lightTextTheme = TextTheme(
    displayLarge: displayLarge.copyWith(color: AppColors.neutral900),
    displayMedium: displayMedium.copyWith(color: AppColors.neutral900),
    displaySmall: displaySmall.copyWith(color: AppColors.neutral900),
    headlineLarge: headlineLarge.copyWith(color: AppColors.neutral900),
    headlineMedium: headlineMedium.copyWith(color: AppColors.neutral900),
    headlineSmall: headlineSmall.copyWith(color: AppColors.neutral900),
    titleLarge: titleLarge.copyWith(color: AppColors.neutral900),
    titleMedium: titleMedium.copyWith(color: AppColors.neutral900),
    titleSmall: titleSmall.copyWith(color: AppColors.neutral900),
    labelLarge: labelLarge.copyWith(color: AppColors.neutral700),
    labelMedium: labelMedium.copyWith(color: AppColors.neutral600),
    labelSmall: labelSmall.copyWith(color: AppColors.neutral600),
    bodyLarge: bodyLarge.copyWith(color: AppColors.neutral800),
    bodyMedium: bodyMedium.copyWith(color: AppColors.neutral700),
    bodySmall: bodySmall.copyWith(color: AppColors.neutral600),
  );

  // Dark Theme Text Theme
  static final darkTextTheme = TextTheme(
    displayLarge: displayLarge.copyWith(color: AppColors.neutral50),
    displayMedium: displayMedium.copyWith(color: AppColors.neutral50),
    displaySmall: displaySmall.copyWith(color: AppColors.neutral50),
    headlineLarge: headlineLarge.copyWith(color: AppColors.neutral50),
    headlineMedium: headlineMedium.copyWith(color: AppColors.neutral50),
    headlineSmall: headlineSmall.copyWith(color: AppColors.neutral50),
    titleLarge: titleLarge.copyWith(color: AppColors.neutral50),
    titleMedium: titleMedium.copyWith(color: AppColors.neutral50),
    titleSmall: titleSmall.copyWith(color: AppColors.neutral50),
    labelLarge: labelLarge.copyWith(color: AppColors.neutral300),
    labelMedium: labelMedium.copyWith(color: AppColors.neutral400),
    labelSmall: labelSmall.copyWith(color: AppColors.neutral400),
    bodyLarge: bodyLarge.copyWith(color: AppColors.neutral200),
    bodyMedium: bodyMedium.copyWith(color: AppColors.neutral300),
    bodySmall: bodySmall.copyWith(color: AppColors.neutral400),
  );

  // Helper methods for specific use cases
  static TextStyle getRatingTextStyle(double rating) {
    return ratingMedium.copyWith(
      color: AppColors.getRatingColor(rating),
    );
  }

  static TextStyle getCategoryTextStyle(String category) {
    return labelMedium.copyWith(
      color: AppColors.getCategoryColor(category),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle getErrorTextStyle({bool isDark = false}) {
    return errorText.copyWith(
      color: isDark ? AppColors.errorLight : AppColors.error,
    );
  }

  static TextStyle getSuccessTextStyle({bool isDark = false}) {
    return successText.copyWith(
      color: isDark ? AppColors.successLight : AppColors.success,
    );
  }
}