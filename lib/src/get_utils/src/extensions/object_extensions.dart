import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension ObjectExtension on Object {
  /// Convert a number to Persian digits
  ///
  /// Example:
  /// ```dart
  /// String persianNumber = "123".convertToPersianDigitsForNew();
  /// // Result: "۱۲۳"
  /// ```
  String convertToPersianDigitsForNew(String number) {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// Convert a TimeOfDay to Persian formatted time
  ///
  /// Example:
  /// ```dart
  /// TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
  /// String persianTime = time.convertTimeToPersianForNew();
  /// // Result: "۰۲:۳۰ بعد از ظهر"
  /// ```
  String convertTimeToPersianForNew(TimeOfDay time) {
    final hour =
        time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour < 12 ? 'صبح' : 'بعد از ظهر';
    final persianHour = convertToPersianDigitsForNew(
      hour.toString().padLeft(2, '0'),
    );
    final persianMinute = convertToPersianDigitsForNew(
      time.minute.toString().padLeft(2, '0'),
    );
    return '$persianHour:$persianMinute $period';
  }

  /// Convert an integer to Persian digits
  ///
  /// Example:
  /// ```dart
  /// int number = 123;
  /// String persianNumber = number.convertToPersianDigits();
  /// // Result: "۱۲۳"
  /// ```
  String convertToPersianDigits(int number) {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }

  /// Convert an integer to English digits
  ///
  /// Example:
  /// ```dart
  /// int number = ۱۲۳;
  /// String englishNumber = number.convertToEnglishDigits();
  /// // Result: "123"
  /// ```
  String convertToEnglishDigits(int number) {
    final englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    return number.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      return englishDigits[int.parse(match.group(0)!)];
    });
  }

  /// Convert a TimeOfDay to English formatted time
  ///
  /// Example:
  /// ```dart
  /// TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
  /// String englishTime = time.convertTimeToStringEnglish();
  /// // Result: "02:30 PM"
  /// ```
  String convertTimeToStringEnglish(TimeOfDay time) {
    final hour =
        time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour < 12 ? 'AM' : 'PM';
    final englishHour = hour.toString().padLeft(2, '0');
    final englishMinute = time.minute.toString().padLeft(2, '0');
    return '$englishHour:$englishMinute $period';
  }

  /// Format date and time to 24-hour format and match with Iran's time zone
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// TimeOfDay time = TimeOfDay.now();
  /// String formattedDateTime = dateTime.viewFormatDateTimeFor(time);
  /// // Result: "2023 / 10 / 10 - 02:30 PM"
  /// ```
  String viewFormatDateTimeFor(DateTime dateTime, TimeOfDay time) {
    final formattedTime = convertTimeToStringEnglish(time);
    final formattedDate = dateTime.formatFullDate();
    return '$formattedDate - $formattedTime';
  }

  /// Convert a TimeOfDay to Persian formatted time
  ///
  /// Example:
  /// ```dart
  /// TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
  /// String persianTime = time.convertTimeToPersian();
  /// // Result: "۱۴:۳۰"
  /// ```
  String convertTimeToPersian(TimeOfDay time) {
    final persianHour = convertToPersianDigits(time.hour);
    final persianMinute = convertToPersianDigits(time.minute);
    return '$persianHour:${persianMinute.padLeft(2, '0')}';
  }

  /// Convert a string to TimeOfDay
  ///
  /// Example:
  /// ```dart
  /// String timeString = "02:30 PM";
  /// TimeOfDay time = timeString.stringToTimeOfDay();
  /// // Result: TimeOfDay(hour: 14, minute: 30)
  /// ```
  TimeOfDay stringToTimeOfDay(String timeString) {
    timeString = timeString.trim().toLowerCase();
    List<String> parts = timeString.split(' ');
    String timePart = parts[0];
    String? period = parts.length > 1 ? parts[1] : null;
    List<String> timeComponents = timePart.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);
    if (period != null) {
      if ((period == 'pm') && hour != 12) {
        hour += 12;
      } else if ((period == 'am') && hour == 12) {
        hour = 0;
      }
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Format date and time to 24-hour format and match with Iran's time zone
  ///
  /// Example:
  /// ```dart
  /// Jalali jalaliDate = Jalali.now();
  /// TimeOfDay time = TimeOfDay.now();
  /// String formattedDateTime = jalaliDate.formatDateTimeForIran(time);
  /// // Result: "۱۴۰۲/۰۷/۱۸ - ۱۴:۳۰"
  /// ```
  String formatDateTimeForIran(Jalali jalaliDate, TimeOfDay time) {
    final formattedTime = convertTimeToPersian(time);
    final formattedDate = DateFormat(
      'yyyy/MM/dd',
    ).format(jalaliDate.toDateTime());
    return '$formattedDate - $formattedTime';
  }

  /// Format date and time to 24-hour format and match with Iran's time zone
  ///
  /// Example:
  /// ```dart
  /// Jalali jalaliDate = Jalali.now();
  /// TimeOfDay time = TimeOfDay.now();
  /// String formattedDateTime = jalaliDate.formatDateTimeForIranNew(time);
  /// // Result: "۱۴۰۲/۰۷/۱۸ - ۰۲:۳۰ بعد از ظهر"
  /// ```
  String formatDateTimeForIranNew(Jalali jalaliDate, TimeOfDay time) {
    final formattedTime = convertTimeToPersianForNew(time);
    final formattedDate = DateFormat(
      'yyyy/MM/dd',
    ).format(jalaliDate.toDateTime());
    return '$formattedDate - $formattedTime';
  }

  /// Convert USD to EUR
  ///
  /// Example:
  /// ```dart
  /// double usd = 100;
  /// double eur = usd.convertUsdToEur();
  /// // Result: 85.0 (assuming 1 USD = 0.85 EUR)
  /// ```
  double convertUsdToEur(double usd) {
    const conversionRate = 0.85; // Example conversion rate
    return usd * conversionRate;
  }

  /// Convert EUR to USD
  ///
  /// Example:
  /// ```dart
  /// double eur = 100;
  /// double usd = eur.convertEurToUsd();
  /// // Result: 117.65 (assuming 1 EUR = 1.1765 USD)
  /// ```
  double convertEurToUsd(double eur) {
    const conversionRate = 1.1765; // Example conversion rate
    return eur * conversionRate;
  }

  /// Convert IRR to Toman
  ///
  /// Example:
  /// ```dart
  /// int irr = 10000;
  /// int toman = irr.convertIrrToToman();
  /// // Result: 1000
  /// ```
  int convertIrrToToman(int irr) {
    return irr ~/ 10;
  }

  /// Convert Toman to IRR
  ///
  /// Example:
  /// ```dart
  /// int toman = 1000;
  /// int irr = toman.convertTomanToIrr();
  /// // Result: 10000
  /// ```
  int convertTomanToIrr(int toman) {
    return toman * 10;
  }

  /// Validate Iranian phone number
  ///
  /// Example:
  /// ```dart
  /// String phoneNumber = "09123456789";
  /// bool isValid = phoneNumber.isValidIranianPhoneNumber();
  /// // Result: true
  /// ```
  bool isValidIranianPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^(?:\+98|0)?9\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  /// Convert Gregorian day names to Persian day names
  ///
  /// Example:
  /// ```dart
  /// String dayName = "Saturday";
  /// String persianDayName = dayName.convertGregorianDayToPersian();
  /// // Result: "شنبه"
  /// ```
  String convertGregorianDayToPersian(String dayName) {
    final dayNames = {
      'Saturday': 'شنبه',
      'Sunday': 'یک‌شنبه',
      'Monday': 'دوشنبه',
      'Tuesday': 'سه‌شنبه',
      'Wednesday': 'چهارشنبه',
      'Thursday': 'پنج‌شنبه',
      'Friday': 'جمعه',
    };
    return dayNames[dayName] ?? dayName;
  }

  /// Convert Persian day names to Gregorian day names
  ///
  /// Example:
  /// ```dart
  /// String persianDayName = "شنبه";
  /// String dayName = persianDayName.convertPersianDayToGregorian();
  /// // Result: "Saturday"
  /// ```
  String convertPersianDayToGregorian(String persianDayName) {
    final dayNames = {
      'شنبه': 'Saturday',
      'یک‌شنبه': 'Sunday',
      'دوشنبه': 'Monday',
      'سه‌شنبه': 'Tuesday',
      'چهارشنبه': 'Wednesday',
      'پنج‌شنبه': 'Thursday',
      'جمعه': 'Friday',
    };
    return dayNames[persianDayName] ?? persianDayName;
  }
}

extension DateTimeExtension on DateTime {
  /// Format the DateTime to a full date with day name
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// String formattedDate = dateTime.formatFullDateWithDay();
  /// // Result: "Saturday 10 October 23"
  /// ```
  String formatFullDateWithDay() {
    final englishDayNames = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];
    final englishMonthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final dayOfWeek = weekday % 7;
    final f = NumberFormat("00", "en");
    return '${englishDayNames[dayOfWeek]} ${f.format(day)} ${englishMonthNames[month - 1]} ${f.format(year % 100)}';
  }

  /// Format the DateTime to a full date
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// String formattedDate = dateTime.formatFullDate();
  /// // Result: "2023 / 10 / 10"
  /// ```
  String formatFullDate() {
    final f = NumberFormat("00", "en");
    return '${f.format(year)} / ${f.format(month)} / ${f.format(day)}';
  }

  /// Format the DateTime to a full Persian date with day name
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// String formattedDate = dateTime.formatPersianFullDateWithDay();
  /// // Result: "شنبه ۱۸ مهر ۱۴۰۲"
  /// ```
  String formatPersianFullDateWithDay() {
    final persianDayNames = [
      'شنبه',
      'یک‌شنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنج‌شنبه',
      'جمعه',
    ];
    final persianMonthNames = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    final dayOfWeek = weekday % 7;
    final f = NumberFormat("00", "fa");
    return '${persianDayNames[dayOfWeek]} ${f.format(day)} ${persianMonthNames[month - 1]} ${f.format(year % 100)}';
  }

  /// دریافت نام ماه فارسی
  ///
  /// مثال:
  /// ```dart
  /// DateTime dateTime = DateTime(2023, 6, 18);
  /// String monthName = dateTime.getPersianMonthName();
  /// // نتیجه: "خرداد"
  ///
  ///
  /// ```
  String getPersianMonthName() {
    final persianMonthNames = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    // تبدیل ماه میلادی به ماه شمسی
    Jalali jalaliDate = Jalali.fromDateTime(this);
    return persianMonthNames[jalaliDate.month - 1];
  }

  /// دریافت نام روز فارسی
  ///
  /// مثال:
  /// ```dart
  /// DateTime dateTime = DateTime(2023, 6, 18);
  /// String dayName = dateTime.getPersianDayName();
  /// // نتیجه: "دوشنبه"
  ///
  ///
  /// ```
  String getPersianDayName() {
    final persianDayNames = [
      'شنبه',
      'یک‌شنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنج‌شنبه',
      'جمعه',
    ];
    return persianDayNames[weekday % 7];
  }

  /// دریافت سال فارسی
  ///
  /// مثال:
  /// ```dart
  /// DateTime dateTime = DateTime(2023, 6, 18);
  /// String yearString = dateTime.getPersianYear();
  /// // نتیجه: "۱۴۰۲"
  ///
  ///
  /// ```
  String getPersianYear() {
    Jalali jalaliDate = Jalali.fromDateTime(this);
    return jalaliDate.year.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
      return persianDigits[int.parse(match.group(0)!)];
    });
  }
}
