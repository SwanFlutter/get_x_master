import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class TestValidatePasssword extends StatefulWidget {
  const TestValidatePasssword({super.key});

  @override
  State<TestValidatePasssword> createState() => _TestValidatePassswordState();
}

class _TestValidatePassswordState extends State<TestValidatePasssword> {
  final validator = PasswordValidator(
    minLength: 8,
    maxLength: 20,
    requireDigit: true,
    requireUppercase: true,
    requireLowercase: true,
    requireSpecialCharacter: true,
    specialCharacters: ['@', '#', '\$', '%', '&', '*', '!', '_', '-', '.'],
  );

  String _currentPassword = '';
  double _passwordStrength = 0.0;
  String _strengthLabel = '';

  // Individual validation states
  bool _hasMinLength = false;
  bool _hasMaxLength = true;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;
  bool _hasSpecialChar = false;

  void validatePassword(String value) {
    _currentPassword = value;
    _passwordStrength = validator.getStrength(value);
    _strengthLabel = validator.getStrengthLabelPersian(value);

    // Check individual rules
    _hasMinLength = value.length >= validator.minLength;
    _hasMaxLength =
        validator.maxLength == null || value.length <= validator.maxLength!;
    _hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    _hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    _hasDigit = RegExp(r'[0-9]').hasMatch(value);
    _hasSpecialChar = false;
    for (final char in validator.specialCharacters) {
      if (value.contains(char)) {
        _hasSpecialChar = true;
        break;
      }
    }

    // Debug print
    debugPrint('Password: $value');
    debugPrint(
        'Has Upper: $_hasUppercase, Has Lower: $_hasLowercase, Has Digit: $_hasDigit, Has Special: $_hasSpecialChar');
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            color: isValid ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isValid ? Colors.green : Colors.red,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validate Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  validatePassword(value);
                });
              },
            ),
            const SizedBox(height: 20),

            // Strength indicator
            LinearProgressIndicator(
              value: _passwordStrength,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _passwordStrength < 0.4
                    ? Colors.red
                    : _passwordStrength < 0.7
                        ? Colors.orange
                        : Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'قدرت رمز عبور: $_strengthLabel',
              style: TextStyle(
                color: _passwordStrength < 0.4
                    ? Colors.red
                    : _passwordStrength < 0.7
                        ? Colors.orange
                        : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),

            const Text(
              'شرایط رمز عبور:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            // Individual validation items
            _buildValidationItem(
              'حداقل ${validator.minLength} کاراکتر (${_currentPassword.length}/${validator.minLength})',
              _hasMinLength,
            ),
            if (validator.maxLength != null)
              _buildValidationItem(
                'حداکثر ${validator.maxLength} کاراکتر (${_currentPassword.length}/${validator.maxLength})',
                _hasMaxLength,
              ),
            _buildValidationItem(
              'حداقل یک حرف بزرگ (A-Z)',
              _hasUppercase,
            ),
            _buildValidationItem(
              'حداقل یک حرف کوچک (a-z)',
              _hasLowercase,
            ),
            _buildValidationItem(
              'حداقل یک عدد (0-9)',
              _hasDigit,
            ),
            _buildValidationItem(
              'حداقل یک کاراکتر خاص (${validator.specialCharacters.join(" ")})',
              _hasSpecialChar,
            ),

            const SizedBox(height: 20),

            // Final status
            if (_currentPassword.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: validator.validate(_currentPassword)
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: validator.validate(_currentPassword)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      validator.validate(_currentPassword)
                          ? Icons.check_circle
                          : Icons.error,
                      color: validator.validate(_currentPassword)
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      validator.validate(_currentPassword)
                          ? 'رمز عبور معتبر است ✓'
                          : 'رمز عبور معتبر نیست',
                      style: TextStyle(
                        color: validator.validate(_currentPassword)
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
