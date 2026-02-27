/// A validator for Identity documents like National Code and Passport.
///
/// Example:
/// ```dart
/// // Validate Iranian National Code
/// final validator = IdentityValidator(validateIranianNationalCode: true);
/// bool isValid = validator.validate('0012345678');
///
/// // Validate Passport (General)
/// final passportValidator = IdentityValidator(
///   validateIranianNationalCode: false,
///   validatePassport: true,
/// );
///
/// // Validate Specific Country Passport
/// final germanValidator = IdentityValidator(
///   validatePassport: true,
///   countryCode: 'DE',
/// );
/// ```
class IdentityValidator {
  /// Whether to validate as Iranian National Code.
  final bool validateIranianNationalCode;

  /// Whether to validate as Passport Number.
  final bool validatePassport;

  /// Country code (ISO 3166-1 alpha-2) for country-specific passport validation.
  /// If null or country not found, uses general ICAO 9303 standard validation.
  final String? countryCode;

  /// Creates a new [IdentityValidator].
  ///
  /// If both [validateIranianNationalCode] and [validatePassport] are true,
  /// validation passes if the input matches EITHER format.
  ///
  /// [countryCode] is optional and follows ISO 3166-1 alpha-2 (e.g. 'IR', 'US', 'DE').
  /// If country code is not in the database, falls back to ICAO standard.
  const IdentityValidator({
    this.validateIranianNationalCode = true,
    this.validatePassport = false,
    this.countryCode,
  });

  /// Validates the input string against enabled rules.
  bool validate(String input) {
    if (input.isEmpty) return false;

    bool isValid = false;

    if (validateIranianNationalCode) {
      if (isValidIranianNationalCode(input)) {
        isValid = true;
      }
    }

    if (!isValid && validatePassport) {
      // Always validate passport - if country not found, use ICAO standard
      if (countryCode != null &&
          PassportCountryData.countries
              .containsKey(countryCode!.toUpperCase())) {
        if (isValidPassportForCountry(input, countryCode!)) {
          isValid = true;
        }
      } else {
        // Country code is null or not found - use ICAO standard validation
        if (isValidPassport(input)) {
          isValid = true;
        }
      }
    }

    return isValid;
  }

  /// Returns a list of error messages in English.
  List<String> getErrors(String input) {
    final errors = <String>[];
    if (input.isEmpty) {
      errors.add('Input cannot be empty');
      return errors;
    }

    bool iranianValid = false;
    if (validateIranianNationalCode) {
      iranianValid = isValidIranianNationalCode(input);
    }

    bool passportValid = false;
    if (validatePassport) {
      // Check if country exists, otherwise use ICAO standard
      if (countryCode != null &&
          PassportCountryData.countries
              .containsKey(countryCode!.toUpperCase())) {
        passportValid = isValidPassportForCountry(input, countryCode!);
      } else {
        passportValid = isValidPassport(input);
      }
    }

    if (!iranianValid && !passportValid) {
      if (validateIranianNationalCode && !validatePassport) {
        errors.add('Invalid Iranian National Code');
      } else if (!validateIranianNationalCode && validatePassport) {
        final countryName = countryCode != null
            ? (PassportCountryData
                    .countries[countryCode!.toUpperCase()]?.name ??
                'International (ICAO 9303)')
            : 'International (ICAO 9303)';
        errors.add('Invalid $countryName Passport Number');
      } else {
        errors.add('Invalid Identity Document');
      }
    }

    return errors;
  }

  /// Returns the first error message in English, or null if valid.
  String? getFirstError(String input) {
    if (validate(input)) return null;

    if (input.isEmpty) {
      return 'Input cannot be empty';
    }

    if (validateIranianNationalCode && !validatePassport) {
      return 'Invalid Iranian National Code';
    } else if (!validateIranianNationalCode && validatePassport) {
      return 'Invalid Passport Number';
    } else {
      return 'Invalid Identity Document';
    }
  }

  /// Returns the first error message in Persian, or null if valid.
  String? getFirstErrorPersian(String input) {
    if (validate(input)) return null;

    if (input.isEmpty) {
      return 'لطفا مقدار را وارد کنید';
    }

    if (validateIranianNationalCode && !validatePassport) {
      return 'کد ملی نامعتبر است';
    } else if (!validateIranianNationalCode && validatePassport) {
      return 'شماره پاسپورت نامعتبر است';
    } else {
      return 'مدرک شناسایی نامعتبر است';
    }
  }

  /// Static helper to validate Iranian National Code.
  static bool isValidIranianNationalCode(String input) {
    if (!RegExp(r'^\d{10}$').hasMatch(input)) return false;

    // Check for all same digits (e.g. 1111111111) which are invalid
    if (RegExp(r'^(\d)\1+$').hasMatch(input)) return false;

    // Check for common invalid sequences
    if (input == '0000000000') return false;

    final check = int.parse(input.substring(9, 10));
    final sum = input
        .substring(0, 9)
        .split('')
        .asMap()
        .entries
        .map((e) => int.parse(e.value) * (10 - e.key))
        .fold(0, (a, b) => a + b);

    final remainder = sum % 11;

    if (remainder < 2) {
      return check == remainder;
    } else {
      return check == 11 - remainder;
    }
  }

  /// Static helper to validate Passport Number using ICAO 9303 general standard.
  /// Supports most international passport formats.
  static bool isValidPassport(String input) {
    final normalized = input.toUpperCase().trim();

    if (normalized.length < 6 || normalized.length > 9) return false;
    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(normalized)) return false;
    if (RegExp(r'^0+$').hasMatch(normalized)) return false;

    // Accept:
    // - 1-2 letters followed by 6-8 digits (most common)
    // - All numeric (e.g. UK old format)
    // - Alphanumeric mix (e.g. Germany, Canada)
    return RegExp(r'^[A-Z]{1,2}[0-9]{6,8}$').hasMatch(normalized) ||
        RegExp(r'^[0-9]{6,9}$').hasMatch(normalized) ||
        RegExp(r'^[A-Z0-9]{6,9}$').hasMatch(normalized);
  }

  /// Validates passport based on country-specific format.
  /// [countryCode] should be ISO 3166-1 alpha-2 (e.g. 'IR', 'US', 'DE').
  /// If country code is not found, falls back to ICAO standard.
  static bool isValidPassportForCountry(String input, String countryCode) {
    final country = PassportCountryData.countries[countryCode.toUpperCase()];
    if (country == null) {
      // Country not in database - use general ICAO validation
      return isValidPassport(input);
    }

    final normalized = input.toUpperCase().trim();
    return country.pattern.hasMatch(normalized);
  }

  /// Returns list of all supported country codes for passport validation.
  static List<String> get supportedCountryCodes =>
      PassportCountryData.countries.keys.toList()..sort();

  /// Returns country info for a given country code, or null if not supported.
  static PassportCountryInfo? getCountryInfo(String countryCode) =>
      PassportCountryData.countries[countryCode.toUpperCase()];
}

// ─────────────────────────────────────────────────────────────────────────────
// Country Passport Data
// ─────────────────────────────────────────────────────────────────────────────

/// Holds information about a country's passport format.
class PassportCountryInfo {
  final String code;
  final String name;
  final String nameFa; // Persian name
  final RegExp pattern;
  final String formatDescription;

  const PassportCountryInfo({
    required this.code,
    required this.name,
    required this.nameFa,
    required this.pattern,
    required this.formatDescription,
  });
}

/// Contains passport format data for countries worldwide.
class PassportCountryData {
  PassportCountryData._();

  static final Map<String, PassportCountryInfo> countries = {
    // ── Middle East ──────────────────────────────────────────────────────────
    'IR': PassportCountryInfo(
      code: 'IR',
      name: 'Iran',
      nameFa: 'ایران',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits (e.g. A12345678)',
    ),
    'SA': PassportCountryInfo(
      code: 'SA',
      name: 'Saudi Arabia',
      nameFa: 'عربستان سعودی',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'AE': PassportCountryInfo(
      code: 'AE',
      name: 'United Arab Emirates',
      nameFa: 'امارات',
      pattern: RegExp(r'^[A-Z][0-9]{6,7}$'),
      formatDescription: '1 letter + 6-7 digits',
    ),
    'IQ': PassportCountryInfo(
      code: 'IQ',
      name: 'Iraq',
      nameFa: 'عراق',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'TR': PassportCountryInfo(
      code: 'TR',
      name: 'Turkey',
      nameFa: 'ترکیه',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits (e.g. U12345678)',
    ),
    'AF': PassportCountryInfo(
      code: 'AF',
      name: 'Afghanistan',
      nameFa: 'افغانستان',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'PK': PassportCountryInfo(
      code: 'PK',
      name: 'Pakistan',
      nameFa: 'پاکستان',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits (e.g. AB1234567)',
    ),
    'KW': PassportCountryInfo(
      code: 'KW',
      name: 'Kuwait',
      nameFa: 'کویت',
      pattern: RegExp(r'^[0-9]{8,9}$'),
      formatDescription: '8-9 digits',
    ),
    'QA': PassportCountryInfo(
      code: 'QA',
      name: 'Qatar',
      nameFa: 'قطر',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'BH': PassportCountryInfo(
      code: 'BH',
      name: 'Bahrain',
      nameFa: 'بحرین',
      pattern: RegExp(r'^[0-9]{9}$'),
      formatDescription: '9 digits',
    ),
    'OM': PassportCountryInfo(
      code: 'OM',
      name: 'Oman',
      nameFa: 'عمان',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'JO': PassportCountryInfo(
      code: 'JO',
      name: 'Jordan',
      nameFa: 'اردن',
      pattern: RegExp(r'^[A-Z][0-9]{6,7}$'),
      formatDescription: '1 letter + 6-7 digits',
    ),
    'LB': PassportCountryInfo(
      code: 'LB',
      name: 'Lebanon',
      nameFa: 'لبنان',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'SY': PassportCountryInfo(
      code: 'SY',
      name: 'Syria',
      nameFa: 'سوریه',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),

    // ── Europe ───────────────────────────────────────────────────────────────
    'GB': PassportCountryInfo(
      code: 'GB',
      name: 'United Kingdom',
      nameFa: 'انگلستان',
      pattern: RegExp(r'^[0-9]{9}$'),
      formatDescription: '9 digits',
    ),
    'DE': PassportCountryInfo(
      code: 'DE',
      name: 'Germany',
      nameFa: 'آلمان',
      pattern: RegExp(r'^[A-Z0-9]{9}$'),
      formatDescription: '9 alphanumeric characters (e.g. C01X00T47)',
    ),
    'FR': PassportCountryInfo(
      code: 'FR',
      name: 'France',
      nameFa: 'فرانسه',
      pattern: RegExp(r'^[0-9]{2}[A-Z]{2}[0-9]{5}$'),
      formatDescription: '2 digits + 2 letters + 5 digits (e.g. 12AB34567)',
    ),
    'IT': PassportCountryInfo(
      code: 'IT',
      name: 'Italy',
      nameFa: 'ایتالیا',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'ES': PassportCountryInfo(
      code: 'ES',
      name: 'Spain',
      nameFa: 'اسپانیا',
      pattern: RegExp(r'^[A-Z0-9]{9}$'),
      formatDescription: '3 letters + 6 digits or 9 alphanumeric',
    ),
    'NL': PassportCountryInfo(
      code: 'NL',
      name: 'Netherlands',
      nameFa: 'هلند',
      pattern: RegExp(r'^[A-Z]{2}[A-Z0-9]{7}$'),
      formatDescription: '2 letters + 7 alphanumeric',
    ),
    'BE': PassportCountryInfo(
      code: 'BE',
      name: 'Belgium',
      nameFa: 'بلژیک',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
    'CH': PassportCountryInfo(
      code: 'CH',
      name: 'Switzerland',
      nameFa: 'سوئیس',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'AT': PassportCountryInfo(
      code: 'AT',
      name: 'Austria',
      nameFa: 'اتریش',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'SE': PassportCountryInfo(
      code: 'SE',
      name: 'Sweden',
      nameFa: 'سوئد',
      pattern: RegExp(r'^[0-9]{8}$'),
      formatDescription: '8 digits',
    ),
    'NO': PassportCountryInfo(
      code: 'NO',
      name: 'Norway',
      nameFa: 'نروژ',
      pattern: RegExp(r'^[0-9]{8}$'),
      formatDescription: '8 digits',
    ),
    'DK': PassportCountryInfo(
      code: 'DK',
      name: 'Denmark',
      nameFa: 'دانمارک',
      pattern: RegExp(r'^[0-9]{8}$'),
      formatDescription: '8 digits',
    ),
    'FI': PassportCountryInfo(
      code: 'FI',
      name: 'Finland',
      nameFa: 'فنلاند',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'PL': PassportCountryInfo(
      code: 'PL',
      name: 'Poland',
      nameFa: 'لهستان',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'GR': PassportCountryInfo(
      code: 'GR',
      name: 'Greece',
      nameFa: 'یونان',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'PT': PassportCountryInfo(
      code: 'PT',
      name: 'Portugal',
      nameFa: 'پرتغال',
      pattern: RegExp(r'^[A-Z][0-9]{6}$'),
      formatDescription: '1 letter + 6 digits',
    ),
    'RU': PassportCountryInfo(
      code: 'RU',
      name: 'Russia',
      nameFa: 'روسیه',
      pattern: RegExp(r'^[0-9]{9}$'),
      formatDescription: '9 digits',
    ),
    'UA': PassportCountryInfo(
      code: 'UA',
      name: 'Ukraine',
      nameFa: 'اوکراین',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
    'RO': PassportCountryInfo(
      code: 'RO',
      name: 'Romania',
      nameFa: 'رومانی',
      pattern: RegExp(r'^[0-9]{8}$'),
      formatDescription: '8 digits',
    ),
    'CZ': PassportCountryInfo(
      code: 'CZ',
      name: 'Czech Republic',
      nameFa: 'جمهوری چک',
      pattern: RegExp(r'^[0-9]{8}$'),
      formatDescription: '8 digits',
    ),
    'HU': PassportCountryInfo(
      code: 'HU',
      name: 'Hungary',
      nameFa: 'مجارستان',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),

    // ── Americas ─────────────────────────────────────────────────────────────
    'US': PassportCountryInfo(
      code: 'US',
      name: 'United States',
      nameFa: 'آمریکا',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits (e.g. A12345678)',
    ),
    'CA': PassportCountryInfo(
      code: 'CA',
      name: 'Canada',
      nameFa: 'کانادا',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
    'MX': PassportCountryInfo(
      code: 'MX',
      name: 'Mexico',
      nameFa: 'مکزیک',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'BR': PassportCountryInfo(
      code: 'BR',
      name: 'Brazil',
      nameFa: 'برزیل',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
    'AR': PassportCountryInfo(
      code: 'AR',
      name: 'Argentina',
      nameFa: 'آرژانتین',
      pattern: RegExp(r'^[A-Z]{3}[0-9]{6}$'),
      formatDescription: '3 letters + 6 digits',
    ),
    'CL': PassportCountryInfo(
      code: 'CL',
      name: 'Chile',
      nameFa: 'شیلی',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'CO': PassportCountryInfo(
      code: 'CO',
      name: 'Colombia',
      nameFa: 'کلمبیا',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),

    // ── Asia ─────────────────────────────────────────────────────────────────
    'CN': PassportCountryInfo(
      code: 'CN',
      name: 'China',
      nameFa: 'چین',
      pattern: RegExp(r'^[EG][0-9]{8}$'),
      formatDescription: 'E or G + 8 digits',
    ),
    'JP': PassportCountryInfo(
      code: 'JP',
      name: 'Japan',
      nameFa: 'ژاپن',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'KR': PassportCountryInfo(
      code: 'KR',
      name: 'South Korea',
      nameFa: 'کره جنوبی',
      pattern: RegExp(r'^[A-Z]{1,2}[0-9]{8}$'),
      formatDescription: '1-2 letters + 8 digits',
    ),
    'IN': PassportCountryInfo(
      code: 'IN',
      name: 'India',
      nameFa: 'هند',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits (e.g. A1234567)',
    ),
    'ID': PassportCountryInfo(
      code: 'ID',
      name: 'Indonesia',
      nameFa: 'اندونزی',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'MY': PassportCountryInfo(
      code: 'MY',
      name: 'Malaysia',
      nameFa: 'مالزی',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'TH': PassportCountryInfo(
      code: 'TH',
      name: 'Thailand',
      nameFa: 'تایلند',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'SG': PassportCountryInfo(
      code: 'SG',
      name: 'Singapore',
      nameFa: 'سنگاپور',
      pattern: RegExp(r'^[A-Z][0-9]{7}[A-Z]$'),
      formatDescription: '1 letter + 7 digits + 1 letter',
    ),
    'PH': PassportCountryInfo(
      code: 'PH',
      name: 'Philippines',
      nameFa: 'فیلیپین',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'VN': PassportCountryInfo(
      code: 'VN',
      name: 'Vietnam',
      nameFa: 'ویتنام',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'BD': PassportCountryInfo(
      code: 'BD',
      name: 'Bangladesh',
      nameFa: 'بنگلادش',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{7}$'),
      formatDescription: '2 letters + 7 digits',
    ),
    'LK': PassportCountryInfo(
      code: 'LK',
      name: 'Sri Lanka',
      nameFa: 'سریلانکا',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'NP': PassportCountryInfo(
      code: 'NP',
      name: 'Nepal',
      nameFa: 'نپال',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),

    // ── Africa ───────────────────────────────────────────────────────────────
    'EG': PassportCountryInfo(
      code: 'EG',
      name: 'Egypt',
      nameFa: 'مصر',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'ZA': PassportCountryInfo(
      code: 'ZA',
      name: 'South Africa',
      nameFa: 'آفریقای جنوبی',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'NG': PassportCountryInfo(
      code: 'NG',
      name: 'Nigeria',
      nameFa: 'نیجریه',
      pattern: RegExp(r'^[A-Z][0-9]{8}$'),
      formatDescription: '1 letter + 8 digits',
    ),
    'MA': PassportCountryInfo(
      code: 'MA',
      name: 'Morocco',
      nameFa: 'مراکش',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
    'DZ': PassportCountryInfo(
      code: 'DZ',
      name: 'Algeria',
      nameFa: 'الجزایر',
      pattern: RegExp(r'^[0-9]{9}$'),
      formatDescription: '9 digits',
    ),
    'KE': PassportCountryInfo(
      code: 'KE',
      name: 'Kenya',
      nameFa: 'کنیا',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),
    'GH': PassportCountryInfo(
      code: 'GH',
      name: 'Ghana',
      nameFa: 'غنا',
      pattern: RegExp(r'^G[0-9]{7}$'),
      formatDescription: 'G + 7 digits',
    ),
    'ET': PassportCountryInfo(
      code: 'ET',
      name: 'Ethiopia',
      nameFa: 'اتیوپی',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits',
    ),

    // ── Oceania ──────────────────────────────────────────────────────────────
    'AU': PassportCountryInfo(
      code: 'AU',
      name: 'Australia',
      nameFa: 'استرالیا',
      pattern: RegExp(r'^[A-Z][0-9]{7}$'),
      formatDescription: '1 letter + 7 digits (e.g. N1234567)',
    ),
    'NZ': PassportCountryInfo(
      code: 'NZ',
      name: 'New Zealand',
      nameFa: 'نیوزیلند',
      pattern: RegExp(r'^[A-Z]{2}[0-9]{6}$'),
      formatDescription: '2 letters + 6 digits',
    ),
  };
}
