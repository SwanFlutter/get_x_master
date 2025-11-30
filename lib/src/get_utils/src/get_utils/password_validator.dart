/// A highly configurable password validator for GetX.
///
/// This class provides flexible password validation with customizable rules
/// for minimum length, uppercase letters, lowercase letters, digits,
/// and special characters.
///
/// ## Basic Usage:
/// ```dart
/// // Create a validator with default settings (8 chars, all rules enabled)
/// final validator = PasswordValidator();
/// bool isValid = validator.validate('MyPass123!');
///
/// // Or use the static method
/// bool isValid = PasswordValidator.isValidPassword('MyPass123!');
/// ```
///
/// ## Custom Configuration:
/// ```dart
/// // Only require minimum length and digits
/// final validator = PasswordValidator(
///   minLength: 6,
///   requireUppercase: false,
///   requireLowercase: false,
///   requireDigit: true,
///   requireSpecialChar: false,
/// );
/// ```
///
/// ## With Custom Special Characters:
/// ```dart
/// final validator = PasswordValidator(
///   specialChars: '@#\$%', // Only allow these special characters
/// );
/// ```
///
/// ## Get Validation Errors:
/// ```dart
/// final validator = PasswordValidator();
/// final errors = validator.getErrors('weak');
/// // Returns list of error messages for failed rules
/// ```
class PasswordValidator {
  /// Minimum required password length.
  /// Default: 8
  final int minLength;

  /// Maximum allowed password length.
  /// Default: null (no maximum)
  final int? maxLength;

  /// Whether the password must contain at least one uppercase letter (A-Z).
  /// Default: true
  final bool requireUppercase;

  /// Whether the password must contain at least one lowercase letter (a-z).
  /// Default: true
  final bool requireLowercase;

  /// Whether the password must contain at least one digit (0-9).
  /// Default: true
  final bool requireDigit;

  /// Whether the password must contain at least one special character.
  /// Default: true
  final bool requireSpecialChar;

  /// Custom set of special characters to check for.
  /// Default: '!@#\$&*~%^()-_=+[]{}|;:,.<>?'
  final String specialChars;

  /// Creates a new [PasswordValidator] with the specified configuration.
  ///
  /// All parameters are optional and have sensible defaults:
  /// - [minLength]: 8
  /// - [maxLength]: null (no limit)
  /// - [requireUppercase]: true
  /// - [requireLowercase]: true
  /// - [requireDigit]: true
  /// - [requireSpecialChar]: true
  /// - [specialChars]: '!@#\$&*~%^()-_=+[]{}|;:,.<>?'
  const PasswordValidator({
    this.minLength = 8,
    this.maxLength,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireDigit = true,
    this.requireSpecialChar = true,
    this.specialChars = r'!@#$&*~%^()-_=+[]{}|;:,.<>?',
  });

  /// Validates the given [password] against all configured rules.
  ///
  /// Returns `true` if the password passes all enabled validation rules,
  /// `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final validator = PasswordValidator(minLength: 6);
  /// validator.validate('Test123!'); // true
  /// validator.validate('weak'); // false
  /// ```
  bool validate(String password) {
    if (password.length < minLength) return false;
    if (maxLength != null && password.length > maxLength!) return false;
    if (requireUppercase && !_hasUppercase(password)) return false;
    if (requireLowercase && !_hasLowercase(password)) return false;
    if (requireDigit && !_hasDigit(password)) return false;
    if (requireSpecialChar && !_hasSpecialChar(password)) return false;
    return true;
  }

  /// Returns a list of error messages for all failed validation rules.
  ///
  /// Useful for displaying specific feedback to users about what's wrong
  /// with their password.
  ///
  /// Example:
  /// ```dart
  /// final validator = PasswordValidator();
  /// final errors = validator.getErrors('weak');
  /// // ['Password must be at least 8 characters',
  /// //  'Password must contain at least one uppercase letter',
  /// //  'Password must contain at least one digit',
  /// //  'Password must contain at least one special character']
  /// ```
  List<String> getErrors(String password) {
    final errors = <String>[];

    if (password.length < minLength) {
      errors.add('Password must be at least $minLength characters');
    }
    if (maxLength != null && password.length > maxLength!) {
      errors.add('Password must be at most $maxLength characters');
    }
    if (requireUppercase && !_hasUppercase(password)) {
      errors.add('Password must contain at least one uppercase letter');
    }
    if (requireLowercase && !_hasLowercase(password)) {
      errors.add('Password must contain at least one lowercase letter');
    }
    if (requireDigit && !_hasDigit(password)) {
      errors.add('Password must contain at least one digit');
    }
    if (requireSpecialChar && !_hasSpecialChar(password)) {
      errors.add('Password must contain at least one special character');
    }

    return errors;
  }

  /// Returns a list of Persian (Farsi) error messages for all failed validation rules.
  ///
  /// Example:
  /// ```dart
  /// final validator = PasswordValidator();
  /// final errors = validator.getErrorsPersian('weak');
  /// // ['رمز عبور باید حداقل ۸ کاراکتر باشد',
  /// //  'رمز عبور باید حداقل یک حرف بزرگ داشته باشد', ...]
  /// ```
  List<String> getErrorsPersian(String password) {
    final errors = <String>[];

    if (password.length < minLength) {
      errors.add('رمز عبور باید حداقل $minLength کاراکتر باشد');
    }
    if (maxLength != null && password.length > maxLength!) {
      errors.add('رمز عبور باید حداکثر $maxLength کاراکتر باشد');
    }
    if (requireUppercase && !_hasUppercase(password)) {
      errors.add('رمز عبور باید حداقل یک حرف بزرگ داشته باشد');
    }
    if (requireLowercase && !_hasLowercase(password)) {
      errors.add('رمز عبور باید حداقل یک حرف کوچک داشته باشد');
    }
    if (requireDigit && !_hasDigit(password)) {
      errors.add('رمز عبور باید حداقل یک عدد داشته باشد');
    }
    if (requireSpecialChar && !_hasSpecialChar(password)) {
      errors.add('رمز عبور باید حداقل یک کاراکتر خاص داشته باشد');
    }

    return errors;
  }

  /// Returns the first error message, or null if password is valid.
  ///
  /// Useful for form validation where you only want to show one error at a time.
  ///
  /// Example:
  /// ```dart
  /// final validator = PasswordValidator();
  /// final error = validator.getFirstError('weak');
  /// // 'Password must be at least 8 characters'
  /// ```
  String? getFirstError(String password) {
    final errors = getErrors(password);
    return errors.isEmpty ? null : errors.first;
  }

  /// Returns the first Persian error message, or null if password is valid.
  String? getFirstErrorPersian(String password) {
    final errors = getErrorsPersian(password);
    return errors.isEmpty ? null : errors.first;
  }

  /// Calculates password strength as a value between 0.0 and 1.0.
  ///
  /// The strength is calculated based on:
  /// - Length (longer is stronger)
  /// - Presence of uppercase letters
  /// - Presence of lowercase letters
  /// - Presence of digits
  /// - Presence of special characters
  ///
  /// Example:
  /// ```dart
  /// final validator = PasswordValidator();
  /// validator.getStrength('weak'); // ~0.2
  /// validator.getStrength('StrongPass123!'); // ~0.9
  /// ```
  double getStrength(String password) {
    if (password.isEmpty) return 0.0;

    double strength = 0.0;
    final maxPoints = 5.0;

    // Length contribution (up to 1 point)
    final lengthScore = (password.length / 12).clamp(0.0, 1.0);
    strength += lengthScore;

    // Character type contributions (1 point each)
    if (_hasUppercase(password)) strength += 1.0;
    if (_hasLowercase(password)) strength += 1.0;
    if (_hasDigit(password)) strength += 1.0;
    if (_hasSpecialChar(password)) strength += 1.0;

    return (strength / maxPoints).clamp(0.0, 1.0);
  }

  /// Returns a strength label based on the password strength score.
  ///
  /// - 0.0 - 0.2: "Very Weak"
  /// - 0.2 - 0.4: "Weak"
  /// - 0.4 - 0.6: "Fair"
  /// - 0.6 - 0.8: "Strong"
  /// - 0.8 - 1.0: "Very Strong"
  String getStrengthLabel(String password) {
    final strength = getStrength(password);
    if (strength < 0.2) return 'Very Weak';
    if (strength < 0.4) return 'Weak';
    if (strength < 0.6) return 'Fair';
    if (strength < 0.8) return 'Strong';
    return 'Very Strong';
  }

  /// Returns a Persian strength label based on the password strength score.
  String getStrengthLabelPersian(String password) {
    final strength = getStrength(password);
    if (strength < 0.2) return 'خیلی ضعیف';
    if (strength < 0.4) return 'ضعیف';
    if (strength < 0.6) return 'متوسط';
    if (strength < 0.8) return 'قوی';
    return 'خیلی قوی';
  }

  // Private helper methods
  bool _hasUppercase(String s) => s.contains(RegExp(r'[A-Z]'));
  bool _hasLowercase(String s) => s.contains(RegExp(r'[a-z]'));
  bool _hasDigit(String s) => s.contains(RegExp(r'[0-9]'));
  bool _hasSpecialChar(String s) {
    final escapedChars = RegExp.escape(specialChars);
    return s.contains(RegExp('[$escapedChars]'));
  }

  // ============== Static Methods ==============

  /// Static method to quickly validate a password with default settings.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = PasswordValidator.isValidPassword('MyPass123!');
  /// ```
  static bool isValidPassword(
    String password, {
    int minLength = 8,
    int? maxLength,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
    String specialChars = r'!@#$&*~%^()-_=+[]{}|;:,.<>?',
  }) {
    return PasswordValidator(
      minLength: minLength,
      maxLength: maxLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireDigit: requireDigit,
      requireSpecialChar: requireSpecialChar,
      specialChars: specialChars,
    ).validate(password);
  }

  /// Static method to get validation errors with default settings.
  ///
  /// Example:
  /// ```dart
  /// List<String> errors = PasswordValidator.getPasswordErrors('weak');
  /// ```
  static List<String> getPasswordErrors(
    String password, {
    int minLength = 8,
    int? maxLength,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
    String specialChars = r'!@#$&*~%^()-_=+[]{}|;:,.<>?',
  }) {
    return PasswordValidator(
      minLength: minLength,
      maxLength: maxLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireDigit: requireDigit,
      requireSpecialChar: requireSpecialChar,
      specialChars: specialChars,
    ).getErrors(password);
  }
}
