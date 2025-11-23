import '../../../get_core/get_core.dart';

/// Returns whether a dynamic value PROBABLY
/// has the isEmpty getter/method by checking
/// standard dart types that contains it.
///
/// This is here to for the 'DRY'
///
/// Example:
/// ```dart
/// _isEmpty(''); // true
/// _isEmpty([]); // true
/// _isEmpty({}); // true
/// _isEmpty(null); // false
/// _isEmpty(12); // false
///
///
/// ```
bool? _isEmpty(dynamic value) {
  if (value is String) {
    return value.toString().trim().isEmpty;
  }
  if (value is Iterable || value is Map) {
    return value.isEmpty;
  }
  return false;
}

/// Returns whether a dynamic value PROBABLY
/// has the length getter/method by checking
/// standard dart types that contains it.
///
/// This is here to for the 'DRY'
///
/// Example:
/// ```dart
/// _hasLength(''); // true
/// _hasLength([]); // true
/// _hasLength({}); // true
/// _hasLength(null); // false
/// _hasLength(12); // false
///
///
/// ```
bool _hasLength(dynamic value) {
  return value is Iterable || value is String || value is Map;
}

/// Obtains a length of a dynamic value
/// by previously validating it's type
///
/// Note: if [value] is double/int
/// it will be taking the .toString
/// length of the given value.
///
/// Note 2: **this may return null!**
///
/// Note 3: null [value] returns null.
///
/// Example:
/// ```dart
/// _obtainDynamicLength(''); // 0
/// _obtainDynamicLength([]); // 0
/// _obtainDynamicLength({}); // 0
/// _obtainDynamicLength(null); // null
/// _obtainDynamicLength(12); // 2
/// _obtainDynamicLength(12.5); // 3
/// _obtainDynamicLength('Hello'); // 5
///
///
/// ```
int? _obtainDynamicLength(dynamic value) {
  if (value == null) {
    return null;
  }

  if (_hasLength(value)) {
    return value.length;
  }

  if (value is int) {
    return value.toString().length;
  }

  if (value is double) {
    return value.toString().replaceAll('.', '').length;
  }

  return null;
}

class GetUtils {
  GetUtils._();

  static bool hasPatternMatch(String s, String pattern) {
    return RegExp(pattern).hasMatch(s);
  }

  /// Checks if data is null.
  ///
  /// Example:
  /// ```dart
  /// isNull(null); // true
  /// isNull(12); // false
  ///
  ///
  /// ```
  static bool isNull(dynamic value) => value == null;

  /// In dart2js (in flutter v1.17) a var by default is undefined.
  /// *Use this only if you are in version <- 1.17*.
  /// So we assure the null type in json conversions to avoid the
  /// "value":value==null?null:value; someVar.nil will force the null type
  /// if the var is null or undefined.
  /// `nil` taken from ObjC just to have a shorter syntax.
  ///
  /// Example:
  /// ```dart
  /// nil(null); // null
  /// nil(12); // 12
  ///
  /// ```
  static dynamic nil(dynamic s) => s;

  /// Checks if data is null or blank (empty or only contains whitespace).
  ///
  /// Example:
  /// ```dart
  /// isNullOrBlank(null); // true
  /// isNullOrBlank(''); // true
  /// isNullOrBlank('  '); // true
  /// isNullOrBlank([]); // true
  /// isNullOrBlank({}); // true
  /// isNullOrBlank('Hello'); // false
  /// isNullOrBlank(12); // false
  ///
  ///
  /// ```
  static bool? isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    return _isEmpty(value);
  }

  /// Checks if data is blank (empty or only contains whitespace).
  ///
  /// Example:
  /// ```dart
  /// isBlank(''); // true
  /// isBlank('  '); // true
  /// isBlank([]); // true
  /// isBlank({}); // true
  /// isBlank(null); // null
  /// isBlank('Hello'); // false
  /// isBlank(12); // false
  ///
  ///
  /// ```
  static bool? isBlank(dynamic value) {
    return _isEmpty(value);
  }

  /// Checks if string is int or double.
  ///
  /// Example:
  /// ```dart
  /// isNum('12'); // true
  /// isNum('12.5'); // true
  /// isNum('Hello'); // false
  /// isNum(null); // false
  ///
  ///
  /// ```
  static bool isNum(String? value) {
    if (isNull(value)) {
      return false;
    }

    return num.tryParse(value!) != null;
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  ///
  /// Example:
  /// ```dart
  /// isNumericOnly('123'); // true
  /// isNumericOnly('12.5'); // false
  /// isNumericOnly('Hello'); // false
  ///
  ///
  /// ```
  static bool isNumericOnly(String s) => hasPatternMatch(s, r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  ///
  /// Example:
  /// ```dart
  /// isAlphabetOnly('Hello'); // true
  /// isAlphabetOnly('Hello World'); // false
  /// isAlphabetOnly('123'); // false
  ///
  ///
  /// ```
  static bool isAlphabetOnly(String s) => hasPatternMatch(s, r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  ///
  /// Example:
  /// ```dart
  /// hasCapitalLetter('Hello'); // true
  /// hasCapitalLetter('hello'); // false
  /// hasCapitalLetter('123'); // false
  ///
  ///
  /// ```
  static bool hasCapitalLetter(String s) => hasPatternMatch(s, r'[A-Z]');

  /// Checks if string is boolean.
  ///
  /// Example:
  /// ```dart
  /// isBool('true'); // true
  /// isBool('false'); // true
  /// isBool('True'); // false
  /// isBool('1'); // false
  /// isBool(null); // false
  ///
  ///
  /// ```
  static bool isBool(String? value) {
    if (isNull(value)) {
      return false;
    }

    return value == 'true' || value == 'false';
  }

  /// Checks if string is an video file.
  ///
  /// Example:
  /// ```dart
  /// isVideo('video.mp4'); // true
  /// isVideo('video.avi'); // true
  /// isVideo('image.jpg'); // false
  ///
  ///
  /// ```
  static bool isVideo(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".mp4") ||
        ext.endsWith(".avi") ||
        ext.endsWith(".wmv") ||
        ext.endsWith(".rmvb") ||
        ext.endsWith(".mpg") ||
        ext.endsWith(".mpeg") ||
        ext.endsWith(".3gp");
  }

  /// Checks if string is an image file.
  ///
  /// Example:
  /// ```dart
  /// isImage('image.jpg'); // true
  /// isImage('image.png'); // true
  /// isImage('video.mp4'); // false
  ///
  ///
  /// ```
  static bool isImage(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp");
  }

  /// Checks if string is an audio file.
  ///
  /// Example:
  /// ```dart
  /// isAudio('audio.mp3'); // true
  /// isAudio('audio.wav'); // true
  /// isAudio('image.jpg'); // false
  ///
  ///
  /// ```
  static bool isAudio(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".mp3") ||
        ext.endsWith(".wav") ||
        ext.endsWith(".wma") ||
        ext.endsWith(".amr") ||
        ext.endsWith(".ogg");
  }

  /// Checks if string is an powerpoint file.
  ///
  /// Example:
  /// ```dart
  /// isPPT('presentation.ppt'); // true
  /// isPPT('presentation.pptx'); // true
  /// isPPT('document.docx'); // false
  ///
  ///
  /// ```
  static bool isPPT(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".ppt") || ext.endsWith(".pptx");
  }

  /// Checks if string is an word file.
  ///
  /// Example:
  /// ```dart
  /// isWord('document.doc'); // true
  /// isWord('document.docx'); // true
  /// isWord('presentation.ppt'); // false
  ///
  ///
  /// ```
  static bool isWord(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".doc") || ext.endsWith(".docx");
  }

  /// Checks if string is an excel file.
  ///
  /// Example:
  /// ```dart
  /// isExcel('spreadsheet.xls'); // true
  /// isExcel('spreadsheet.xlsx'); // true
  /// isExcel('document.docx'); // false
  ///
  ///
  /// ```
  static bool isExcel(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".xls") || ext.endsWith(".xlsx");
  }

  /// Checks if string is an apk file.
  ///
  /// Example:
  /// ```dart
  /// isAPK('app.apk'); // true
  /// isAPK('document.docx'); // false
  ///
  ///
  /// ```
  static bool isAPK(String filePath) {
    return filePath.toLowerCase().endsWith(".apk");
  }

  /// Checks if string is an pdf file.
  ///
  /// Example:
  /// ```dart
  /// isPDF('document.pdf'); // true
  /// isPDF('document.docx'); // false
  ///
  ///
  /// ```
  static bool isPDF(String filePath) {
    return filePath.toLowerCase().endsWith(".pdf");
  }

  /// Checks if string is an txt file.
  ///
  /// Example:
  /// ```dart
  /// isTxt('text.txt'); // true
  /// isTxt('document.docx'); // false
  ///
  ///
  /// ```
  static bool isTxt(String filePath) {
    return filePath.toLowerCase().endsWith(".txt");
  }

  /// Checks if string is an chm file.
  ///
  /// Example:
  /// ```dart
  /// isChm('help.chm'); // true
  /// isChm('document.docx'); // false
  ///
  ///
  /// ```
  static bool isChm(String filePath) {
    return filePath.toLowerCase().endsWith(".chm");
  }

  /// Checks if string is a vector file.
  ///
  /// Example:
  /// ```dart
  /// isVector('image.svg'); // true
  /// isVector('image.jpg'); // false
  ///
  ///
  /// ```
  static bool isVector(String filePath) {
    return filePath.toLowerCase().endsWith(".svg");
  }

  /// Checks if string is an html file.
  ///
  /// Example:
  /// ```dart
  /// isHTML('webpage.html'); // true
  /// isHTML('document.docx'); // false
  ///
  ///
  /// ```
  static bool isHTML(String filePath) {
    return filePath.toLowerCase().endsWith(".html");
  }

  /// Checks if string is a valid username.
  ///
  /// Example:
  /// ```dart
  /// isUsername('john_doe123'); // true
  /// isUsername('john doe'); // false
  /// isUsername('john'); // false
  /// isUsername('_johndoe'); // false
  ///
  ///
  /// ```
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is URL.
  ///
  /// Example:
  /// ```dart
  /// isURL('https://www.example.com'); // true
  /// isURL('http://example.com'); // true
  /// isURL('www.example.com'); // true
  /// isURL('example.com'); // true
  /// isURL('example'); // false
  /// isURL('https://www.example.com/path/to/page?param=value'); // true
  /// isURL('ftp://example.com'); // true
  ///
  ///
  /// ```
  static bool isURL(String s) => hasMatch(
    s,
    r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,7}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&%\$#\=~_\-]+))*$",
  );

  /// Checks if string is email.
  ///
  /// Example:
  /// ```dart
  /// isEmail('test@example.com'); // true
  /// isEmail('test.name@example.com'); // true
  /// isEmail('test@example'); // false
  /// isEmail('@example.com'); // false
  ///
  ///
  /// ```
  static bool isEmail(String s) => hasMatch(
    s,
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  /// Checks if string is phone number.
  ///
  /// Example:
  /// ```dart
  /// isPhoneNumber('+1-555-555-5555'); // true
  /// isPhoneNumber('555-555-5555'); // true
  /// isPhoneNumber('5555555555'); // true
  /// isPhoneNumber('+15555555555'); // true
  /// isPhoneNumber('123'); // false
  /// isPhoneNumber('abc'); // false
  ///
  ///
  /// ```
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is DateTime (UTC or Iso8601).
  ///
  /// Example:
  /// ```dart
  /// isDateTime('2023-10-27T10:30:00Z'); // true
  /// isDateTime('2023-10-27T10:30:00.000Z'); // true
  /// isDateTime('2023-10-27 10:30:00'); // false
  ///
  ///
  /// ```
  static bool isDateTime(String s) =>
      hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');

  /// Checks if string is MD5 hash.
  ///
  /// Example:
  /// ```dart
  /// isMD5('d41d8cd98f00b204e9800998ecf8427e'); // true
  /// isMD5('abc'); // false
  ///
  ///
  /// ```
  static bool isMD5(String s) => hasMatch(s, r'^[a-f0-9]{32}$');

  /// Checks if string is SHA1 hash.
  ///
  /// Example:
  /// ```dart
  /// isSHA1('a9993e364706816aba3e25717850c26c9cd0d89d'); // true
  /// isSHA1('abc'); // false
  ///
  ///
  /// ```
  static bool isSHA1(String s) =>
      hasMatch(s, r'(([A-Fa-f0-9]{2}\:){19}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{40})');

  /// Checks if string is SHA256 hash.
  ///
  /// Example:
  /// ```dart
  /// isSHA256('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'); // true
  /// isSHA256('abc'); // false
  ///
  ///
  /// ```
  static bool isSHA256(String s) =>
      hasMatch(s, r'([A-Fa-f0-9]{2}\:){31}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{64}');

  /// Checks if the string is an SSN (Social Security Number).
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isSSN('123-45-6789'); // true
  /// ValidationUtils.isSSN('000-12-3456'); // false
  ///
  ///
  /// ```
  static bool isSSN(String s) => hasMatch(
    s,
    r'^(?!0{3}|6{3}|9[0-9]{2})[0-9]{3}-?(?!0{2})[0-9]{2}-?(?!0{4})[0-9]{4}$',
  );

  /// Checks if the string is binary (contains only 0s and 1s).
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isBinary('101010'); // true
  /// ValidationUtils.isBinary('1234'); // false
  ///
  ///
  /// ```
  static bool isBinary(String s) => hasMatch(s, r'^[0-1]+$');

  /// Checks if the string is a valid IPv4 address.
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isIPv4('192.168.1.1'); // true
  /// ValidationUtils.isIPv4('999.999.999.999'); // false
  ///
  ///
  /// ```
  static bool isIPv4(String s) =>
      hasMatch(s, r'^(?:(?:^|\.)(?:2(?:5[0-5]|[0-4]\d)|1?\d?\d)){4}$');

  /// Checks if the string is a valid IPv6 address.
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isIPv6('2001:0db8:85a3:0000:0000:8a2e:0370:7334'); // true
  /// ValidationUtils.isIPv6('1234:5678'); // false
  ///
  ///
  /// ```
  static bool isIPv6(String s) => hasMatch(
    s,
    r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$',
  );

  /// Checks if the string is a valid hexadecimal color.
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isHexadecimal('#FFF'); // true
  /// ValidationUtils.isHexadecimal('#GGG'); // false
  ///
  ///
  /// ```
  static bool isHexadecimal(String s) =>
      hasMatch(s, r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

  /// Checks if the string is a palindrome.
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isPalindrome('racecar'); // true
  /// ValidationUtils.isPalindrome('hello'); // false
  ///
  ///
  /// ```
  static bool isPalindrome(String string) {
    final cleanString = string
        .toLowerCase()
        .replaceAll(RegExp(r"\s+"), '')
        .replaceAll(RegExp(r"[^0-9a-zA-Z]+"), "");

    for (var i = 0; i < cleanString.length; i++) {
      if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
        return false;
      }
    }
    return true;
  }

  /// Checks if all characters or elements in the value are identical.
  ///
  /// **Example**:
  /// ```dart
  /// ValidationUtils.isOneAKind('111111'); // true
  /// ValidationUtils.isOneAKind('abcdef'); // false
  ///
  ///
  /// ```
  static bool isOneAKind(dynamic value) {
    if ((value is String || value is List) && !isNullOrBlank(value)!) {
      final first = value[0];
      final len = value.length as num;

      for (var i = 0; i < len; i++) {
        if (value[i] != first) {
          return false;
        }
      }
      return true;
    }

    if (value is int) {
      final stringValue = value.toString();
      final first = stringValue[0];

      for (var i = 0; i < stringValue.length; i++) {
        if (stringValue[i] != first) {
          return false;
        }
      }
      return true;
    }

    return false;
  }

  /// Checks if string is Passport No.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isPassport("A1234567");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isPassport(String s) =>
      hasMatch(s, r'^(?!^0+$)[a-zA-Z0-9]{6,9}$');

  /// Checks if string is Currency.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isCurrency("\$100");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isCurrency(String s) => hasMatch(
    s,
    r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$',
  );

  /// Checks if length of data is GREATER than maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthGreaterThan("Hello", 3);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthGreaterThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length > maxLength;
  }

  /// Checks if length of data is GREATER OR EQUAL to maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthGreaterOrEqual("Hello", 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthGreaterOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length >= maxLength;
  }

  /// Checks if length of data is LESS than maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthLessThan("Hello", 10);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthLessThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);
    if (length == null) {
      return false;
    }

    return length < maxLength;
  }

  /// Checks if length of data is LESS OR EQUAL to maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthLessOrEqual("Hello", 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthLessOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length <= maxLength;
  }

  /// Checks if length of data is EQUAL to maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthEqualTo("Hello", 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthEqualTo(dynamic value, int otherLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length == otherLength;
  }

  /// Checks if length of data is BETWEEN minLength to maxLength.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isLengthBetween("Hello", 3, 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLengthBetween(dynamic value, int minLength, int maxLength) {
    if (isNull(value)) {
      return false;
    }

    return isLengthGreaterOrEqual(value, minLength) &&
        isLengthLessOrEqual(value, maxLength);
  }

  /// Checks if a contains b (Treating or interpreting upper- and lowercase
  /// letters as being the same).
  ///
  /// Example:
  /// ```dart
  /// bool contains = GetUtils.isCaseInsensitiveContains("Hello", "hello");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isCaseInsensitiveContains(String a, String b) {
    return a.toLowerCase().contains(b.toLowerCase());
  }

  /// Checks if a contains b or b contains a (Treating or
  /// interpreting upper- and lowercase letters as being the same).
  ///
  /// Example:
  /// ```dart
  /// bool containsAny = GetUtils.isCaseInsensitiveContainsAny("Hello", "hello");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isCaseInsensitiveContainsAny(String a, String b) {
    final lowA = a.toLowerCase();
    final lowB = b.toLowerCase();

    return lowA.contains(lowB) || lowB.contains(lowA);
  }

  /// Checks if num a LOWER than num b.
  ///
  /// Example:
  /// ```dart
  /// bool isLower = GetUtils.isLowerThan(5, 10);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isLowerThan(num a, num b) => a < b;

  /// Checks if num a GREATER than num b.
  ///
  /// Example:
  /// ```dart
  /// bool isGreater = GetUtils.isGreaterThan(10, 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isGreaterThan(num a, num b) => a > b;

  /// Checks if num a EQUAL than num b.
  ///
  /// Example:
  /// ```dart
  /// bool isEqual = GetUtils.isEqual(5, 5);
  /// // Result: true
  ///
  ///
  /// ```
  static bool isEqual(num a, num b) => a == b;

  /// Checks if num is a cnpj.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isCnpj("12.345.678/0001-95");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isCnpj(String cnpj) {
    // Get only the numbers from the CNPJ
    final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Test if the CNPJ has 14 digits
    if (numbers.length != 14) {
      return false;
    }

    // Test if all digits of the CNPJ are the same
    if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) {
      return false;
    }

    // Divide digits
    final digits = numbers.split('').map(int.parse).toList();

    // Calculate the first check digit
    var calcDv1 = 0;
    var j = 0;
    for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
      calcDv1 += digits[j++] * i;
    }
    calcDv1 %= 11;
    final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    // Test the first check digit
    if (digits[12] != dv1) {
      return false;
    }

    // Calculate the second check digit
    var calcDv2 = 0;
    j = 0;
    for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
      calcDv2 += digits[j++] * i;
    }
    calcDv2 %= 11;
    final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    // Test the second check digit
    if (digits[13] != dv2) {
      return false;
    }

    return true;
  }

  /// Checks if the cpf is valid.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = GetUtils.isCpf("123.456.789-09");
  /// // Result: true
  ///
  ///
  /// ```
  static bool isCpf(String cpf) {
    // get only the numbers
    final numbers = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    // Test if the CPF has 11 digits
    if (numbers.length != 11) {
      return false;
    }
    // Test if all CPF digits are the same
    if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) {
      return false;
    }

    // split the digits
    final digits = numbers.split('').map(int.parse).toList();

    // Calculate the first verifier digit
    var calcDv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digits[10 - i] * i;
    }
    calcDv1 %= 11;

    final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    // Tests the first verifier digit
    if (digits[9] != dv1) {
      return false;
    }

    // Calculate the second verifier digit
    var calcDv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digits[11 - i] * i;
    }
    calcDv2 %= 11;

    final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    // Test the second verifier digit
    if (digits[10] != dv2) {
      return false;
    }

    return true;
  }

  /// Capitalize each word inside string
  ///
  /// Example:
  /// ```dart
  /// String capitalized = GetUtils.capitalize("your name");
  /// // Result: "Your Name"
  ///
  ///
  /// ```
  static String capitalize(String value) {
    if (isBlank(value)!) return value;
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  ///
  /// Example:
  /// ```dart
  /// String capitalizedFirst = GetUtils.capitalizeFirst("your name");
  /// // Result: "Your name"
  ///
  ///
  /// ```
  static String capitalizeFirst(String s) {
    if (isBlank(s)!) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  ///
  /// Example:
  /// ```dart
  /// String noWhitespace = GetUtils.removeAllWhitespace("your name");
  /// // Result: "yourname"
  ///
  ///
  /// ```
  static String removeAllWhitespace(String value) {
    return value.replaceAll(' ', '');
  }

  /// camelCase string
  ///
  /// Example:
  /// ```dart
  /// String camelCased = GetUtils.camelCase("your name");
  /// // Result: "yourName"
  ///
  ///
  /// ```
  static String? camelCase(String value) {
    if (isNullOrBlank(value)!) {
      return null;
    }

    final separatedWords = value.split(
      RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'),
    );
    var newString = '';

    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    return newString[0].toLowerCase() + newString.substring(1);
  }

  /// credits to "ReCase" package.
  static final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
  static final _symbolSet = {' ', '.', '/', '_', '\\', '-'};
  static List<String> _groupIntoWords(String text) {
    var sb = StringBuffer();
    var words = <String>[];
    var isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      var nextChar = i + 1 == text.length ? null : text[i + 1];
      if (_symbolSet.contains(char)) {
        continue;
      }
      sb.write(char);
      var isEndOfWord =
          nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);
      if (isEndOfWord) {
        words.add('$sb');
        sb.clear();
      }
    }
    return words;
  }

  /// snake_case
  ///
  /// Example:
  /// ```dart
  /// String snakeCased = GetUtils.snakeCase("your name");
  /// // Result: "your_name"
  ///
  ///
  /// ```
  static String? snakeCase(String? text, {String separator = '_'}) {
    if (isNullOrBlank(text)!) {
      return null;
    }
    return _groupIntoWords(
      text!,
    ).map((word) => word.toLowerCase()).join(separator);
  }

  /// param-case
  ///
  /// Example:
  /// ```dart
  /// String paramCased = GetUtils.paramCase("your name");
  /// // Result: "your-name"
  ///
  ///
  /// ```
  static String? paramCase(String? text) => snakeCase(text, separator: '-');

  /// Extract numeric value of string
  ///
  /// Example:
  /// ```dart
  /// String numeric = GetUtils.numericOnly("OTP 12312 27/04/2020");
  /// // Result: "1231227042020"
  /// String firstNumeric = GetUtils.numericOnly("OTP 12312 27/04/2020", firstWordOnly: true);
  /// // Result: "12312"
  ///
  ///
  /// ```
  static String numericOnly(String s, {bool firstWordOnly = false}) {
    var numericOnlyStr = '';

    for (var i = 0; i < s.length; i++) {
      if (isNumericOnly(s[i])) {
        numericOnlyStr += s[i];
      }
      if (firstWordOnly && numericOnlyStr.isNotEmpty && s[i] == " ") {
        break;
      }
    }

    return numericOnlyStr;
  }

  /// Capitalize only the first letter of each word in a string
  ///
  /// Example:
  /// ```dart
  /// String capitalizedWords = GetUtils.capitalizeAllWordsFirstLetter("getx will make it easy");
  /// // Result: "Getx Will Make It Easy"
  ///
  ///
  /// ```
  static String capitalizeAllWordsFirstLetter(String s) {
    String lowerCasedString = s.toLowerCase();
    String stringWithoutExtraSpaces = lowerCasedString.trim();

    if (stringWithoutExtraSpaces.isEmpty) {
      return "";
    }
    if (stringWithoutExtraSpaces.length == 1) {
      return stringWithoutExtraSpaces.toUpperCase();
    }

    List<String> stringWordsList = stringWithoutExtraSpaces.split(" ");
    List<String> capitalizedWordsFirstLetter = stringWordsList
        .map((word) {
          if (word.trim().isEmpty) return "";
          return word.trim();
        })
        .where((word) => word != "")
        .map((word) {
          if (word.startsWith(RegExp(r'[\n\t\r]'))) {
            return word;
          }
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .toList();
    String finalResult = capitalizedWordsFirstLetter.join(" ");
    return finalResult;
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static String createPath(String path, [Iterable? segments]) {
    if (segments == null || segments.isEmpty) {
      return path;
    }
    final list = segments.map((e) => '/$e');
    return path + list.join();
  }

  static void printFunction(
    String prefix,
    dynamic value,
    String info, {
    bool isError = false,
  }) {
    Get.log('$prefix $value $info'.trim(), isError: isError);
  }
}
