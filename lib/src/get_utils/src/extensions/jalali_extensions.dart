import 'package:shamsi_date/shamsi_date.dart';

extension JalaliExtension on Jalali {
  /// دریافت نام ماه فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String monthName = jalaliDate.getPersianMonthName();
  /// // نتیجه: "مهر"
  ///
  ///
  /// ```
  String getPersianMonthName() {
    final persianMonthNames = ['فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور', 'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'];
    return persianMonthNames[month - 1];
  }

  /// دریافت نام روز فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String dayName = jalaliDate.getPersianDayName();
  /// // نتیجه: "سه‌شنبه"
  ///
  ///
  /// ```
  String getPersianDayName() {
    final persianDayNames = ['شنبه', 'یک‌شنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];
    return persianDayNames[weekDay % 7];
  }

  /// دریافت سال فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String yearString = jalaliDate.getPersianYear();
  /// // نتیجه: "۱۴۰۲"
  ///
  ///
  /// ```
  String getPersianYear() {
    return year.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// دریافت ماه فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String monthString = jalaliDate.getPersianMonth();
  /// // نتیجه: "۰۷"
  ///
  ///
  /// ```
  String getPersianMonth() {
    final monthStr = month.toString().padLeft(2, '0');
    return monthStr.replaceAllMapped(RegExp(r'\d'), (match) {
      final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// دریافت روز فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String dayString = jalaliDate.getPersianDay();
  /// // نتیجه: "۱۸"
  ///
  ///
  /// ```
  String getPersianDay() {
    final dayStr = day.toString().padLeft(2, '0');
    return dayStr.replaceAllMapped(RegExp(r'\d'), (match) {
      final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// تبدیل تاریخ به فرمت کوتاه فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String shortDate = jalaliDate.toShortPersianDate();
  /// // نتیجه: "۱۴۰۲/۰۷/۱۸"
  ///
  ///
  /// ```
  String toShortPersianDate() {
    return '${getPersianYear()}/${getPersianMonth()}/${getPersianDay()}';
  }

  /// تبدیل تاریخ به فرمت کامل فارسی
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// String fullDate = jalaliDate.toFullPersianDate();
  /// // نتیجه: "سه‌شنبه ۱۸ مهر ۱۴۰۲"
  ///
  ///
  /// ```
  String toFullPersianDate() {
    return '${getPersianDayName()} ${getPersianDay()} ${getPersianMonthName()} ${getPersianYear()}';
  }

  /// بررسی اینکه آیا تاریخ در تعطیلات رسمی ایران است
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 1, 1);
  /// bool isHoliday = jalaliDate.isIranianHoliday();
  /// // نتیجه: true (روز اول فروردین)
  ///
  ///
  /// ```
  bool isIranianHoliday() {
    // روزهای جمعه تعطیل هستند
    if (weekDay == 6) return true;

    // تعطیلات ثابت سالانه
    final fixedHolidays = {
      // فروردین
      (1, 1): 'عید نوروز',
      (1, 2): 'عید نوروز',
      (1, 3): 'عید نوروز',
      (1, 4): 'عید نوروز',
      (1, 12): 'روز جمهوری اسلامی',
      (1, 13): 'روز طبیعت',
      // خرداد
      (3, 14): 'رحلت امام خمینی',
      (3, 15): 'قیام 15 خرداد',
      // بهمن
      (11, 22): 'پیروزی انقلاب اسلامی',
      // اسفند
      (12, 29): 'ملی شدن صنعت نفت',
    };

    return fixedHolidays.containsKey((month, day));
    // توجه: تعطیلات متغیر مانند عید فطر، عید قربان و... بر اساس تقویم قمری
    // متغیر هستند و نیاز به محاسبات پیچیده‌تری دارند
  }

  /// بررسی اینکه آیا سال مورد نظر کبیسه است
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1403, 1, 1);
  /// bool isLeap = jalaliDate.isLeapYear();
  /// // بررسی کبیسه بودن سال 1403
  ///
  ///
  /// ```
  bool isLeapYear() {
    return isLeapJalali(year);
  }

  /// بررسی کبیسه بودن سال شمسی
  ///
  /// سال کبیسه است اگر باقی‌مانده تقسیم آن بر ۳۳ یا ۴ برابر ۱ باشد.
  bool isLeapJalali(int year) {
    int remainder = year % 33;
    return remainder == 1 ||
        remainder == 5 ||
        remainder == 9 ||
        remainder == 13 ||
        remainder == 17 ||
        remainder == 22 ||
        remainder == 26 ||
        remainder == 30;
  }

  /// محاسبه فاصله روز تا تاریخ مشخص
  ///
  /// مثال:
  /// ```dart
  /// Jalali jalaliDate = Jalali(1402, 7, 18);
  /// Jalali targetDate = Jalali(1402, 12, 29);
  /// int days = jalaliDate.daysUntil(targetDate);
  /// // تعداد روزهای باقیمانده تا پایان سال
  ///
  ///
  /// ```
  int daysUntil(Jalali targetDate) {
    return targetDate.toDateTime().difference(toDateTime()).inDays;
  }
}
