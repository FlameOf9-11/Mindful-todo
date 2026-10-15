import 'package:flutter/material.dart';

class AppColors {
  // --- Backgrounds ---
  /// The very dark background behind the main cards
  static const Color scaffoldBackground = Color(0xFF1E1F22); 
  /// Pure white for the main container cards
  static const Color cardBackground = Color(0xFFF7FAF5);
  /// The soft grayish-green used for text fields and filter bars
  static const Color inputBackground = Color(0xFFFFFFFF); 

  // --- Accents & Borders ---
  /// The dark green used for primary buttons like "Create Account"
  static const Color primaryGreen = Color(0xFF345444); 
  /// The bright purple used for the border around the sign-up card
  static const Color cardBorderPurple = Color(0xFF6E56CF); 
  /// The soft green used for the small indicator dots
  static const Color indicatorDot = Color(0xFF7DA48D); 
  /// The light gray used for borders and dividers
  static const Color divider = Color(0xFFECEFEF); 

  // --- Typography ---
  /// Almost black for main titles and important text
  static const Color textPrimary = Color(0xFF1B1D1C); 
  /// Dark grayish-green for subtitles, labels, and regular text
  static const Color textSecondary = Color(0xFF6B7B72); 
  /// Lighter gray for placeholder text inside input fields
  static const Color textHint = Color.fromARGB(191, 139, 152, 144); 
  /// The color for clickable links (Terms of Service, Log In)
  static const Color textLink = Color(0xFF5A7868); 
}