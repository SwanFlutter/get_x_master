# Changelog

## 0.0.26

### 🐛 Bug Fixes - Responsive System

* **Fixed Oversized UI Elements on Desktop/Laptop**: Resolved issue where all UI elements (text, icons, images) appeared too large on desktop and laptop screens.
* **Responsive Scaling Improvements**:
  - Reduced aggressive device-specific scaling factors from 1.15-2.2x to 1.0x for all device types
  - Fixed `sp()`, `ws()`, `imgSize()` methods in `ResponsiveData` class
  - Updated clamp ranges from 0.8-3.0 to conservative 0.8-1.2 across all methods
  - Fixed `_getDynamicBaseWidth()` and `_getDynamicBaseHeight()` to use proper fixed base dimensions instead of percentage-based calculations
  - Updated `ResponsiveSize` extension methods (`sp`, `hsp`, `ssp`, `ws`, `imgSize`) with proper scaling
  - Fixed `GetResponsiveHelper` class scaling factors and clamp ranges
  - Improved `_getClampRange()` function with consistent conservative ranges

* **Files Modified**:
  - `lib/src/responsive/responsive_builder.dart`
  - `lib/src/responsive/size_percent_extension.dart`

### 📝 Notes

* The responsive system now scales proportionally based on screen size without additional aggressive multipliers
* UI elements will maintain consistent sizing across phone, tablet, laptop, and desktop devices
* Breaking change: If you relied on the previous aggressive scaling behavior, you may need to adjust your design values

---

## 0.0.25

### ✨ New Features - Advanced Error Handling System

* **GetHttpException Enhanced**: Base exception class now includes:
  - `statusCode`, `responseBody`, `headers`, `stackTrace`, `timestamp`
  - `isClientError`, `isServerError`, `isNetworkError` getters
  - `toDetailedString()` for comprehensive error reports
  - `toMap()` for logging and serialization

* **15+ Specific Exception Types**:
  - `BadRequestException` (400)
  - `UnauthorizedException` (401)
  - `ForbiddenException` (403)
  - `NotFoundException` (404)
  - `MethodNotAllowedException` (405)
  - `RequestTimeoutException` (408)
  - `ConflictException` (409)
  - `UnprocessableEntityException` (422)
  - `TooManyRequestsException` (429)
  - `InternalServerException` (500)
  - `BadGatewayException` (502)
  - `ServiceUnavailableException` (503)
  - `GatewayTimeoutException` (504)
  - `NetworkException` with `NetworkErrorType` enum
  - `TimeoutException` with duration info
  - `RequestCancelledException`

* **Result Pattern** (Functional Error Handling):
  - `Result<T>` sealed class with `Success` and `Failure`
  - Pattern matching with `when()` and `whenOrNull()`
  - Value extraction: `getOrElse()`, `getOrThrow()`, `valueOrNull`
  - Transformations: `map()`, `flatMap()`, `mapError()`
  - Recovery: `recover()`, `recoverWith()`
  - Side effects: `onSuccess()`, `onFailure()`
  - Future extensions: `mapAsync()`, `flatMapAsync()`, `recoverAsync()`

* **ExceptionHandler Utility**:
  - `fromResponse()` - Convert Response to appropriate exception
  - `fromException()` - Convert any exception to GetHttpException
  - `guard()` - Wrap async operations in Result
  - `withRetry()` - Retry with exponential backoff

* **Response Extensions**:
  - `response.toResult()` - Convert Response to Result
  - `response.throwIfError()` - Throw if response has error
  - `Future<Response>.toResult()` - Async conversion

* **GraphQL Error Improvements**:
  - `GraphQLErrorLocation` class for error locations
  - `path` and `extensions` support in `GraphQLError`
  - `fromJson()` factory constructor

### 📚 Documentation

* Updated `lib/src/get_connect/README.md` with comprehensive error handling guide
* Added error handling section to main `README.md`
* Created `example/lib/test_error_handling.dart` with complete examples
* Updated `example/lib/main.dart` with demo navigation

---

## 0.0.24

### 🔄 Breaking Changes

* **Enum Naming Convention**: Changed enum values to lowercase for consistency with Dart conventions:
  - `SnackbarStatus`: `OPEN` → `open`, `CLOSED` → `closed`, `OPENING` → `opening`, `CLOSING` → `closing`
  - `SnackStyle`: `FLOATING` → `floating`, `GROUNDED` → `grounded`
  - `SnackPosition`: Already lowercase (`top`, `bottom`)

* **Class Renamed**: `CustomExpandableBottomSheetRoute` → `BottomSheetExpandableRoute`
* **Method Renamed**: `Get.customExpandableBottomSheet()` → `Get.bottomSheetExpandable()`

### ✨ New Features

* **PasswordValidator Improvements**:
  - Renamed `specialChars` → `specialCharacters`
  - Renamed `requireSpecialChar` → `requireSpecialCharacter`
  - Changed `specialCharacters` type from `String` to `List<String>` for easier customization

* **BottomSheetExpandableRoute**: Added `BottomSheetExpandableRoute` export to main package

### 🐛 Bug Fixes

* Fix bug PasswordValidator
* Fix close button in `BottomSheetExpandableRoute` now uses custom `closeIcon` parameter
* Added `canPop()` check before closing bottom sheet to prevent errors

---

## 0.0.23

### 🐛 Bug Fixes

* **Snackbar Overlay Fix**: Fixed "No Overlay widget found" error when using `Get.snackbar()` or `Get.showSnackbar()`.
* **Smart Dependency Injection Fix**: Fixed `smartLazyPut` and `smartFind` not working correctly with `Bindings`.

### 📚 Documentation

* Added comprehensive `SMART_LAZY_PUT_GUIDE.md` with Persian documentation.
* Updated `README.md` with detailed usage examples for `smartLazyPut` and `smartFind`.

---

## 0.0.22

* Add `PasswordValidator` Utils.

---

## 0.0.21

* Add `ConditionalNavigation` support to `off()` and `offAll()` methods.
* Update documentation for Conditional Navigation.
* Add example for Conditional Navigation.

---

## 0.0.20

* Fix initialize dependency injection
* Edit document.
* Edit `GetResponsiveBuilder` add new feature.
* Update Last SDK.
* Fix pub point.

---

## 0.0.19

* Fix initialize dependency injection

---

## 0.0.18

* Fix ConditionalNavigation navigation issue.

---

## 0.0.17

* **BREAKING CHANGE**: Renamed `ResponsiveBuilder` to `GetResponsiveBuilder` for consistency with GetX naming conventions.

---

## 0.0.16

* Updated all responsive components and extensions to use new `GetResponsiveBuilder` class.
* Enhanced responsive system documentation with updated class names.
* Improved integration with GetX framework naming standards.
* Fixed all references in examples, documentation, and implementation files.
* Fix document extension size.
* Fix Animate extension size.
* Fix responsive name `ResponsiveBuilder` detect orientation.

---

## 0.0.15

* Add `ReactiveGetView` - Smart reactive widget for automatic UI updates.
* Enhanced `GetView` with intelligent state management capabilities.
* Automatic reactive updates without manual `Obx()` wrapping.
* Improved performance through intelligent rebuilding.
* Better code readability and maintainability.
* Full compatibility with existing GetX controller patterns.
* Updated comprehensive documentation with examples.

---

## 0.0.14

* Fix document extension size.

---

## 0.0.13

* Fix bug null context.

---

## 0.0.12

* Fix bug.

---

## 0.0.11

* Fix bug.

---

## 0.0.10

* Fix bug.

---

## 0.0.9

* Update README.
* Update responsive.

---

## 0.0.8

* Add New feature for Responsive.
* Add New feature for Utils.
* Add New feature for State management.

---

## 0.0.7

* Add New feature for route.
* Add New feature for Cupertino.
* Add New feature for Animation.
* Add New feature for Dependency injection.
* Add New feature for Utils.
* Add New feature for State management.
* Fix Bug GetBuilder.

---

## 0.0.6

* Add New feature for route.

---

## 0.0.5

* Fix bug.
* Add new extensions.

---

## 0.0.4

* Edit Document.
* Fix error handling smartFind.

---

## 0.0.3

* Edit Document.

---

## 0.0.2

* Fix pub point.

---

## 0.0.1

* Update Last Version SDK.
* Add Documentation Package.
* Add New Feature.
* Add Fix AND New Feature Animation Extensions.
* Add New Feature Dependency injection.
* Extra codes cleaned up.

---