# Get_utils AND Extensions

  
## Equality Mixin

The `Equality` mixin provides a simple way to implement equality checks and hashing for Dart classes. It is particularly useful for value objects where equality is based on a list of properties.

## Features
- **Automatic Equality Checks**: Implements `==` operator for comparing objects based on their properties.
- **Hashing**: Generates a hash code based on the runtime type and properties of the object.
- **Deep Equality**: Uses `DeepCollectionEquality` to compare properties that are collections (e.g., lists, maps, sets).

## Code

```dart
mixin Equality {
  List get props;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || 
           runtimeType == other.runtimeType && 
           other is Equality && 
           const DeepCollectionEquality().equals(props, other.props);
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(props);
  }
}
```

## Example Usage

Here’s an example of how to use the `Equality` mixin in a class:

```dart
class Person with Equality {
  final String name;
  final int age;
  final List<String> hobbies;

  Person(this.name, this.age, this.hobbies);

  @override
  List<Object?> get props => [name, age, hobbies];
}

void main() {
  final person1 = Person('Alice', 30, ['Reading', 'Swimming']);
  final person2 = Person('Alice', 30, ['Reading', 'Swimming']);
  final person3 = Person('Bob', 25, ['Gaming']);

  print(person1 == person2); // true (same properties)
  print(person1 == person3); // false (different properties)
  print(person1.hashCode == person2.hashCode); // true (same hash code)
  print(person1.hashCode == person3.hashCode); // false (different hash code)
}
```

---

This example demonstrates how the `Equality` mixin can be used to compare objects and generate hash codes based on their properties.



# ContextExt Extension

The `ContextExt` extension provides a collection of utility methods and properties for `BuildContext` in Flutter. These utilities simplify common tasks such as accessing screen dimensions, checking device orientation, and implementing responsive design.

---

## Features and Examples

### 1. **Screen Dimensions**
   - **`mediaQuerySize`**: Get the size of the screen.
     ```dart
     Size screenSize = context.mediaQuerySize;
     print('Screen Size: $screenSize');
     ```
   - **`height`**: Get the height of the screen.
     ```dart
     double screenHeight = context.height;
     print('Screen Height: $screenHeight');
     ```
   - **`width`**: Get the width of the screen.
     ```dart
     double screenWidth = context.width;
     print('Screen Width: $screenWidth');
     ```

---

### 2. **Responsive Design**
   - **`heightTransformer`**: Get a portion of the screen height.
     ```dart
     double halfHeight = context.heightTransformer(dividedBy: 2);
     print('Half Height: $halfHeight');
     ```
   - **`widthTransformer`**: Get a portion of the screen width.
     ```dart
     double thirdWidth = context.widthTransformer(dividedBy: 3);
     print('One Third Width: $thirdWidth');
     ```
   - **`ratio`**: Calculate the ratio of height to width.
     ```dart
     double aspectRatio = context.ratio(dividedBy: 2);
     print('Aspect Ratio: $aspectRatio');
     ```

---

### 3. **Theme and MediaQuery Access**
   - **`theme`**: Access the current theme.
     ```dart
     ThemeData appTheme = context.theme;
     print('Primary Color: ${appTheme.primaryColor}');
     ```
   - **`isDarkMode`**: Check if dark mode is enabled.
     ```dart
     bool darkMode = context.isDarkMode;
     print('Dark Mode: $darkMode');
     ```
   - **`iconColor`**: Get the icon color from the theme.
     ```dart
     Color? iconColor = context.iconColor;
     print('Icon Color: $iconColor');
     ```
   - **`textTheme`**: Access the text theme.
     ```dart
     TextTheme textStyles = context.textTheme;
     print('Headline Style: ${textStyles.headlineSmall}');
     ```

---

### 4. **Device Orientation**
   - **`orientation`**: Get the device orientation.
     ```dart
     Orientation deviceOrientation = context.orientation;
     print('Orientation: $deviceOrientation');
     ```
   - **`isLandscape`**: Check if the device is in landscape mode.
     ```dart
     bool landscape = context.isLandscape;
     print('Is Landscape: $landscape');
     ```
   - **`isPortrait`**: Check if the device is in portrait mode.
     ```dart
     bool portrait = context.isPortrait;
     print('Is Portrait: $portrait');
     ```

---

### 5. **Device Type Detection**
   - **`isPhone`**: Check if the device is a phone.
     ```dart
     bool isPhone = context.isPhone;
     print('Is Phone: $isPhone');
     ```
   - **`isTablet`**: Check if the device is a tablet.
     ```dart
     bool isTablet = context.isTablet;
     print('Is Tablet: $isTablet');
     ```
   - **`isDesktop`**: Check if the device is a desktop.
     ```dart
     bool isDesktop = context.isDesktop;
     print('Is Desktop: $isDesktop');
     ```

---

### 6. **Responsive Value**
   - **`responsiveValue`**: Return a value based on the screen size.
     ```dart
     String layout = context.responsiveValue(
       mobile: 'Mobile Layout',
       tablet: 'Tablet Layout',
       desktop: 'Desktop Layout',
     );
     print('Layout: $layout');
     ```

---

### 7. **Iterable Extension**
   - **`firstOrNull`**: Get the first element of an iterable or `null` if empty.
     ```dart
     List<int> numbers = [];
     int? firstNumber = numbers.firstOrNull;
     print('First Number: $firstNumber'); // null
     ```


This documentation provides a clear breakdown of each feature with practical examples. 



# DoubleExt Extension

The `DoubleExt` extension provides utility methods for working with `double` values in Dart. It includes features for rounding numbers to a specific precision and converting doubles to `Duration` objects in various units (milliseconds, seconds, minutes, hours, and days).

---

## Features and Examples

### 1. **Rounding to Precision**
   - **`toPrecision`**: Rounds a double to a specified number of decimal places.
     ```dart
     double value = 3.14159;
     double roundedValue = value.toPrecision(2); // Result: 3.14
     ```

---

### 2. **Duration Conversion**
   - **`milliseconds`**: Converts a double to a `Duration` in milliseconds.
     ```dart
     Duration duration = 1.5.milliseconds; // Result: Duration(milliseconds: 1)
     ```
   - **`ms`**: Alias for `milliseconds`.
     ```dart
     Duration duration = 1.5.ms; // Result: Duration(milliseconds: 1)
     ```
   - **`seconds`**: Converts a double to a `Duration` in seconds.
     ```dart
     Duration duration = 1.5.seconds; // Result: Duration(seconds: 1)
     ```
   - **`minutes`**: Converts a double to a `Duration` in minutes.
     ```dart
     Duration duration = 1.5.minutes; // Result: Duration(minutes: 1)
     ```
   - **`hours`**: Converts a double to a `Duration` in hours.
     ```dart
     Duration duration = 1.5.hours; // Result: Duration(hours: 1)
     ```
   - **`days`**: Converts a double to a `Duration` in days.
     ```dart
     Duration duration = 1.5.days; // Result: Duration(days: 1)
     ```

---

This extension simplifies working with `double` values, especially when converting them to `Duration` objects or rounding them to a specific precision. 

---

# GetDurationUtils Extension

The `GetDurationUtils` extension provides a utility method for delaying code execution or executing a callback after a specified `Duration`. This is particularly useful for adding delays in asynchronous operations.

---

## Features and Examples

### 1. **Delay Execution**
   - **`delay`**: Delays code execution or executes a callback after the specified `Duration`.
     ```dart
     void main() async {
       final _delay = 3.seconds;
       print('+ wait $_delay');
       await _delay.delay(); // Waits for 3 seconds
       print('- finish wait $_delay');
       print('+ callback in 700ms');
       await 0.7.seconds.delay(() {
         print('- callback executed after 700ms');
       });
     }
     ```



# GetDynamicUtils Extension

The `GetDynamicUtils` extension provides utility methods for working with dynamic types in Dart. It includes features for checking if a value is blank and logging error or informational messages.



## Features and Examples

### 1. **Blank Check**
   - **`isBlank`**: Checks if the value is blank (null, empty, or only contains whitespace).
     ```dart
     dynamic value = '';
     print(value.isBlank); // true
     ```



### 2. **Error Logging**
   - **`printError`**: Logs an error message with the runtime type of the value.
     ```dart
     dynamic value = 'some error';
     value.printError(info: 'An error occurred');
     // Output: Error: String, some error, An error occurred
     ```



### 3. **Informational Logging**
   - **`printInfo`**: Logs an informational message with the runtime type of the value.
     ```dart
     dynamic value = 'some info';
     value.printInfo(info: 'Some information');
     // Output: Info: String, some info, Some information
     ```



This extension simplifies working with dynamic types by providing utilities for checking blank values and logging messages. 



# LoopEventsExt Extension

The `LoopEventsExt` extension provides utility methods for scheduling computations in the event loop. It is designed to work with `GetInterface` and allows you to control when a computation is executed, either at the end of the event loop or as soon as possible.

---

## Features and Examples

### 1. **Schedule Computation at the End of the Event Loop**
   - **`toEnd`**: Schedules the computation to run at the end of the event loop.
     ```dart
     GetInterface instance = Get.find();
     instance.toEnd(() async {
       print('This will run at the end of the event loop.');
     });
     ```

---

### 2. **Schedule Computation as Soon as Possible**
   - **`asap`**: Schedules the computation to run as soon as possible, optionally based on a condition.
     ```dart
     GetInterface instance = Get.find();
     instance.asap(() {
       print('This will run as soon as possible.');
     }, condition: () => true);
     ```

---

This extension simplifies managing event loop operations, making it easier to control the timing of computations in your application.




# Int Extension

The `DurationExt` extension provides utility methods for converting integers to `Duration` objects in various units (seconds, minutes, hours, days, milliseconds, and microseconds). It also includes a method for formatting integers with comma-separated thousands.

---

## Features and Examples

### 1. **Duration Conversion**
   - **`seconds`**: Converts an integer to a `Duration` in seconds.
     ```dart
     Duration duration = 5.seconds; // Result: Duration(seconds: 5)
     ```
   - **`days`**: Converts an integer to a `Duration` in days.
     ```dart
     Duration duration = 2.days; // Result: Duration(days: 2)
     ```
   - **`hours`**: Converts an integer to a `Duration` in hours.
     ```dart
     Duration duration = 3.hours; // Result: Duration(hours: 3)
     ```
   - **`minutes`**: Converts an integer to a `Duration` in minutes.
     ```dart
     Duration duration = 45.minutes; // Result: Duration(minutes: 45)
     ```
   - **`milliseconds`**: Converts an integer to a `Duration` in milliseconds.
     ```dart
     Duration duration = 500.milliseconds; // Result: Duration(milliseconds: 500)
     ```
   - **`microseconds`**: Converts an integer to a `Duration` in microseconds.
     ```dart
     Duration duration = 1000.microseconds; // Result: Duration(microseconds: 1000)
     ```
   - **`ms`**: Alias for `milliseconds`.
     ```dart
     Duration duration = 500.ms; // Result: Duration(milliseconds: 500)
     ```

---

### 2. **Number Formatting**
   - **`toFormattedNumber`**: Formats the integer with comma-separated thousands.
     ```dart
     String formattedNumber = 1234567.toFormattedNumber(); // Result: "1,234,567"
     ```

---

This extension simplifies working with integers by providing easy-to-use methods for converting them to `Duration` objects and formatting them for display. 




# LocalesIntl Extension

The `LocalesIntl` extension provides utilities for managing locales and translations in a Flutter application. It allows you to set the current locale, fallback locale, and manage translation maps.

---

## Features and Examples

### 1. **Locale Management**
   - **`locale`**: Gets or sets the current locale.
     ```dart
     Get.locale = Locale('en', 'US');
     print(Get.locale); // Locale('en', 'US')
     ```
   - **`fallbackLocale`**: Gets or sets the fallback locale.
     ```dart
     Get.fallbackLocale = Locale('es', 'ES');
     print(Get.fallbackLocale); // Locale('es', 'ES')
     ```

---

### 2. **Translation Management**
   - **`translations`**: Gets the current translation map.
     ```dart
     print(Get.translations);
     ```
   - **`addTranslations`**: Adds a new translation map.
     ```dart
     Get.addTranslations({
       'en_US': {'hello': 'Hello'},
       'es_ES': {'hello': 'Hola'},
     });
     ```
   - **`clearTranslations`**: Clears all translations.
     ```dart
     Get.clearTranslations();
     ```
   - **`appendTranslations`**: Appends translations to the existing map.
     ```dart
     Get.appendTranslations({
       'fr_FR': {'hello': 'Bonjour'},
     });
     ```

---

# Trans Extension

The `Trans` extension provides methods for translating strings based on the current locale. It supports arguments, pluralization, and parameters.

---

## Features and Examples

### 1. **Basic Translation**
   - **`tr`**: Translates a string based on the current locale.
     ```dart
     String greeting = 'hello'.tr; // Returns 'Hello' if locale is 'en_US'
     ```

---

### 2. **Translation with Arguments**
   - **`trArgs`**: Translates a string and replaces placeholders with arguments.
     ```dart
     String message = 'welcome %s'.trArgs(['John']); // Returns 'Welcome John'
     ```

---

### 3. **Pluralization**
   - **`trPlural`**: Translates a string based on pluralization rules.
     ```dart
     String apples = 'apple'.trPlural('apples', 3); // Returns 'apples' if i > 1
     ```

---

### 4. **Translation with Parameters**
   - **`trParams`**: Translates a string and replaces placeholders with parameters.
     ```dart
     String message = 'hello @name'.trParams({'name': 'John'}); // Returns 'Hello John'
     ```

---

### 5. **Pluralization with Parameters**
   - **`trPluralParams`**: Translates a string based on pluralization rules and replaces placeholders with parameters.
     ```dart
     String apples = 'apple'.trPluralParams('apples', 3, {'count': '3'}); // Returns '3 apples'
     ```

---

## Example Usage

```dart
void main() {
  Get.locale = Locale('en', 'US');
  Get.addTranslations({
    'en_US': {
      'hello': 'Hello',
      'welcome %s': 'Welcome %s',
      'apple': 'apple',
      'apples': 'apples',
      'hello @name': 'Hello @name',
    },
  });

  print('hello'.tr); // Hello
  print('welcome %s'.trArgs(['John'])); // Welcome John
  print('apple'.trPlural('apples', 3)); // apples
  print('hello @name'.trParams({'name': 'John'})); // Hello John
  print('apple'.trPluralParams('apples', 3, {'count': '3'})); // 3 apples
}
```

---

This documentation provides a clear breakdown of the `LocalesIntl` and `Trans` extensions, along with practical examples. 



# IterableExtensions Extension

The `IterableExtensions` extension provides utility methods for working with iterables in Dart. It includes a method for mapping each element of an iterable to another iterable and flattening the result.

---

## Features and Examples

### 1. **Map and Flatten**
   - **`mapMany`**: Maps each element of the iterable to an iterable and flattens the result.
     ```dart
     List<int> numbers = [1, 2, 3];
     List<int> result = numbers.mapMany((n) => [n, n * 2]).toList();
     // Result: [1, 2, 2, 4, 3, 6]
     ```

---

This extension simplifies working with iterables by providing a method to map and flatten elements in a single operation.




# GetNumUtils Extension

The `GetNumUtils` extension provides utility methods for working with numerical values (`num` type) in Dart. It includes methods for comparing numbers and delaying code execution.

---

## Features and Examples

### 1. **Number Comparison**
   - **`isLowerThan`**: Checks if the number is lower than another number.
     ```dart
     bool result = 5.isLowerThan(10); // Result: true
     ```
   - **`isGreaterThan`**: Checks if the number is greater than another number.
     ```dart
     bool result = 10.isGreaterThan(5); // Result: true
     ```
   - **`isEqual`**: Checks if the number is equal to another number.
     ```dart
     bool result = 5.isEqual(5); // Result: true
     ```

---

### 2. **Delay Execution**
   - **`delay`**: Delays code execution or executes a callback after the specified duration (in seconds).
     ```dart
     void main() async {
       print('+ wait for 2 seconds');
       await 2.delay(); // Waits for 2 seconds
       print('- 2 seconds completed');
       print('+ callback in 1.2sec');
       1.delay(() => print('- 1.2sec callback called')); // Executes callback after 1.2 seconds
       print('currently running callback 1.2sec');
     }
     ```

---

This extension simplifies working with numerical values by providing methods for comparisons and delaying code execution.




# ObjectExtension

The `DefaultExtension` extension provides utility methods for working with numbers, dates, times, and strings in Persian and English formats. It also includes methods for currency conversion and validation.

---

## Features and Examples

### 1. **Number Conversion**
   - **`convertToPersianDigitsForNew`**: Converts a number to Persian digits.
     ```dart
     String persianNumber = "123".convertToPersianDigitsForNew("123"); // Result: "۱۲۳"
     ```
   - **`convertToPersianDigits`**: Converts an integer to Persian digits.
     ```dart
     String persianNumber = 123.convertToPersianDigits(); // Result: "۱۲۳"
     ```
   - **`convertToEnglishDigits`**: Converts an integer to English digits.
     ```dart
     String englishNumber = ۱۲۳.convertToEnglishDigits(); // Result: "123"
     ```

---

### 2. **Time Conversion**
   - **`convertTimeToPersianForNew`**: Converts a `TimeOfDay` to Persian formatted time.
     ```dart
     TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
     String persianTime = time.convertTimeToPersianForNew(); // Result: "۰۲:۳۰ بعد از ظهر"
     ```
   - **`convertTimeToStringEnglish`**: Converts a `TimeOfDay` to English formatted time.
     ```dart
     TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
     String englishTime = time.convertTimeToStringEnglish(); // Result: "02:30 PM"
     ```
   - **`convertTimeToPersian`**: Converts a `TimeOfDay` to Persian formatted time.
     ```dart
     TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
     String persianTime = time.convertTimeToPersian(); // Result: "۱۴:۳۰"
     ```
   - **`stringToTimeOfDay`**: Converts a string to `TimeOfDay`.
     ```dart
     String timeString = "02:30 PM";
     TimeOfDay time = timeString.stringToTimeOfDay(); // Result: TimeOfDay(hour: 14, minute: 30)
     ```

---

### 3. **Date and Time Formatting**
   - **`viewFormatDateTimeFor`**: Formats a `DateTime` and `TimeOfDay` to a 24-hour format.
     ```dart
     DateTime dateTime = DateTime.now();
     TimeOfDay time = TimeOfDay.now();
     String formattedDateTime = dateTime.viewFormatDateTimeFor(time); // Result: "2023 / 10 / 10 - 02:30 PM"
     ```
   - **`formatDateTimeForIran`**: Formats a `Jalali` date and `TimeOfDay` for Iran's time zone.
     ```dart
     Jalali jalaliDate = Jalali.now();
     TimeOfDay time = TimeOfDay.now();
     String formattedDateTime = jalaliDate.formatDateTimeForIran(time); // Result: "۱۴۰۲/۰۷/۱۸ - ۱۴:۳۰"
     ```
   - **`formatDateTimeForIranNew`**: Formats a `Jalali` date and `TimeOfDay` for Iran's time zone with Persian time format.
     ```dart
     Jalali jalaliDate = Jalali.now();
     TimeOfDay time = TimeOfDay.now();
     String formattedDateTime = jalaliDate.formatDateTimeForIranNew(time); // Result: "۱۴۰۲/۰۷/۱۸ - ۰۲:۳۰ بعد از ظهر"
     ```

---

### 4. **Currency Conversion**
   - **`convertUsdToEur`**: Converts USD to EUR.
     ```dart
     double usd = 100;
     double eur = usd.convertUsdToEur(); // Result: 85.0 (assuming 1 USD = 0.85 EUR)
     ```
   - **`convertEurToUsd`**: Converts EUR to USD.
     ```dart
     double eur = 100;
     double usd = eur.convertEurToUsd(); // Result: 117.65 (assuming 1 EUR = 1.1765 USD)
     ```
   - **`convertIrrToToman`**: Converts IRR to Toman.
     ```dart
     int irr = 10000;
     int toman = irr.convertIrrToToman(); // Result: 1000
     ```
   - **`convertTomanToIrr`**: Converts Toman to IRR.
     ```dart
     int toman = 1000;
     int irr = toman.convertTomanToIrr(); // Result: 10000
     ```

---

### 5. **Validation**
   - **`isValidIranianPhoneNumber`**: Validates an Iranian phone number.
     ```dart
     String phoneNumber = "09123456789";
     bool isValid = phoneNumber.isValidIranianPhoneNumber(); // Result: true
     ```

---

### 6. **Day Name Conversion**
   - **`convertGregorianDayToPersian`**: Converts Gregorian day names to Persian day names.
     ```dart
     String dayName = "Saturday";
     String persianDayName = dayName.convertGregorianDayToPersian(); // Result: "شنبه"
     ```
   - **`convertPersianDayToGregorian`**: Converts Persian day names to Gregorian day names.
     ```dart
     String persianDayName = "شنبه";
     String dayName = persianDayName.convertPersianDayToGregorian(); // Result: "Saturday"
     ```

---

# DateTimeExtension

The `DateTimeExtension` extension provides utility methods for formatting `DateTime` objects in both Gregorian and Persian formats.

---

## Features and Examples

### 1. **Gregorian Date Formatting**
   - **`formatFullDateWithDay`**: Formats a `DateTime` to a full date with the day name.
     ```dart
     DateTime dateTime = DateTime.now();
     String formattedDate = dateTime.formatFullDateWithDay(); // Result: "Saturday 10 October 23"
     ```
   - **`formatFullDate`**: Formats a `DateTime` to a full date.
     ```dart
     DateTime dateTime = DateTime.now();
     String formattedDate = dateTime.formatFullDate(); // Result: "2023 / 10 / 10"
     ```

---

### 2. **Persian Date Formatting**
   - **`formatPersianFullDateWithDay`**: Formats a `DateTime` to a full Persian date with the day name.
     ```dart
     DateTime dateTime = DateTime.now();
     String formattedDate = dateTime.formatPersianFullDateWithDay(); // Result: "شنبه ۱۸ مهر ۱۴۰۲"
     ```

---

This documentation provides a comprehensive breakdown of the `DefaultExtension` and `DateTimeExtension` extensions, along with practical examples.




# String Extension


### **1. String Validation**
The extension includes methods to validate the content of a string, such as:
- **`isNum`**: Checks if the string is a valid number.
- **`isNumericOnly`**: Checks if the string contains only numeric characters.
- **`isAlphabetOnly`**: Checks if the string contains only alphabetic characters.
- **`isBool`**: Checks if the string represents a boolean value (`true` or `false`).
- **`isURL`**: Checks if the string is a valid URL.
- **`isEmail`**: Checks if the string is a valid email address.
- **`isPhoneNumber`**: Checks if the string is a valid phone number.
- **`isDateTime`**: Checks if the string represents a valid date and time.
- **`isMD5`**, **`isSHA1`**, **`isSHA256`**: Checks if the string is a valid hash of the respective type.
- **`isBinary`**: Checks if the string is a valid binary number.
- **`isIPv4`**, **`isIPv6`**: Checks if the string is a valid IP address (IPv4 or IPv6).
- **`isHexadecimal`**: Checks if the string is a valid hexadecimal number.
- **`isPalindrome`**: Checks if the string is a palindrome.
- **`isPassport`**: Checks if the string is a valid passport number.
- **`isCurrency`**: Checks if the string represents a valid currency value.
- **`isCpf`**, **`isCnpj`**: Checks if the string is a valid CPF or CNPJ number (Brazilian identification numbers).

---

### **2. String Manipulation**
The extension provides methods to manipulate strings, such as:
- **`numericOnly`**: Extracts only numeric characters from the string.
- **`capitalize`**: Capitalizes the first letter of the string.
- **`capitalizeFirst`**: Capitalizes the first letter of each word in the string.
- **`removeAllWhitespace`**: Removes all whitespace from the string.
- **`camelCase`**: Converts the string to camel case.
- **`paramCase`**: Converts the string to param case (kebab case).
- **`createPath`**: Creates a path by appending segments to the string.
- **`capitalizeAllWordsFirstLetter`**: Capitalizes the first letter of each word in the string.
- **`reversed`**: Reverses the string.
- **`titleCase`**: Converts the string to title case.

---

### **3. File Type Validation**
The extension includes methods to check if a string represents a specific file type, such as:
- **`isVectorFileName`**: Checks if the string is a vector file name (e.g., `.svg`).
- **`isImageFileName`**: Checks if the string is an image file name (e.g., `.png`, `.jpg`).
- **`isAudioFileName`**: Checks if the string is an audio file name (e.g., `.mp3`).
- **`isVideoFileName`**: Checks if the string is a video file name (e.g., `.mp4`).
- **`isTxtFileName`**: Checks if the string is a text file name (e.g., `.txt`).
- **`isDocumentFileName`**: Checks if the string is a Word document file name (e.g., `.docx`).
- **`isExcelFileName`**: Checks if the string is an Excel file name (e.g., `.xlsx`).
- **`isPPTFileName`**: Checks if the string is a PowerPoint file name (e.g., `.pptx`).
- **`isAPKFileName`**: Checks if the string is an APK file name (e.g., `.apk`).
- **`isPDFFileName`**: Checks if the string is a PDF file name (e.g., `.pdf`).
- **`isHTMLFileName`**: Checks if the string is an HTML file name (e.g., `.html`).

---

### **4. Case-Insensitive Operations**
The extension includes methods for case-insensitive string operations:
- **`isCaseInsensitiveContains`**: Checks if the string contains another string, ignoring case.
- **`isCaseInsensitiveContainsAny`**: Checks if the string contains any of the specified strings, ignoring case.

---

### **5. Number Formatting**
The extension provides methods to format strings as numbers:
- **`toNumberFormatted`**: Formats the string as a number with commas (e.g., `1,234,567`).
- **`toDoubleFormatted`**: Formats the string as a double with two decimal places (e.g., `1,234.57`).

---

### **6. Additional Utilities**
- **`isNullOrEmpty`**: Checks if the string is null or empty.
- **`titleCase`**: Converts the string to title case (capitalizes the first letter of each word).

---

### **Example Usage**
Here are some examples of how to use the extension:

```dart
void main() {
  // Check if a string is a valid number
  print("123".isNum); // true

  // Extract numeric characters
  print("abc123".numericOnly()); // "123"

  // Check if a string is a valid email
  print("example@example.com".isEmail); // true

  // Capitalize the first letter of a string
  print("hello".capitalize); // "Hello"

  // Format a string as a number
  print("1234567".toNumberFormatted()); // "1,234,567"

  // Check if a string is a palindrome
  print("madam".isPalindrome); // true
}
```

---


This extension is a powerful tool for working with strings in Dart, providing a wide range of functionality for validation, manipulation, and formatting.


# Widget Extension:

---

### **1. Padding Utilities**
The extension includes methods to apply padding to a widget:
- **`paddingAll`**: Applies equal padding on all sides.
- **`paddingSymmetric`**: Applies horizontal and vertical padding.
- **`paddingOnly`**: Applies padding only on specified sides.
- **`paddingZero`**: Applies zero padding.

**Example:**
```dart
Widget myWidget = Text("Hello").paddingAll(8.0);
Widget myWidget2 = Text("Hello").paddingSymmetric(horizontal: 8.0, vertical: 16.0);
Widget myWidget3 = Text("Hello").paddingOnly(left: 8.0, top: 16.0);
Widget myWidget4 = Text("Hello").paddingZero;
```

---

### **2. Margin Utilities**
The extension includes methods to apply margin to a widget:
- **`marginAll`**: Applies equal margin on all sides.
- **`marginSymmetric`**: Applies horizontal and vertical margin.
- **`marginOnly`**: Applies margin only on specified sides.
- **`marginZero`**: Applies zero margin.

**Example:**
```dart
Widget myWidget = Text("Hello").marginAll(8.0);
Widget myWidget2 = Text("Hello").marginSymmetric(horizontal: 8.0, vertical: 16.0);
Widget myWidget3 = Text("Hello").marginOnly(left: 8.0, top: 16.0);
Widget myWidget4 = Text("Hello").marginZero;
```

---

### **3. Background Color**
The extension includes a method to set a background color for a widget with optional opacity:
- **`backgroundColor`**: Sets the background color and opacity.

**Example:**
```dart
Widget myWidget = Text("Hello").backgroundColor(Colors.red, opacity: 0.5);
```

---

### **4. Visibility**
The extension includes a method to conditionally display a widget:
- **`visible`**: Shows or hides the widget based on a boolean flag.

**Example:**
```dart
Widget myWidget = Text("Hello").visible(true);
```

---

### **5. Transformations**
The extension includes methods to apply transformations to a widget:
- **`rotate`**: Rotates the widget by a specified number of degrees.
- **`scale`**: Scales the widget by a specified factor.

**Example:**
```dart
Widget myWidget = Text("Hello").rotate(45);
Widget myWidget2 = Text("Hello").scale(1.5);
```

---

### **6. Number Formatting**
The extension includes a method to format an integer with comma-separated thousands:
- **`toNumberFormat`**: Formats an integer as a string with commas.

**Example:**
```dart
String formattedNumber = widget.toNumberFormat(1234567); // Result: "1,234,567"
```

---

### **7. Border**
The extension includes a method to add a border to a widget:
- **`withBorder`**: Adds a border with customizable color and width.

**Example:**
```dart
Widget myWidget = Text("Hello").withBorder(color: Colors.red, width: 2.0);
```

---

### **8. Sliver Conversion**
The extension includes methods to convert a widget to a `Sliver`:
- **`sliverBox`**: Converts the widget to a `SliverToBoxAdapter`.
- **`sliverBoxWithKey`**: Converts the widget to a `SliverToBoxAdapter` with a specified key.

**Example:**
```dart
Widget myWidget = Text("Hello").sliverBox;
Widget myWidget2 = Text("Hello").sliverBoxWithKey(Key("myKey"));
```

---

### **9. Responsive Sizing and Alignment**
The extension includes methods for responsive sizing and alignment:
- **`expand`**: Wraps the widget in an `Expanded` widget with a specified flex factor.
- **`centered`**: Centers the widget with optional control over horizontal and vertical alignment.

**Example:**
```dart
Widget myWidget = Text("Hello").expand(flex: 2);
Widget myWidget2 = Text("Hello").centered(horizontal: true, vertical: false);
```

---

### **Full Example Usage**
Here’s an example of how to use the extension in a Flutter app:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Widget Extensions Example")),
        body: Center(
          child: Column(
            children: [
              Text("Hello").paddingAll(16.0).backgroundColor(Colors.blue, opacity: 0.5),
              SizedBox(height: 16),
              Text("Hello").marginSymmetric(horizontal: 8.0, vertical: 16.0).withBorder(color: Colors.red, width: 2.0),
              SizedBox(height: 16),
              Text("Hello").rotate(45).visible(true),
              SizedBox(height: 16),
              Text("Formatted Number: ${widget.toNumberFormat(1234567)}"),
              SizedBox(height: 16),
              Text("Hello").sliverBox,
            ],
          ),
        ),
      ),
    );
  }
}
```


This extension is a powerful tool for simplifying widget manipulation in Flutter, making it easier to apply common transformations, padding, margin, and other utilities with minimal code.



# GetPlatform


The provided code defines a utility class called `GetPlatform` that helps determine the platform on which a Dart or Flutter application is running. It supports checking for various platforms, including web, macOS, Windows, Linux, Android, iOS, and Fuchsia. The class uses conditional imports to load platform-specific implementations from different files (`platform_stub.dart`, `platform_web.dart`, and `platform_io.dart`).

Below is a detailed explanation of the code and its functionality:

---

### **Key Features**
1. **Platform Detection**:
   - The class provides static getters to check if the application is running on a specific platform (e.g., `isWeb`, `isMacOS`, `isWindows`, etc.).
   - It also includes composite getters like `isMobile` and `isDesktop` to check for broader categories of platforms.

2. **Conditional Imports**:
   - The code uses conditional imports to load platform-specific implementations:
     - `platform_stub.dart`: A stub implementation (default).
     - `platform_web.dart`: Implementation for web platforms (imported when `dart.library.js_interop` is available).
     - `platform_io.dart`: Implementation for non-web platforms (imported when `dart.library.io` is available).

3. **GeneralPlatform**:
   - The `GeneralPlatform` class (not shown in the code) is assumed to be defined in the imported files (`platform_web.dart` and `platform_io.dart`). It provides the actual platform detection logic.

---

### **Static Getters**
The `GetPlatform` class includes the following static getters:

1. **`isWeb`**:
   - Returns `true` if the application is running on the web.

2. **`isMacOS`**:
   - Returns `true` if the application is running on macOS.

3. **`isWindows`**:
   - Returns `true` if the application is running on Windows.

4. **`isLinux`**:
   - Returns `true` if the application is running on Linux.

5. **`isAndroid`**:
   - Returns `true` if the application is running on Android.

6. **`isIOS`**:
   - Returns `true` if the application is running on iOS.

7. **`isFuchsia`**:
   - Returns `true` if the application is running on Fuchsia.

8. **`isMobile`**:
   - Returns `true` if the application is running on a mobile platform (iOS or Android).

9. **`isDesktop`**:
   - Returns `true` if the application is running on a desktop platform (macOS, Windows, or Linux).

---

### **Example Usage**
Here’s how you can use the `GetPlatform` class in your application:

```dart
void main() {
  if (GetPlatform.isWeb) {
    print("Running on the web!");
  } else if (GetPlatform.isMobile) {
    print("Running on a mobile device!");
  } else if (GetPlatform.isDesktop) {
    print("Running on a desktop platform!");
  } else {
    print("Unknown platform!");
  }
}
```

---

### **Implementation Files**
The actual platform detection logic is implemented in the following files:

1. **`platform_stub.dart`**:
   - This is the default stub implementation, which is used when no specific platform is detected.
   - It typically returns `false` for all platform checks.

   ```dart
   class GeneralPlatform {
     static bool get isWeb => false;
     static bool get isMacOS => false;
     static bool get isWindows => false;
     static bool get isLinux => false;
     static bool get isAndroid => false;
     static bool get isIOS => false;
     static bool get isFuchsia => false;
   }
   ```

2. **`platform_web.dart`**:
   - This implementation is used for web platforms.
   - It checks for the presence of `dart.library.js_interop` to determine if the app is running on the web.

   ```dart
   import 'dart:html' as html;

   class GeneralPlatform {
     static bool get isWeb => true;
     static bool get isMacOS => false;
     static bool get isWindows => false;
     static bool get isLinux => false;
     static bool get isAndroid => false;
     static bool get isIOS => false;
     static bool get isFuchsia => false;
   }
   ```

3. **`platform_io.dart`**:
   - This implementation is used for non-web platforms (e.g., mobile, desktop).
   - It uses the `dart:io` library to detect the platform.

   ```dart
   import 'dart:io' show Platform;

   class GeneralPlatform {
     static bool get isWeb => false;
     static bool get isMacOS => Platform.isMacOS;
     static bool get isWindows => Platform.isWindows;
     static bool get isLinux => Platform.isLinux;
     static bool get isAndroid => Platform.isAndroid;
     static bool get isIOS => Platform.isIOS;
     static bool get isFuchsia => Platform.isFuchsia;
   }
   ```

---

### **How It Works**
- The conditional imports ensure that the correct implementation (`platform_web.dart` or `platform_io.dart`) is loaded based on the platform.
- The `GeneralPlatform` class provides the actual platform detection logic.
- The `GetPlatform` class acts as a facade, exposing static getters for easy access to platform information.

---

This utility class is particularly useful in Flutter applications where you need to write platform-specific code or adapt the UI based on the platform.

---


# GetMicrotask

---

### **1. `GetMicrotask` Class**
This class is designed to manage the execution of microtasks in Dart. Microtasks are tasks that are executed after the current synchronous code but before the next event loop iteration.

#### **Key Features**
- **Microtask Management**:
  - Tracks the current microtask count and version.
  - Ensures that a microtask is executed only if it matches the current version.

- **`exec` Method**:
  - Schedules a callback to be executed as a microtask.
  - Increments the microtask count and version to ensure proper execution order.

#### **Example Usage**
```dart
void main() {
  GetMicrotask microtask = GetMicrotask();

  microtask.exec(() {
    print("Microtask executed");
  });

  print("Main task executed");
}
```

**Output:**
```
Main task executed
Microtask executed
```

#### **How It Works**
- The `exec` method schedules the provided callback as a microtask using `scheduleMicrotask`.
- It increments the `_microtask` and `_version` counters to ensure that the microtask is executed only once.

---

### **2. `GetQueue` Class**
This class is designed to manage a queue of asynchronous jobs. It ensures that jobs are executed one at a time in the order they are added.

#### **Key Features**
- **Job Queue**:
  - Maintains a list of jobs (`_queue`) to be executed.
  - Executes jobs sequentially, ensuring that only one job runs at a time.

- **`add` Method**:
  - Adds a job to the queue and returns a `Future` that completes when the job is done.
  - Uses a `Completer` to manage the result of the job.

- **`cancelAllJobs` Method**:
  - Clears the queue, canceling all pending jobs.

#### **Example Usage**
```dart
void main() async {
  GetQueue queue = GetQueue();

  queue.add(() async {
    await Future.delayed(Duration(seconds: 1));
    return "Job 1 done";
  }).then((result) {
    print(result); // Output: Job 1 done
  });

  queue.add(() async {
    await Future.delayed(Duration(seconds: 2));
    return "Job 2 done";
  }).then((result) {
    print(result); // Output: Job 2 done
  });

  // Cancel all jobs (uncomment to test)
  // queue.cancelAllJobs();
}
```

**Output:**
```
Job 1 done
Job 2 done
```

#### **How It Works**
- The `add` method adds a job to the `_queue` and triggers the `_check` method to start processing the queue.
- The `_check` method ensures that only one job is executed at a time. It removes the first job from the queue, executes it, and then processes the next job.
- If an error occurs during job execution, it is caught and passed to the `Completer`'s `completeError` method.

---

### **3. `_Item` Class**
This is a private helper class used by `GetQueue` to store job details. Each `_Item` contains:
- A `Completer` to manage the result of the job.
- A `job` (callback) to be executed.

---

### **Benefits**
- **Microtask Management**:
  - Ensures that microtasks are executed in the correct order.
  - Useful for scenarios where you need to perform tasks after the current synchronous code but before the next event loop iteration.

- **Asynchronous Job Queue**:
  - Simplifies the management of asynchronous tasks by ensuring they are executed sequentially.
  - Provides a clean API for adding jobs and handling their results.

---

### **Use Cases**
1. **Microtasks**:
   - Use `GetMicrotask` when you need to schedule tasks that should run after the current synchronous code but before the next event loop iteration.

2. **Job Queue**:
   - Use `GetQueue` when you need to manage a sequence of asynchronous tasks, such as:
     - Processing a list of tasks one at a time.
     - Handling API requests in a controlled manner.
     - Ensuring that only one task runs at a time.

---



This code provides a robust and reusable solution for managing microtasks and asynchronous job queues in Dart and Flutter applications.




# Optimization

---

### **Key Features**
1. **Performance Optimization**:
   - Uses `CustomScrollView` with `SliverList` to optimize rendering and scrolling performance.
   - Avoids the overhead of a standard `ListView` by using a `SliverChildBuilderDelegate` to lazily build items.

2. **Customizable**:
   - Supports custom scroll direction, reverse scrolling, scroll physics, and more.
   - Allows for custom key generation for list items to improve widget reuse and performance.

3. **Empty State Handling**:
   - Provides an `onEmpty` widget to display when the list is empty.

4. **Dynamic Key Generation**:
   - Allows for custom key generation using the `keyGenerator` function, which can improve widget reuse and performance.

---

### **Constructor Parameters**
The `OptimizedListView` constructor accepts the following parameters:

| Parameter         | Type                          | Description                                                                 |
|-------------------|-------------------------------|-----------------------------------------------------------------------------|
| `list`            | `List<T>`                     | The list of items to display in the ListView.                               |
| `builder`         | `Widget Function(BuildContext, ValueKey, T)` | A function that builds a widget for each item in the list.                  |
| `scrollDirection` | `Axis`                        | The scroll direction of the ListView (default: `Axis.vertical`).            |
| `reverse`         | `bool`                        | Whether the list should be displayed in reverse order (default: `false`).   |
| `controller`      | `ScrollController?`           | An optional `ScrollController` for the ListView.                            |
| `primary`         | `bool?`                       | Whether the ListView is the primary scroll view in the widget tree.         |
| `physics`         | `ScrollPhysics?`              | The scroll physics of the ListView.                                         |
| `shrinkWrap`      | `bool`                        | Whether the ListView should shrink-wrap its contents (default: `false`).    |
| `onEmpty`         | `Widget`                      | A widget to display when the list is empty (default: `SizedBox.shrink()`).  |
| `keyGenerator`    | `Key? Function(T)?`           | A function that generates a key for each item in the list.                  |

---

### **How It Works**
1. **Empty List Handling**:
   - If the `list` is empty, the `onEmpty` widget is returned.

2. **CustomScrollView**:
   - A `CustomScrollView` is used to provide flexible scrolling behavior.
   - It supports custom scroll direction, reverse scrolling, and scroll physics.

3. **SliverList**:
   - A `SliverList` is used to efficiently render the list items.
   - It uses a `SliverChildBuilderDelegate` to lazily build items as they come into view.

4. **Key Generation**:
   - If a `keyGenerator` function is provided, it is used to generate keys for each item.
   - This improves widget reuse and performance by ensuring that widgets are not unnecessarily rebuilt.

5. **Child Index Callback**:
   - The `findChildIndexCallback` is used to find the index of a child widget based on its key.
   - This ensures that the correct item is displayed when the list is updated.

---

### **Example Usage**
Here’s an example of how to use the `OptimizedListView` widget:

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("OptimizedListView Example")),
        body: OptimizedListView<String>(
          list: List.generate(100, (index) => "Item $index"),
          builder: (context, key, item) {
            return ListTile(
              key: key,
              title: Text(item),
            );
          },
          keyGenerator: (item) => ValueKey(item), // Optional: Custom key generator
          onEmpty: Center(child: Text("No items found")), // Displayed when the list is empty
        ),
      ),
    );
  }
}
```

---

### **Performance Benefits**
1. **Lazy Loading**:
   - Items are built only when they come into view, reducing memory usage and improving performance.

2. **Widget Reuse**:
   - Custom keys ensure that widgets are reused efficiently, avoiding unnecessary rebuilds.

3. **Flexible Scrolling**:
   - Supports custom scroll physics, direction, and reverse scrolling.

4. **Empty State Handling**:
   - Provides a clean way to handle empty lists without additional boilerplate code.


### **Use Cases**
1. **Large Lists**:
   - Use `OptimizedListView` to display large lists efficiently, such as a list of messages, products, or user profiles.

2. **Dynamic Content**:
   - Ideal for lists with dynamic content that changes frequently, as it ensures efficient widget reuse.

3. **Custom Scroll Behavior**:
   - Use when you need custom scroll physics, reverse scrolling, or horizontal scrolling.

4. **Empty State Handling**:
   - Use when you need to display a custom widget (e.g., a message or button) when the list is empty.

---

This widget is a powerful tool for improving the performance and flexibility of list-based UIs in Flutter applications.


# Utils


This code defines a class named `GetUtils` that includes a collection of utility methods for performing various operations on data in Dart. These methods include various checks on strings, numbers, dates, files, and more. Below is an introduction and examples of some of these methods:

### 1. Method `_isEmpty`
This method checks whether a dynamic value is empty or not. It works for various data types such as `String`, `Iterable`, and `Map`.

**Example:**
```dart
print(_isEmpty('')); // true
print(_isEmpty([])); // true
print(_isEmpty({})); // true
print(_isEmpty(null)); // false
print(_isEmpty(12)); // false
```

### 2. Method `_hasLength`
This method checks whether a dynamic value has the `length` property. It works for data types such as `Iterable`, `String`, and `Map`.

**Example:**
```dart
print(_hasLength('')); // true
print(_hasLength([])); // true
print(_hasLength({})); // true
print(_hasLength(null)); // false
print(_hasLength(12)); // false
```

### 3. Method `_obtainDynamicLength`
This method returns the length of a dynamic value. If the value is `null`, it returns `null`.

**Example:**
```dart
print(_obtainDynamicLength('')); // 0
print(_obtainDynamicLength([])); // 0
print(_obtainDynamicLength({})); // 0
print(_obtainDynamicLength(null)); // null
print(_obtainDynamicLength(12)); // 2
print(_obtainDynamicLength(12.5)); // 3
print(_obtainDynamicLength('Hello')); // 5
```

### 4. Method `isNull`
This method checks if a value is `null`.

**Example:**
```dart
print(GetUtils.isNull(null)); // true
print(GetUtils.isNull(12)); // false
```

### 5. Method `isNullOrBlank`
This method checks if a value is `null` or blank (empty or contains only whitespace).

**Example:**
```dart
print(GetUtils.isNullOrBlank(null)); // true
print(GetUtils.isNullOrBlank('')); // true
print(GetUtils.isNullOrBlank('  ')); // true
print(GetUtils.isNullOrBlank([])); // true
print(GetUtils.isNullOrBlank({})); // true
print(GetUtils.isNullOrBlank('Hello')); // false
print(GetUtils.isNullOrBlank(12)); // false
```

### 6. Method `isNum`
This method checks if a string is a valid number (integer or double).

**Example:**
```dart
print(GetUtils.isNum('12')); // true
print(GetUtils.isNum('12.5')); // true
print(GetUtils.isNum('Hello')); // false
print(GetUtils.isNum(null)); // false
```

### 7. Method `isEmail`
This method checks if a string is a valid email address.

**Example:**
```dart
print(GetUtils.isEmail('test@example.com')); // true
print(GetUtils.isEmail('test.name@example.com')); // true
print(GetUtils.isEmail('test@example')); // false
print(GetUtils.isEmail('@example.com')); // false
```

### 8. Method `isURL`
This method checks if a string is a valid URL.

**Example:**
```dart
print(GetUtils.isURL('https://www.example.com')); // true
print(GetUtils.isURL('http://example.com')); // true
print(GetUtils.isURL('www.example.com')); // true
print(GetUtils.isURL('example.com')); // true
print(GetUtils.isURL('example')); // false
```

### 9. Method `isPhoneNumber`
This method checks if a string is a valid phone number.

**Example:**
```dart
print(GetUtils.isPhoneNumber('+1-555-555-5555')); // true
print(GetUtils.isPhoneNumber('555-555-5555')); // true
print(GetUtils.isPhoneNumber('5555555555')); // true
print(GetUtils.isPhoneNumber('123')); // false
print(GetUtils.isPhoneNumber('abc')); // false
```

### 10. Method `isPalindrome`
This method checks if a string is a palindrome.

**Example:**
```dart
print(GetUtils.isPalindrome('racecar')); // true
print(GetUtils.isPalindrome('hello')); // false
```

### 11. Method `capitalize`
This method capitalizes each word in a string.

**Example:**
```dart
print(GetUtils.capitalize('your name')); // "Your Name"
```

### 12. Method `removeAllWhitespace`
This method removes all whitespace from a string.

**Example:**
```dart
print(GetUtils.removeAllWhitespace('your name')); // "yourname"
```

### 13. Method `numericOnly`
This method extracts only numeric characters from a string.

**Example:**
```dart
print(GetUtils.numericOnly('OTP 12312 27/04/2020')); // "1231227042020"
print(GetUtils.numericOnly('OTP 12312 27/04/2020', firstWordOnly: true)); // "12312"
```

### 14. Method `isLengthBetween`
This method checks if the length of a value is between a specified minimum and maximum.

**Example:**
```dart
print(GetUtils.isLengthBetween('Hello', 3, 5)); // true
```

### 15. Method `isCaseInsensitiveContains`
This method checks if a string contains another string, ignoring case.

**Example:**
```dart
print(GetUtils.isCaseInsensitiveContains('Hello', 'hello')); // true
```

These are just a few examples of the utility methods provided by the `GetUtils` class. The class includes many more methods for validating and manipulating data, making it a powerful tool for Dart developers.






This code defines an extension on the `double` type in Dart, adding two computed properties: `hp` (height percentage) and `wp` (width percentage). These properties allow you to easily calculate a percentage of the screen's height or width, which is particularly useful in responsive UI design. The extension relies on the `Get` class from the `getx` package, which provides access to the screen's dimensions (`Get.height` and `Get.width`).

### Explanation of the Code:

1. **Extension `PercentSized`**:
   - This extension adds two new properties (`hp` and `wp`) to the `double` type.
   - These properties calculate a percentage of the screen's height or width based on the value of the `double`.

2. **`hp` Property**:
   - Stands for "height percentage."
   - Calculates a percentage of the screen's height (`Get.height`).
   - The input value must be between `0` and `100` (inclusive), as enforced by the `assert` statement.
   - The result is rounded to the nearest `double` using `roundToDouble()`.

3. **`wp` Property**:
   - Stands for "width percentage."
   - Calculates a percentage of the screen's width (`Get.width`).
   - Similar to `hp`, the input value must be between `0` and `100`.
   - The result is also rounded to the nearest `double`.

4. **Assertion**:
   - The `assert` statement ensures that the input value is within the valid range (`0` to `100`). If the value is outside this range, an assertion error will be thrown during development.

---

### Usage Examples:

#### 1. Setting Height as a Percentage of Screen Height:
```dart
double height = 50.0.hp; // 50% of the screen height
print(height); // If screen height is 800, this will print 400.0
```

#### 2. Setting Width as a Percentage of Screen Width:
```dart
double width = 30.0.wp; // 30% of the screen width
print(width); // If screen width is 400, this will print 120.0
```

#### 3. Using in Flutter Widgets:
```dart
Container(
  height: 20.0.hp, // 20% of screen height
  width: 80.0.wp,  // 80% of screen width
  color: Colors.blue,
);
```

#### 4. Invalid Usage (Will Throw an Assertion Error):
```dart
double invalidHeight = 120.0.hp; // Throws an assertion error because 120 is > 100
```

---

### Key Points:
- **Responsive Design**: This extension is particularly useful for creating responsive layouts that adapt to different screen sizes.
- **Rounding**: The results are rounded to the nearest `double` to avoid fractional pixel values, which can cause rendering issues.
- **Dependency**: This extension relies on the `Get` class from the `getx` package, so make sure `Get.height` and `Get.width` are properly initialized.

---

# List Sort Extension Documentation

A powerful Dart extension that provides advanced sorting capabilities for lists. This extension adds multiple sorting methods to any List type in Dart.


## Features

- Regular list sorting with ascending/descending options
- Sort by specific fields
- Multi-field sorting
- Custom comparison sorting
- Duplicate removal while sorting
- Chunk-based sorting for large lists

## Usage Examples

### Basic Sorting

```dart
final numbers = [3, 1, 4, 1, 5];

// Regular sorting (ascending)
final sorted = numbers.sortList();
print(sorted); // [1, 1, 3, 4, 5]

// Descending order
final descending = numbers.sortList(descending: true);
print(descending); // [5, 4, 3, 1, 1]
```

### Sorting Objects by Field

```dart
class Person {
  final String name;
  final int age;
  
  Person(this.name, this.age);
  
  @override
  String toString() => '$name ($age)';
}

final people = [
  Person('Alice', 30),
  Person('Bob', 25),
  Person('Charlie', 35)
];

// Sort by age
final sortedByAge = people.sortByField((p) => p.age);
print(sortedByAge); // [Bob (25), Alice (30), Charlie (35)]

// Sort by name
final sortedByName = people.sortByField((p) => p.name);
print(sortedByName); // [Alice (30), Bob (25), Charlie (35)]
```

### Multi-Field Sorting

```dart
final people = [
  Person('Alice', 30),
  Person('Bob', 30),
  Person('Charlie', 25)
];

// Sort by age first, then by name
final sortedByAgeAndName = people.sortByMultipleFields([
  (a, b) => a.age.compareTo(b.age),
  (a, b) => a.name.compareTo(b.name)
]);
print(sortedByAgeAndName); 
// [Charlie (25), Alice (30), Bob (30)]
```

### Custom Comparison

```dart
final words = ['apple', 'Banana', 'cherry'];

// Case-insensitive sorting
final sortedCaseInsensitive = words.sortWithComparison(
  (a, b) => a.toLowerCase().compareTo(b.toLowerCase())
);
print(sortedCaseInsensitive); // [apple, Banana, cherry]
```

### Sorting with Duplicate Removal

```dart
final numbers = [3, 1, 4, 1, 5, 3];

// Sort and remove duplicates
final uniqueSorted = numbers.sortUnique();
print(uniqueSorted); // [1, 3, 4, 5]

// Sort descending and remove duplicates
final uniqueDescending = numbers.sortUnique(descending: true);
print(uniqueDescending); // [5, 4, 3, 1]
```

### Chunk Sorting for Large Lists

```dart
final largeList = List.generate(10000, (i) => Random().nextInt(1000));

// Sort in chunks of 1000 elements
final chunkSorted = largeList.chunkSort(chunkSize: 1000);
print(chunkSorted.length); // 10000
```

## Advanced Usage

### Combining Multiple Features

```dart
class Product {
  final String name;
  final double price;
  final int stock;
  
  Product(this.name, this.price, this.stock);
}

final products = [
  Product('Laptop', 999.99, 5),
  Product('Phone', 599.99, 10),
  Product('Tablet', 399.99, 8),
  Product('Phone', 649.99, 3)
];

// Sort by name, then by price (descending)
final sortedProducts = products.sortByMultipleFields([
  (a, b) => a.name.compareTo(b.name),
  (a, b) => b.price.compareTo(a.price)
]);
```

## Performance Considerations

- Regular sorting operations have O(n log n) time complexity
- Chunk sorting is useful for large lists to maintain memory efficiency
- The `sortUnique` method has additional overhead due to duplicate removal
- For very large lists, consider using `chunkSort` with an appropriate chunk size

## Best Practices

1. Choose the appropriate sorting method based on your needs:
   - Use `sortList` for simple sorting
   - Use `sortByField` when sorting objects by a specific property
   - Use `sortByMultipleFields` when multiple sort criteria are needed
   - Use `sortUnique` when duplicates should be removed
   - Use `chunkSort` for very large lists

2. Consider memory usage:
   - All sorting methods create a new list instead of modifying the original
   - For large lists, be mindful of memory usage when creating sorted copies

3. Type Safety:
   - The extension is type-safe and works with any type T
   - When using `sortByField`, ensure the field selector returns a Comparable type

## Error Handling

The extension includes built-in error handling for common cases:

- Non-comparable types default to string comparison
- Null values are handled appropriately in comparisons
- Invalid chunk sizes are adjusted automatically

## Contributing

Feel free to contribute to this extension by:
1. Adding new sorting algorithms
2. Improving performance
3. Adding new features
4. Fixing bugs
5. Improving documentation

## GetX and RxList Examples

```dart



```


























