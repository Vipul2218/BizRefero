import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF8B5CF6);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondaryLight = Color(0xFF34D399);
  
  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color accentDark = Color(0xFFD97706);
  static const Color accentLight = Color(0xFFFBBF24);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF047857);
  
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);
  
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);
  
  // Neutral Colors (Light Theme)
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);
  static const Color neutral950 = Color(0xFF0A0A0A);
  
  // Dark Theme Specific Colors
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceVariant = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFE0E0E0);
  static const Color darkOnSurfaceVariant = Color(0xFFB0B0B0);
  
  // Business Categories Colors
  static const Color restaurants = Color(0xFFFF6B6B);
  static const Color healthcare = Color(0xFF4ECDC4);
  static const Color shopping = Color(0xFF45B7D1);
  static const Color services = Color(0xFF96CEB4);
  static const Color entertainment = Color(0xFFFECA57);
  static const Color automotive = Color(0xFF6C5CE7);
  static const Color beauty = Color(0xFFFD79A8);
  static const Color homeGarden = Color(0xFF00B894);
  static const Color education = Color(0xFF0984E3);
  static const Color travel = Color(0xFFE17055);
  
  // Rating Colors
  static const Color rating1 = Color(0xFFEF4444); // Red
  static const Color rating2 = Color(0xFFF97316); // Orange
  static const Color rating3 = Color(0xFFFBBF24); // Yellow
  static const Color rating4 = Color(0xFF84CC16); // Lime
  static const Color rating5 = Color(0xFF10B981); // Green
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Overlay Colors
  static const Color overlayLight = Color(0x0D000000);
  static const Color overlayMedium = Color(0x1A000000);
  static const Color overlayDark = Color(0x33000000);
  
  // Disabled Colors
  static const Color disabledLight = Color(0xFFE5E5E5);
  static const Color disabledDark = Color(0xFF404040);
  static const Color disabledText = Color(0xFFA3A3A3);
  
  // Helper methods for dynamic colors
  static Color getRatingColor(double rating) {
    if (rating >= 4.5) return rating5;
    if (rating >= 3.5) return rating4;
    if (rating >= 2.5) return rating3;
    if (rating >= 1.5) return rating2;
    return rating1;
  }
  
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'restaurants & food':
      case 'restaurants':
      case 'food':
        return restaurants;
      case 'healthcare':
      case 'medical':
        return healthcare;
      case 'shopping':
      case 'retail':
        return shopping;
      case 'services':
        return services;
      case 'entertainment':
        return entertainment;
      case 'automotive':
      case 'car':
        return automotive;
      case 'beauty & spa':
      case 'beauty':
      case 'spa':
        return beauty;
      case 'home & garden':
      case 'home':
      case 'garden':
        return homeGarden;
      case 'education':
      case 'school':
        return education;
      case 'travel & hotels':
      case 'travel':
      case 'hotels':
        return travel;
      default:
        return primary;
    }
  }
}