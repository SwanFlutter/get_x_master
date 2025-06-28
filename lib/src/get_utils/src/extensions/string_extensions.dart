import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../get_x_master.dart';

extension GetStringUtils on String {
  /// Discover if the String is a valid number
  ///
  /// Example:
  /// ```dart
  /// bool isValid = "123".isNum;
  /// // Result: true
  /// ```
  bool get isNum => GetUtils.isNum(this);

  /// Discover if the String is numeric only
  ///
  /// Example:
  /// ```dart
  /// bool isNumeric = "123".isNumericOnly;
  /// // Result: true
  /// ```
  bool get isNumericOnly => GetUtils.isNumericOnly(this);

  /// Extract numeric characters from the String
  ///
  /// Example:
  /// ```dart
  /// String numeric = "abc123".numericOnly();
  /// // Result: "123"
  /// ```
  String numericOnly({bool firstWordOnly = false}) =>
      GetUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  /// Discover if the String is alphanumeric only
  ///
  /// Example:
  /// ```dart
  /// bool isAlphabet = "abc".isAlphabetOnly;
  /// // Result: true
  /// ```
  bool get isAlphabetOnly => GetUtils.isAlphabetOnly(this);

  /// Discover if the String is a boolean
  ///
  /// Example:
  /// ```dart
  /// bool isBool = "true".isBool;
  /// // Result: true
  /// ```
  bool get isBool => GetUtils.isBool(this);

  /// Discover if the String is a vector file name
  ///
  /// Example:
  /// ```dart
  /// bool isVector = "image.svg".isVectorFileName;
  /// // Result: true
  /// ```
  bool get isVectorFileName => GetUtils.isVector(this);

  /// Discover if the String is an image file name
  ///
  /// Example:
  /// ```dart
  /// bool isImage = "image.png".isImageFileName;
  /// // Result: true
  /// ```
  bool get isImageFileName => GetUtils.isImage(this);

  /// Discover if the String is an audio file name
  ///
  /// Example:
  /// ```dart
  /// bool isAudio = "audio.mp3".isAudioFileName;
  /// // Result: true
  /// ```
  bool get isAudioFileName => GetUtils.isAudio(this);

  /// Discover if the String is a video file name
  ///
  /// Example:
  /// ```dart
  /// bool isVideo = "video.mp4".isVideoFileName;
  /// // Result: true
  /// ```
  bool get isVideoFileName => GetUtils.isVideo(this);

  /// Discover if the String is a text file name
  ///
  /// Example:
  /// ```dart
  /// bool isTxt = "document.txt".isTxtFileName;
  /// // Result: true
  /// ```
  bool get isTxtFileName => GetUtils.isTxt(this);

  /// Discover if the String is a Word document file name
  ///
  /// Example:
  /// ```dart
  /// bool isWord = "document.docx".isDocumentFileName;
  /// // Result: true
  /// ```
  bool get isDocumentFileName => GetUtils.isWord(this);

  /// Discover if the String is an Excel document file name
  ///
  /// Example:
  /// ```dart
  /// bool isExcel = "spreadsheet.xlsx".isExcelFileName;
  /// // Result: true
  /// ```
  bool get isExcelFileName => GetUtils.isExcel(this);

  /// Discover if the String is a PowerPoint document file name
  ///
  /// Example:
  /// ```dart
  /// bool isPPT = "presentation.pptx".isPPTFileName;
  /// // Result: true
  /// ```
  bool get isPPTFileName => GetUtils.isPPT(this);

  /// Discover if the String is an APK file name
  ///
  /// Example:
  /// ```dart
  /// bool isAPK = "app.apk".isAPKFileName;
  /// // Result: true
  /// ```
  bool get isAPKFileName => GetUtils.isAPK(this);

  /// Discover if the String is a PDF file name
  ///
  /// Example:
  /// ```dart
  /// bool isPDF = "document.pdf".isPDFFileName;
  /// // Result: true
  /// ```
  bool get isPDFFileName => GetUtils.isPDF(this);

  /// Discover if the String is an HTML file name
  ///
  /// Example:
  /// ```dart
  /// bool isHTML = "index.html".isHTMLFileName;
  /// // Result: true
  /// ```
  bool get isHTMLFileName => GetUtils.isHTML(this);

  /// Discover if the String is a URL
  ///
  /// Example:
  /// ```dart
  /// bool isURL = "https://example.com".isURL;
  /// // Result: true
  /// ```
  bool get isURL => GetUtils.isURL(this);

  /// Discover if the String is an email
  ///
  /// Example:
  /// ```dart
  /// bool isEmail = "example@example.com".isEmail;
  /// // Result: true
  /// ```
  bool get isEmail => GetUtils.isEmail(this);

  /// Discover if the String is a phone number
  ///
  /// Example:
  /// ```dart
  /// bool isPhoneNumber = "09123456789".isPhoneNumber;
  /// // Result: true
  /// ```
  bool get isPhoneNumber => GetUtils.isPhoneNumber(this);

  /// Discover if the String is a DateTime
  ///
  /// Example:
  /// ```dart
  /// bool isDateTime = "2023-10-10".isDateTime;
  /// // Result: true
  /// ```
  bool get isDateTime => GetUtils.isDateTime(this);

  /// Discover if the String is an MD5 hash
  ///
  /// Example:
  /// ```dart
  /// bool isMD5 = "d41d8cd98f00b204e9800998ecf8427e".isMD5;
  /// // Result: true
  /// ```
  bool get isMD5 => GetUtils.isMD5(this);

  /// Discover if the String is a SHA1 hash
  ///
  /// Example:
  /// ```dart
  /// bool isSHA1 = "da39a3ee5e6b4b0d3255bfef95601890afd80709".isSHA1;
  /// // Result: true
  /// ```
  bool get isSHA1 => GetUtils.isSHA1(this);

  /// Discover if the String is a SHA256 hash
  ///
  /// Example:
  /// ```dart
  /// bool isSHA256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855".isSHA256;
  /// // Result: true
  /// ```
  bool get isSHA256 => GetUtils.isSHA256(this);

  /// Discover if the String is a binary value
  ///
  /// Example:
  /// ```dart
  /// bool isBinary = "101010".isBinary;
  /// // Result: true
  /// ```
  bool get isBinary => GetUtils.isBinary(this);

  /// Discover if the String is an IPv4 address
  ///
  /// Example:
  /// ```dart
  /// bool isIPv4 = "192.168.1.1".isIPv4;
  /// // Result: true
  /// ```
  bool get isIPv4 => GetUtils.isIPv4(this);

  /// Discover if the String is an IPv6 address
  ///
  /// Example:
  /// ```dart
  /// bool isIPv6 = "2001:0db8:85a3:0000:0000:8a2e:0370:7334".isIPv6;
  /// // Result: true
  /// ```
  bool get isIPv6 => GetUtils.isIPv6(this);

  /// Discover if the String is a hexadecimal value
  ///
  /// Example:
  /// ```dart
  /// bool isHexadecimal = "1a2b3c".isHexadecimal;
  /// // Result: true
  /// ```
  bool get isHexadecimal => GetUtils.isHexadecimal(this);

  /// Discover if the String is a palindrome
  ///
  /// Example:
  /// ```dart
  /// bool isPalindrome = "madam".isPalindrome;
  /// // Result: true
  /// ```
  bool get isPalindrome => GetUtils.isPalindrome(this);

  /// Discover if the String is a passport number
  ///
  /// Example:
  /// ```dart
  /// bool isPassport = "A12345678".isPassport;
  /// // Result: true
  /// ```
  bool get isPassport => GetUtils.isPassport(this);

  /// Discover if the String is a currency
  ///
  /// Example:
  /// ```dart
  /// bool isCurrency = "\$100".isCurrency;
  /// // Result: true
  /// ```
  bool get isCurrency => GetUtils.isCurrency(this);

  /// Discover if the String is a CPF number
  ///
  /// Example:
  /// ```dart
  /// bool isCpf = "123.456.789-09".isCpf;
  /// // Result: true
  /// ```
  bool get isCpf => GetUtils.isCpf(this);

  /// Discover if the String is a CNPJ number
  ///
  /// Example:
  /// ```dart
  /// bool isCnpj = "12.345.678/0001-95".isCnpj;
  /// // Result: true
  /// ```
  bool get isCnpj => GetUtils.isCnpj(this);

  /// Discover if the String contains another string case insensitively
  ///
  /// Example:
  /// ```dart
  /// bool contains = "Hello World".isCaseInsensitiveContains("hello");
  /// // Result: true
  /// ```
  bool isCaseInsensitiveContains(String b) =>
      GetUtils.isCaseInsensitiveContains(this, b);

  /// Discover if the String contains any value case insensitively
  ///
  /// Example:
  /// ```dart
  /// bool containsAny = "Hello World".isCaseInsensitiveContainsAny("hello");
  /// // Result: true
  /// ```
  bool isCaseInsensitiveContainsAny(String b) =>
      GetUtils.isCaseInsensitiveContainsAny(this, b);

  /// Capitalize the String
  ///
  /// Example:
  /// ```dart
  /// String capitalized = "hello".capitalize;
  /// // Result: "Hello"
  /// ```
  String get capitalize => GetUtils.capitalize(this);

  /// Capitalize the first letter of the String
  ///
  /// Example:
  /// ```dart
  /// String capitalizedFirst = "hello world".capitalizeFirst;
  /// // Result: "Hello world"
  /// ```
  String get capitalizeFirst => GetUtils.capitalizeFirst(this);

  /// Remove all whitespace from the String
  ///
  /// Example:
  /// ```dart
  /// String noWhitespace = " h e l l o ".removeAllWhitespace;
  /// // Result: "hello"
  /// ```
  String get removeAllWhitespace => GetUtils.removeAllWhitespace(this);

  /// Convert the String to camel case
  ///
  /// Example:
  /// ```dart
  /// String camelCase = "hello world".camelCase;
  /// // Result: "helloWorld"
  /// ```
  String? get camelCase => GetUtils.camelCase(this);

  /// Convert the String to param case
  ///
  /// Example:
  /// ```dart
  /// String paramCase = "Hello World".paramCase;
  /// // Result: "hello-world"
  /// ```
  String? get paramCase => GetUtils.paramCase(this);

  /// Add segments to the String
  ///
  /// Example:
  /// ```dart
  /// String path = "home".createPath(["user", "documents"]);
  /// // Result: "/home/user/documents"
  /// ```
  String createPath([Iterable? segments]) {
    final path = startsWith('/') ? this : '/$this';
    return GetUtils.createPath(path, segments);
  }

  /// Capitalize only the first letter in each word of the String
  ///
  /// Example:
  /// ```dart
  /// String capitalizedWords = "hello world".capitalizeAllWordsFirstLetter();
  /// // Result: "Hello World"
  /// ```
  String capitalizeAllWordsFirstLetter() =>
      GetUtils.capitalizeAllWordsFirstLetter(this);

  /// Reverse the String
  ///
  /// Example:
  /// ```dart
  /// String reversed = "hello".reversed;
  /// // Result: "olleh"
  /// ```
  String get reversed => split('').reversed.join('');

  /// Check if the String is empty or null
  ///
  /// Example:
  /// ```dart
  /// bool isEmpty = "".isNullOrEmpty;
  /// // Result: true
  /// ```
  bool get isNullOrEmpty => isEmpty;

  /// Convert the String to title case
  ///
  /// Example:
  /// ```dart
  /// String titleCased = GetStringUtils.titleCase("hello world");
  /// // Result: "Hello World"
  /// ```
  static String titleCase(String input) {
    if (input.isEmpty) return input;

    return input
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;

          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}

/// Converts a string to a formatted number representation
extension StringNumberFormatter on String {
  /// Attempts to parse the string to a number and format it using intl NumberFormat
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234567".intlToNumberFormatted();
  /// // Result: "1,234,567"
  /// String originalText = "hello".intlToNumberFormatted();
  /// // Result: "hello"
  /// ```
  String intlToNumberFormatted() {
    try {
      final number = int.parse(this);
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a double and format it with two decimal places using intl NumberFormat
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234.5678".intlToDoubleFormatted();
  /// // Result: "1,234.57"
  /// String originalText = "hello".intlToDoubleFormatted();
  /// // Result: "hello"
  /// ```
  String intlToDoubleFormatted() {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat('#,##0.00');
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a double and format it as simple currency
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "12345.678".intlToDoubleSimpleCurrencyFormatted(2);
  /// // Result: "$12,345.68"
  /// String originalText = "hello".intlToDoubleSimpleCurrencyFormatted(2);
  /// // Result: "hello"
  /// ```
  String intlToDoubleSimpleCurrencyFormatted(int? decimalDigits) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.simpleCurrency(
        decimalDigits: decimalDigits,
      );
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it as currency with custom locale
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "12345.67".intlToCurrencyFormatted(locale: 'en_US', symbol: '\$');
  /// // Result: "$12,345.67"
  /// String formattedNumber = "12345.67".intlToCurrencyFormatted(locale: 'fa_IR', symbol: 'ریال');
  /// // Result: "۱۲٬۳۴۵٫۶۷ ریال"
  /// ```
  String intlToCurrencyFormatted({
    String? locale,
    String? symbol,
    int? decimalDigits,
    String? name,
  }) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
        name: name,
      );
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it as compact currency
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234567".intlToCompactCurrencyFormatted();
  /// // Result: "$1.2M"
  /// String formattedNumber = "1234".intlToCompactCurrencyFormatted();
  /// // Result: "$1.2K"
  /// ```
  String intlToCompactCurrencyFormatted({
    String? locale,
    String? symbol,
    int? decimalDigits,
    String? name,
  }) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.compactCurrency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
        name: name,
      );
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it as percentage
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "0.1234".intlToPercentageFormatted();
  /// // Result: "12%"
  /// String formattedNumber = "0.1234".intlToPercentageFormatted(decimalDigits: 2);
  /// // Result: "12.34%"
  /// ```
  String intlToPercentageFormatted({String? locale, int? decimalDigits}) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.percentPattern(locale);
      if (decimalDigits != null) {
        formatter.minimumFractionDigits = decimalDigits;
        formatter.maximumFractionDigits = decimalDigits;
      }
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it in compact form
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234567".intlToCompactFormatted();
  /// // Result: "1.2M"
  /// String formattedNumber = "1234".intlToCompactFormatted();
  /// // Result: "1.2K"
  /// ```
  String intlToCompactFormatted({String? locale}) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.compact(locale: locale);
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it in compact long form
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234567".intlToCompactLongFormatted();
  /// // Result: "1.2 million"
  /// String formattedNumber = "1234".intlToCompactLongFormatted();
  /// // Result: "1.2 thousand"
  /// ```
  String intlToCompactLongFormatted({String? locale}) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.compactLong(locale: locale);
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it with custom decimal digits
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234.5678".intlToDecimalFormatted(decimalDigits: 2);
  /// // Result: "1,234.57"
  /// String formattedNumber = "1234.5678".intlToDecimalFormatted(decimalDigits: 0);
  /// // Result: "1,235"
  /// ```
  String intlToDecimalFormatted({String? locale, int? decimalDigits}) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.decimalPattern(locale);
      if (decimalDigits != null) {
        formatter.minimumFractionDigits = decimalDigits;
        formatter.maximumFractionDigits = decimalDigits;
      }
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string to a number and format it in scientific notation
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = "1234567".intlToScientificFormatted();
  /// // Result: "1.234567E6"
  /// String formattedNumber = "0.000123".intlToScientificFormatted();
  /// // Result: "1.23E-4"
  /// ```
  String intlToScientificFormatted({String? locale}) {
    try {
      final number = double.parse(this);
      final formatter = NumberFormat.scientificPattern(locale);
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  /// تبدیل متن فارسی به فرمت استاندارد (اصلاح فاصله‌ها و کاراکترها)
  ///
  /// مثال:
  /// ```dart
  /// String text = "سلام  دنيا";
  /// String standardText = text.standardizePersianText();
  /// // نتیجه: "سلام دنیا"
  ///
  ///
  /// ```
  String standardizePersianText() {
    // تبدیل کاراکترهای عربی به فارسی
    String result = replaceAll('ي', 'ی').replaceAll('ك', 'ک');

    // اصلاح فاصله‌های اضافی
    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();

    // اصلاح نیم‌فاصله‌ها
    final halfSpaceNeededAfter = ['می', 'نمی', 'بی', 'می‌', 'نمی‌'];
    for (final word in halfSpaceNeededAfter) {
      result = result.replaceAll('$word ', '$word‌');
    }

    return result;
  }

  /// تبدیل اعداد انگلیسی به فارسی در متن
  ///
  /// مثال:
  /// ```dart
  /// String text = "قیمت: 12500 تومان";
  /// String persianText = text.convertDigitsToPersian();
  /// // نتیجه: "قیمت: ۱۲۵۰۰ تومان"
  ///
  ///
  /// ```
  String convertDigitsToPersian() {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// تبدیل اعداد فارسی به انگلیسی در متن
  ///
  /// مثال:
  /// ```dart
  /// String text = "قیمت: ۱۲۵۰۰ تومان";
  /// String englishText = text.convertDigitsToEnglish();
  /// // نتیجه: "قیمت: 12500 تومان"
  ///
  ///
  /// ```
  String convertDigitsToEnglish() {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String result = this;
    for (int i = 0; i < persianDigits.length; i++) {
      result = result.replaceAll(persianDigits[i], i.toString());
    }
    return result;
  }

  /// اعتبارسنجی کد ملی ایرانی
  ///
  /// مثال:
  /// ```dart
  /// String nationalCode = "0123456789";
  /// bool isValid = nationalCode.isValidIranianNationalCode();
  ///
  /// // نتیجه: true
  ///
  ///
  /// ```
  bool isValidIranianNationalCode() {
    // کد ملی باید 10 رقم باشد
    if (length != 10) return false;

    // کد ملی نباید با کاراکتر غیرعددی باشد
    if (contains(RegExp(r'\D'))) return false;

    // کد ملی نباید همه ارقامش یکسان باشد
    if (RegExp(r'^(\d)\1+$').hasMatch(this)) return false;

    // الگوریتم محاسبه
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(this[i]) * (10 - i);
    }
    int remainder = sum % 11;
    int controlDigit = remainder < 2 ? remainder : 11 - remainder;

    return controlDigit == int.parse(this[9]);
  }

  /// اعتبارسنجی شماره شبا (IBAN) ایرانی
  ///
  /// مثال:
  /// ```dart
  /// String iban = "IR062960000000100324200001";
  /// bool isValid = iban.isValidIranianSheba();
  ///
  ///
  /// ```
  bool isValidIranianSheba() {
    // شماره شبای ایران باید با IR شروع شود و 24 رقم داشته باشد
    if (!startsWith('IR') || length != 26) return false;

    // بررسی اینکه بقیه کاراکترها عدد باشند
    if (substring(2).contains(RegExp(r'\D'))) return false;

    // الگوریتم بررسی شبا (محاسبات پیچیده‌تر مورد نیاز است)
    // این یک بررسی ساده اولیه است
    return true;
  }

  /// Attempts to parse the string as a date and format it using intl DateFormat
  ///
  /// Example:
  /// ```dart
  /// String dateString = "2023-12-25";
  /// String formattedDate = dateString.intlToDateFormatted("yyyy/MM/dd");
  /// // Result: "2023/12/25"
  /// String formattedDate = dateString.intlToDateFormatted("EEEE, MMMM d, y");
  /// // Result: "Monday, December 25, 2023"
  /// ```
  String intlToDateFormatted(String pattern, {String? locale}) {
    try {
      final date = DateTime.parse(this);
      final formatter = DateFormat(pattern, locale);
      return formatter.format(date);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string as a date and format it to a localized date string
  ///
  /// Example:
  /// ```dart
  /// String dateString = "2023-12-25";
  /// String formattedDate = dateString.intlToLocalizedDateFormatted();
  /// // Result: "Dec 25, 2023" (for en_US locale)
  /// String formattedDate = dateString.intlToLocalizedDateFormatted(locale: 'fa_IR');
  /// // Result: "۲۵ دسامبر ۲۰۲۳" (for fa_IR locale)
  /// ```
  String intlToLocalizedDateFormatted({String? locale}) {
    try {
      final date = DateTime.parse(this);
      final formatter = DateFormat.yMMMd(locale);
      return formatter.format(date);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string as a date and format it to a full date string
  ///
  /// Example:
  /// ```dart
  /// String dateString = "2023-12-25";
  /// String formattedDate = dateString.intlToFullDateFormatted();
  /// // Result: "Monday, December 25, 2023"
  /// ```
  String intlToFullDateFormatted({String? locale}) {
    try {
      final date = DateTime.parse(this);
      final formatter = DateFormat.yMMMMEEEEd(locale);
      return formatter.format(date);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string as a date and format it to a time string
  ///
  /// Example:
  /// ```dart
  /// String dateString = "2023-12-25T14:30:00";
  /// String formattedTime = dateString.intlToTimeFormatted();
  /// // Result: "2:30 PM"
  /// String formattedTime = dateString.intlToTimeFormatted(use24Hour: true);
  /// // Result: "14:30"
  /// ```
  String intlToTimeFormatted({String? locale, bool use24Hour = false}) {
    try {
      final date = DateTime.parse(this);
      final formatter =
          use24Hour ? DateFormat.Hm(locale) : DateFormat.jm(locale);
      return formatter.format(date);
    } catch (e) {
      return this;
    }
  }

  /// Attempts to parse the string as a date and format it to a relative time string
  ///
  /// Example:
  /// ```dart
  /// String dateString = DateTime.now().subtract(Duration(hours: 2)).toIso8601String();
  /// String relativeTime = dateString.intlToRelativeTimeFormatted();
  /// // Result: "2 hours ago"
  /// ```
  String intlToRelativeTimeFormatted({String? locale}) {
    try {
      final date = DateTime.parse(this);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return this;
    }
  }
}

/// Extension on String to provide responsive text widget creation.
///
/// This extension adds a method to the String class to create a Text widget
/// with responsive font size based on the screen dimensions.
///
/// Example usage:
/// ```dart
/// String myText = "Hello, World!";
/// Text responsiveText = myText.responsive(fontSize: 16.0);
/// ```
///
/// The `responsive` method takes the following optional parameters:
/// - `key`: A Key for the Text widget.
/// - `fontSize`: The base font size to be scaled responsively. Defaults to 14.0.
/// - `fontWeight`: The font weight of the text.
/// - `color`: The color of the text.
/// - `textAlign`: How the text should be aligned horizontally.
/// - `maxLines`: The maximum number of lines for the text.
/// - `overflow`: How visual overflow should be handled.
///
/// The `_getResponsiveFontSize` method calculates the responsive font size
/// based on the screen width and height, using a base design width and height
/// (e.g., iPhone X dimensions). The scale is clamped between 0.8 and 1.3 to
/// prevent extremely large or small fonts.

extension ResponsiveText on String {
  Text responsive({
    Key? key,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      this,
      key: key,
      style: TextStyle(
        fontSize: _getResponsiveFontSize(fontSize ?? 14.0),
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  double _getResponsiveFontSize(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    double baseWidth = 375.0; // Base design width (e.g., iPhone X)
    double baseHeight = 812.0; // Base design height (e.g., iPhone X)

    double widthScale = screenWidth / baseWidth;
    double heightScale = screenHeight / baseHeight;

    // Use the average of width and height scale for better calculation
    double scale = (widthScale + heightScale) / 2;

    // Limit the scale to prevent extremely large or small fonts
    scale = scale.clamp(0.8, 1.3);

    return (fontSize * scale).roundToDouble();
  }
}

/// Extension on nullable String to provide responsive text styling.
///
/// This extension provides methods to handle nullable strings and apply
/// responsive text styles based on the screen size.
///
/// Methods:
/// - `value`: Returns the string value or an empty string if null.
/// - `responsiveStyle`: Returns a `TextStyle` with responsive font size,
///   font weight, and color based on the provided parameters and screen size.
/// - `_getResponsiveFontSize`: Calculates the responsive font size based on
///   the screen width and height.
///
/// Example usage:
/// ```dart
/// String? myText = "Hello, World!";
/// TextStyle style = myText.responsiveStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
/// ```
extension ResponsiveTextNull on String? {
  String get value => this ?? '';

  TextStyle responsiveStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextStyle? baseStyle,
  }) {
    return (baseStyle ?? TextStyle()).copyWith(
      fontSize: _getResponsiveFontSize(fontSize ?? 14.0),
      fontWeight: fontWeight,
      color: color,
    );
  }

  double _getResponsiveFontSize(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    double baseWidth = 375.0; // Base design width (e.g., iPhone X)
    double baseHeight = 812.0; // Base design height (e.g., iPhone X)

    double widthScale = screenWidth / baseWidth;
    double heightScale = screenHeight / baseHeight;

    double scale = (widthScale + heightScale) / 2;
    scale = scale.clamp(0.8, 1.3);

    return (fontSize * scale).roundToDouble();
  }
}
