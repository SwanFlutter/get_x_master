import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class TestIdentityValidator extends StatefulWidget {
  const TestIdentityValidator({super.key});

  @override
  State<TestIdentityValidator> createState() => _TestIdentityValidatorState();
}

class _TestIdentityValidatorState extends State<TestIdentityValidator> {
  // Configuration options
  bool _checkNationalCode = true;
  bool _checkPassport = false;

  late IdentityValidator validator;

  String _currentInput = '';
  String? _firstError;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _updateValidator();
  }

  void _updateValidator() {
    validator = IdentityValidator(
      validateIranianNationalCode: _checkNationalCode,
      validatePassport: _checkPassport,
    );
    // Re-validate current input
    if (_currentInput.isNotEmpty) {
      _validate(_currentInput);
    }
  }

  void _validate(String value) {
    setState(() {
      _currentInput = value;
      _isValid = validator.validate(value);
      _firstError = validator.getFirstErrorPersian(value);
    });
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
        title: const Text("Identity Validator Test"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configuration Section
            const Text(
              'تنظیمات اعتبارسنجی:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CheckboxListTile(
              title: const Text('بررسی کد ملی ایران'),
              value: _checkNationalCode,
              onChanged: (val) {
                setState(() {
                  _checkNationalCode = val ?? true;
                  _updateValidator();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('بررسی شماره پاسپورت'),
              value: _checkPassport,
              onChanged: (val) {
                setState(() {
                  _checkPassport = val ?? false;
                  _updateValidator();
                });
              },
            ),
            const Divider(),
            const SizedBox(height: 10),

            TextField(
              decoration: const InputDecoration(
                hintText: "کد ملی یا شماره پاسپورت را وارد کنید",
                border: OutlineInputBorder(),
                labelText: "Identity Document",
              ),
              onChanged: _validate,
            ),
            const SizedBox(height: 20),

            if (_currentInput.isNotEmpty) ...[
              const Text(
                'نتیجه بررسی:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              // Status Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isValid
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isValid ? Colors.green : Colors.red,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isValid ? Icons.check_circle : Icons.error,
                          color: _isValid ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isValid ? 'معتبر است' : 'نامعتبر است',
                          style: TextStyle(
                            color: _isValid ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (!_isValid && _firstError != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _firstError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("Technical Details:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (_checkNationalCode)
                _buildValidationItem(
                  "Is Valid Iranian National Code: ${IdentityValidator.isValidIranianNationalCode(_currentInput)}",
                  IdentityValidator.isValidIranianNationalCode(_currentInput),
                ),
              if (_checkPassport)
                _buildValidationItem(
                  "Is Valid Passport: ${IdentityValidator.isValidPassport(_currentInput)}",
                  IdentityValidator.isValidPassport(_currentInput),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
