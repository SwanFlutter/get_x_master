import 'package:flutter_test/flutter_test.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  group('String Intl Extensions Tests', () {
    test(
      'intlToDoubleSimpleCurrencyFormatted should format currency correctly',
      () {
        expect(
          "12345.678".intlToDoubleSimpleCurrencyFormatted(2),
          contains("12,345.68"),
        );
        expect("hello".intlToDoubleSimpleCurrencyFormatted(2), equals("hello"));
      },
    );

    test(
      'intlToCurrencyFormatted should format currency with custom locale',
      () {
        expect(
          "12345.67".intlToCurrencyFormatted(locale: 'en_US', symbol: '\$'),
          contains("12,345.67"),
        );
        expect(
          "invalid".intlToCurrencyFormatted(locale: 'en_US', symbol: '\$'),
          equals("invalid"),
        );
      },
    );

    test('intlToCompactCurrencyFormatted should format compact currency', () {
      expect("1234567".intlToCompactCurrencyFormatted(), contains("1.2M"));
      expect("1234".intlToCompactCurrencyFormatted(), contains("1.2K"));
      expect("invalid".intlToCompactCurrencyFormatted(), equals("invalid"));
    });

    test('intlToPercentageFormatted should format percentage correctly', () {
      expect(
        "0.1234".intlToPercentageFormatted(decimalDigits: 2),
        contains("12.34%"),
      );
      expect("0.5".intlToPercentageFormatted(), contains("50%"));
      expect("invalid".intlToPercentageFormatted(), equals("invalid"));
    });

    test('intlToCompactFormatted should format numbers in compact form', () {
      expect("1234567".intlToCompactFormatted(), contains("1.2M"));
      expect("1234".intlToCompactFormatted(), contains("1.2K"));
      expect("invalid".intlToCompactFormatted(), equals("invalid"));
    });

    test(
      'intlToCompactLongFormatted should format numbers in compact long form',
      () {
        expect("1234567".intlToCompactLongFormatted(), contains("million"));
        expect("1234".intlToCompactLongFormatted(), contains("thousand"));
        expect("invalid".intlToCompactLongFormatted(), equals("invalid"));
      },
    );

    test('intlToDecimalFormatted should format decimal numbers', () {
      expect(
        "1234.5678".intlToDecimalFormatted(decimalDigits: 2),
        contains("1,234.57"),
      );
      expect(
        "1234.5678".intlToDecimalFormatted(decimalDigits: 0),
        contains("1,235"),
      );
      expect(
        "invalid".intlToDecimalFormatted(decimalDigits: 2),
        equals("invalid"),
      );
    });

    test('intlToScientificFormatted should format in scientific notation', () {
      expect("1234567".intlToScientificFormatted(), contains("E"));
      expect("0.000123".intlToScientificFormatted(), contains("E"));
      expect("invalid".intlToScientificFormatted(), equals("invalid"));
    });

    test('intlToDateFormatted should format dates correctly', () {
      expect(
        "2023-12-25".intlToDateFormatted("yyyy/MM/dd"),
        equals("2023/12/25"),
      );
      expect(
        "2023-12-25".intlToDateFormatted("EEEE, MMMM d, y"),
        contains("Monday"),
      );
      expect("invalid".intlToDateFormatted("yyyy/MM/dd"), equals("invalid"));
    });

    test('intlToLocalizedDateFormatted should format localized dates', () {
      expect("2023-12-25".intlToLocalizedDateFormatted(), contains("Dec"));
      expect("2023-12-25".intlToLocalizedDateFormatted(), contains("25"));
      expect("2023-12-25".intlToLocalizedDateFormatted(), contains("2023"));
      expect("invalid".intlToLocalizedDateFormatted(), equals("invalid"));
    });

    test('intlToFullDateFormatted should format full dates', () {
      expect("2023-12-25".intlToFullDateFormatted(), contains("Monday"));
      expect("2023-12-25".intlToFullDateFormatted(), contains("December"));
      expect("2023-12-25".intlToFullDateFormatted(), contains("25"));
      expect("2023-12-25".intlToFullDateFormatted(), contains("2023"));
      expect("invalid".intlToFullDateFormatted(), equals("invalid"));
    });

    test('intlToTimeFormatted should format time correctly', () {
      expect("2023-12-25T14:30:00".intlToTimeFormatted(), contains("2:30"));
      expect(
        "2023-12-25T14:30:00".intlToTimeFormatted(use24Hour: true),
        contains("14:30"),
      );
      expect("invalid".intlToTimeFormatted(), equals("invalid"));
    });

    test('intlToRelativeTimeFormatted should format relative time', () {
      final now = DateTime.now();
      final twoHoursAgo = now.subtract(Duration(hours: 2)).toIso8601String();
      expect(twoHoursAgo.intlToRelativeTimeFormatted(), contains("hours ago"));

      final oneMinuteAgo = now.subtract(Duration(minutes: 1)).toIso8601String();
      expect(oneMinuteAgo.intlToRelativeTimeFormatted(), contains("minute"));

      expect("invalid".intlToRelativeTimeFormatted(), equals("invalid"));
    });

    test('Persian text processing should work correctly', () {
      expect("سلام  دنيا".standardizePersianText(), equals("سلام دنیا"));
      expect(
        "قیمت: 12500 تومان".convertDigitsToPersian(),
        equals("قیمت: ۱۲۵۰۰ تومان"),
      );
      expect(
        "قیمت: ۱۲۵۰۰ تومان".convertDigitsToEnglish(),
        equals("قیمت: 12500 تومان"),
      );
    });

    test('Iranian national code validation should work', () {
      expect("0123456789".isValidIranianNationalCode(), isTrue);
      expect("1111111111".isValidIranianNationalCode(), isFalse);
      expect("123".isValidIranianNationalCode(), isFalse);
      expect("abcd123456".isValidIranianNationalCode(), isFalse);
    });

    test('Iranian SHEBA validation should work', () {
      expect("IR062960000000100324200001".isValidIranianSheba(), isTrue);
      expect("US062960000000100324200001".isValidIranianSheba(), isFalse);
      expect("IR06296000000010032420000".isValidIranianSheba(), isFalse);
      expect("IR06296000000010032420000a".isValidIranianSheba(), isFalse);
    });
  });
}
