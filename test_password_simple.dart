// Simple test for password validation
import 'package:flutter/rendering.dart';

void main() {
  final password = 'F1380yui!';

  debugPrint('Testing password: $password');
  debugPrint('');

  // Check uppercase
  final hasUpper = password.contains(RegExp(r'[A-Z]'));
  debugPrint('Has uppercase (A-Z): $hasUpper');

  // Check lowercase
  final hasLower = password.contains(RegExp(r'[a-z]'));
  debugPrint('Has lowercase (a-z): $hasLower');

  // Check digit
  final hasDigit = password.contains(RegExp(r'[0-9]'));
  debugPrint('Has digit (0-9): $hasDigit');

  // Check special char
  final specialChars = ['@', '#', '\$', '%', '&', '*', '!', '_', '-', '.'];
  final hasSpecial = specialChars.any((char) => password.contains(char));
  debugPrint('Has special char: $hasSpecial');

  debugPrint('');
  debugPrint('Characters in password:');
  for (var i = 0; i < password.length; i++) {
    final char = password[i];
    debugPrint('  [$i] "$char" - code: ${char.codeUnitAt(0)}');
  }
}
