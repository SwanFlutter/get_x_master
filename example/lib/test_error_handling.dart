import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example demonstrating the enhanced error handling system in GetConnect
/// این مثال سیستم مدیریت خطای پیشرفته GetConnect را نشان می‌دهد

// =============================================================================
// API Service with Error Handling
// =============================================================================

class UserApiService extends GetConnect {
  static UserApiService? _instance;

  UserApiService._internal();

  factory UserApiService() {
    _instance ??= UserApiService._internal();
    return _instance!;
  }

  bool _initialized = false;

  void _ensureInitialized() {
    if (!_initialized) {
      baseUrl = 'https://jsonplaceholder.typicode.com';
      timeout = const Duration(seconds: 10);

      // Enable enhanced features
      enableRetry = true;
      maxRetries = 3;
      retryDelay = const Duration(seconds: 1);
      enableLogging = true;
      enableCaching = true;
      cacheMaxAge = const Duration(minutes: 5);

      _initialized = true;
    }
  }

  @override
  void onInit() {
    _ensureInitialized();
    super.onInit();
  }

  // ---------------------------------------------------------------------------
  // Method 1: Traditional try-catch with specific exceptions
  // روش ۱: استفاده از try-catch با exception های اختصاصی
  // ---------------------------------------------------------------------------
  Future<User?> getUserTraditional(int id) async {
    _ensureInitialized();
    try {
      final response = await get<Map<String, dynamic>>(
        '/users/$id',
        decoder: (data) => data as Map<String, dynamic>,
      );

      // Throw if error
      response.throwIfError();

      return User.fromJson(response.body!);
    } on NotFoundException catch (e) {
      debugPrint('User not found: ${e.message}');
      debugPrint('URI: ${e.uri}');
      return null;
    } on UnauthorizedException catch (e) {
      debugPrint('Not authorized: ${e.message}');
      // Redirect to login
      Get.offAllNamed('/login');
      return null;
    } on TooManyRequestsException catch (e) {
      debugPrint('Rate limited! Retry after: ${e.retryAfter?.inSeconds}s');
      // Wait and retry
      if (e.retryAfter != null) {
        await Future.delayed(e.retryAfter!);
        return getUserTraditional(id);
      }
      return null;
    } on NetworkException catch (e) {
      debugPrint('Network error: ${e.message}');
      debugPrint('Error type: ${e.errorType}');

      switch (e.errorType) {
        case NetworkErrorType.noInternet:
          Get.snackbar('خطا', 'اتصال اینترنت برقرار نیست');
          break;
        case NetworkErrorType.connectionRefused:
          Get.snackbar('خطا', 'سرور در دسترس نیست');
          break;
        default:
          Get.snackbar('خطا', 'مشکل در اتصال به شبکه');
      }
      return null;
    } on TimeoutException catch (e) {
      debugPrint('Request timed out: ${e.message}');
      Get.snackbar('خطا', 'زمان درخواست به پایان رسید');
      return null;
    } on GetHttpException catch (e) {
      debugPrint('HTTP Error: ${e.message}');
      debugPrint('Status Code: ${e.statusCode}');
      debugPrint(e.toDetailedString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Method 2: Using Result pattern (Functional approach)
  // روش ۲: استفاده از الگوی Result (رویکرد تابعی)
  // ---------------------------------------------------------------------------
  Future<Result<User>> getUserWithResult(int id) async {
    _ensureInitialized();
    return get<Map<String, dynamic>>(
      '/users/$id',
      decoder: (data) => data as Map<String, dynamic>,
    ).toResult().mapAsync((body) => User.fromJson(body));
  }

  // ---------------------------------------------------------------------------
  // Method 3: Using ExceptionHandler.guard
  // روش ۳: استفاده از ExceptionHandler.guard
  // ---------------------------------------------------------------------------
  Future<Result<User>> getUserGuarded(int id) async {
    _ensureInitialized();
    return ExceptionHandler.guard(() async {
      final response = await get<Map<String, dynamic>>(
        '/users/$id',
        decoder: (data) => data as Map<String, dynamic>,
      );
      response.throwIfError();
      return User.fromJson(response.body!);
    });
  }

  // ---------------------------------------------------------------------------
  // Method 4: Using retry with exponential backoff
  // روش ۴: استفاده از retry با backoff نمایی
  // ---------------------------------------------------------------------------
  Future<User> getUserWithRetry(int id) async {
    _ensureInitialized();
    return ExceptionHandler.withRetry(
      () async {
        final response = await get<Map<String, dynamic>>(
          '/users/$id',
          decoder: (data) => data as Map<String, dynamic>,
        );
        response.throwIfError();
        return User.fromJson(response.body!);
      },
      maxRetries: 3,
      initialDelay: const Duration(seconds: 1),
      backoffMultiplier: 2.0,
      shouldRetry: (error) {
        // Retry on network and server errors only
        if (error is NetworkException) return true;
        if (error is TimeoutException) return true;
        if (error is GetHttpException && error.isServerError) return true;
        return false;
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Get all users with caching
  // دریافت همه کاربران با کش
  // ---------------------------------------------------------------------------
  Future<Result<List<User>>> getAllUsers() async {
    _ensureInitialized();
    return ExceptionHandler.guard(() async {
      final response = await getCached<List<dynamic>>(
        '/users',
        decoder: (data) => data as List<dynamic>,
        useCache: true,
      );
      response.throwIfError();
      return response.body!.map((json) => User.fromJson(json)).toList();
    });
  }

  // ---------------------------------------------------------------------------
  // Create user with validation error handling
  // ایجاد کاربر با مدیریت خطای اعتبارسنجی
  // ---------------------------------------------------------------------------
  Future<Result<User>> createUser(User user) async {
    _ensureInitialized();
    try {
      final response = await post<Map<String, dynamic>>(
        '/users',
        user.toJson(),
        decoder: (data) => data as Map<String, dynamic>,
      );

      if (response.hasError) {
        final exception = ExceptionHandler.fromResponse(response);

        if (exception is UnprocessableEntityException) {
          // Handle validation errors
          debugPrint('Validation errors: ${exception.fieldErrors}');
        }

        return Result.failure(exception);
      }

      return Result.success(User.fromJson(response.body!));
    } catch (e, stackTrace) {
      return Result.failure(
        ExceptionHandler.fromException(e, stackTrace: stackTrace),
      );
    }
  }
}

// =============================================================================
// GraphQL API Service Example
// =============================================================================

class GraphQLApiService extends GetConnect {
  static GraphQLApiService? _instance;
  bool _initialized = false;

  GraphQLApiService._internal();

  factory GraphQLApiService() {
    _instance ??= GraphQLApiService._internal();
    return _instance!;
  }

  void _ensureInitialized() {
    if (!_initialized) {
      // Using a public GraphQL API for demo
      // Note: baseUrl should NOT include trailing slash
      baseUrl = 'https://countries.trevorblades.com';
      timeout = const Duration(seconds: 15);
      enableLogging = true;
      _initialized = true;
    }
  }

  // ---------------------------------------------------------------------------
  // GraphQL Query Example - Get Country Info
  // ---------------------------------------------------------------------------
  Future<Result<Country>> getCountry(String code) async {
    _ensureInitialized();
    try {
      // Use empty string for url since baseUrl is the GraphQL endpoint
      final response = await query<Map<String, dynamic>>(
        r'''
        query GetCountry($code: ID!) {
          country(code: $code) {
            code
            name
            native
            capital
            currency
            languages {
              code
              name
            }
            continent {
              name
            }
          }
        }
        ''',
        variables: {'code': code},
      );

      // Check for GraphQL errors
      if (response.graphQLErrors != null &&
          response.graphQLErrors!.isNotEmpty) {
        final error = response.graphQLErrors!.first;
        return Result.failure(
          GetHttpException(
            'GraphQL Error: ${error.message}',
            statusCode: 400,
          ),
        );
      }

      // Check if country data exists
      final body = response.body;
      if (body == null || body['country'] == null) {
        return Result.failure(
          NotFoundException(
            'Country with code "$code" not found',
            uri: Uri.parse(baseUrl ?? ''),
          ),
        );
      }

      return Result.success(Country.fromGraphQL(body));
    } catch (e, stackTrace) {
      debugPrint('GraphQL Error: $e');
      return Result.failure(
        ExceptionHandler.fromException(e, stackTrace: stackTrace),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // GraphQL Query - Get All Countries
  // ---------------------------------------------------------------------------
  Future<Result<List<Country>>> getAllCountries() async {
    _ensureInitialized();
    try {
      final response = await query<Map<String, dynamic>>(
        r'''
        query {
          countries {
            code
            name
            native
            capital
            currency
          }
        }
        ''',
      );

      if (response.graphQLErrors != null &&
          response.graphQLErrors!.isNotEmpty) {
        final error = response.graphQLErrors!.first;
        return Result.failure(
          GetHttpException('GraphQL Error: ${error.message}'),
        );
      }

      final data = response.body;
      if (data == null) {
        return Result.success([]);
      }

      // Parse countries from response
      if (data['countries'] is List) {
        final countries = (data['countries'] as List)
            .map((c) => Country.fromGraphQL(c as Map<String, dynamic>))
            .toList();
        return Result.success(countries);
      }

      return Result.success([]);
    } catch (e, stackTrace) {
      return Result.failure(
        ExceptionHandler.fromException(e, stackTrace: stackTrace),
      );
    }
  }
}

// =============================================================================
// Country Model for GraphQL
// =============================================================================

class Country {
  final String code;
  final String name;
  final String? native;
  final String? capital;
  final String? currency;
  final String? continent;
  final List<Language> languages;

  Country({
    required this.code,
    required this.name,
    this.native,
    this.capital,
    this.currency,
    this.continent,
    this.languages = const [],
  });

  factory Country.fromGraphQL(Map<String, dynamic> json) {
    // Handle both direct country data and nested 'country' key
    Map<String, dynamic> countryData;
    if (json.containsKey('country') && json['country'] != null) {
      countryData = json['country'] as Map<String, dynamic>;
    } else {
      countryData = json;
    }

    // Parse languages safely
    List<Language> languagesList = [];
    final languagesData = countryData['languages'];
    if (languagesData != null && languagesData is List) {
      languagesList = languagesData
          .whereType<Map<String, dynamic>>()
          .map((l) => Language.fromJson(l))
          .toList();
    }

    // Parse continent safely
    String? continentName;
    final continentData = countryData['continent'];
    if (continentData != null && continentData is Map) {
      continentName = continentData['name']?.toString();
    }

    return Country(
      code: (countryData['code'] ?? '').toString(),
      name: (countryData['name'] ?? '').toString(),
      native: countryData['native']?.toString(),
      capital: countryData['capital']?.toString(),
      currency: countryData['currency']?.toString(),
      continent: continentName,
      languages: languagesList,
    );
  }
}

class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
    );
  }
}

// =============================================================================
// User Model
// =============================================================================

class User {
  final int id;
  final String name;
  final String email;
  final String? phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };

  static User empty() => User(id: 0, name: 'Guest', email: '');
}

// =============================================================================
// Controller
// =============================================================================

class ErrorHandlingController extends GetXController {
  late final UserApiService _api;
  late final GraphQLApiService _graphqlApi;

  final Rx<User?> user = Rx<User?>(null);
  final RxList<User> users = <User>[].obs;
  final Rx<Country?> country = Rx<Country?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _api = UserApiService();
    _graphqlApi = GraphQLApiService();
  }

  // ---------------------------------------------------------------------------
  // Load user with traditional error handling
  // ---------------------------------------------------------------------------
  Future<void> loadUserTraditional(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _api.getUserTraditional(id);

    if (result != null) {
      user.value = result;
    } else {
      errorMessage.value = 'Failed to load user';
    }

    isLoading.value = false;
  }

  // ---------------------------------------------------------------------------
  // Load user with Result pattern
  // ---------------------------------------------------------------------------
  Future<void> loadUserWithResult(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _api.getUserWithResult(id);

    result.when(
      success: (loadedUser) {
        user.value = loadedUser;
        Get.snackbar('موفق', 'کاربر با موفقیت بارگذاری شد');
      },
      failure: (error) {
        errorMessage.value = error.message;
        _handleError(error);
      },
    );

    isLoading.value = false;
  }

  // ---------------------------------------------------------------------------
  // Load all users
  // ---------------------------------------------------------------------------
  Future<void> loadAllUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _api.getAllUsers();

    // Using onSuccess and onFailure
    result.onSuccess((loadedUsers) {
      users.value = loadedUsers;
    }).onFailure((error) {
      errorMessage.value = error.message;
      _handleError(error);
    });

    isLoading.value = false;
  }

  // ---------------------------------------------------------------------------
  // Load user with retry
  // ---------------------------------------------------------------------------
  Future<void> loadUserWithRetry(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final loadedUser = await _api.getUserWithRetry(id);
      user.value = loadedUser;
      Get.snackbar('موفق', 'کاربر با موفقیت بارگذاری شد');
    } on GetHttpException catch (e) {
      errorMessage.value = e.message;
      _handleError(e);
    }

    isLoading.value = false;
  }

  // ---------------------------------------------------------------------------
  // Load country with GraphQL
  // ---------------------------------------------------------------------------
  Future<void> loadCountry(String code) async {
    isLoading.value = true;
    errorMessage.value = '';
    country.value = null;

    final result = await _graphqlApi.getCountry(code);

    result.when(
      success: (loadedCountry) {
        country.value = loadedCountry;
        Get.snackbar(
          'موفق',
          'اطلاعات کشور ${loadedCountry.name} بارگذاری شد',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      failure: (error) {
        errorMessage.value = error.message;
        _handleError(error);
      },
    );

    isLoading.value = false;
  }

  // ---------------------------------------------------------------------------
  // Clear API cache
  // ---------------------------------------------------------------------------
  void clearApiCache() {
    _api.clearCache();
  }

  // ---------------------------------------------------------------------------
  // Handle different error types
  // ---------------------------------------------------------------------------
  void _handleError(GetHttpException error) {
    switch (error) {
      case UnauthorizedException():
        Get.snackbar(
          'خطای احراز هویت',
          'لطفاً دوباره وارد شوید',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        // Get.offAllNamed('/login');
        break;

      case NotFoundException():
        Get.snackbar(
          'یافت نشد',
          'منبع مورد نظر یافت نشد',
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
        break;

      case NetworkException(:final errorType):
        String message = switch (errorType) {
          NetworkErrorType.noInternet => 'اتصال اینترنت برقرار نیست',
          NetworkErrorType.connectionRefused => 'سرور در دسترس نیست',
          NetworkErrorType.dnsLookupFailed => 'آدرس سرور یافت نشد',
          _ => 'خطا در اتصال به شبکه',
        };
        Get.snackbar(
          'خطای شبکه',
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        break;

      case TooManyRequestsException(:final retryAfter):
        Get.snackbar(
          'محدودیت درخواست',
          'لطفاً ${retryAfter?.inSeconds ?? 60} ثانیه صبر کنید',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
        );
        break;

      case TimeoutException():
        Get.snackbar(
          'زمان پایان یافت',
          'درخواست بیش از حد طول کشید',
          backgroundColor: Colors.purple,
          colorText: Colors.white,
        );
        break;

      default:
        if (error.isServerError) {
          Get.snackbar(
            'خطای سرور',
            'مشکلی در سرور رخ داده است',
            backgroundColor: Colors.red.shade900,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'خطا',
            error.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
    }
  }
}

// =============================================================================
// UI Screen
// =============================================================================

class TestErrorHandling extends StatelessWidget {
  const TestErrorHandling({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ErrorHandlingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handling Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Error message display
            Obx(() {
              if (controller.errorMessage.value.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // User info display
            Obx(() {
              final user = controller.user.value;
              if (user != null) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Info',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        Text('ID: ${user.id}'),
                        Text('Name: ${user.name}'),
                        Text('Email: ${user.email}'),
                        if (user.phone != null) Text('Phone: ${user.phone}'),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Country info display (GraphQL)
            Obx(() {
              final countryData = controller.country.value;
              if (countryData != null) {
                return Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.public, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Country Info (GraphQL)',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Divider(),
                        Text('Code: ${countryData.code}'),
                        Text('Name: ${countryData.name}'),
                        if (countryData.native != null)
                          Text('Native: ${countryData.native}'),
                        if (countryData.capital != null)
                          Text('Capital: ${countryData.capital}'),
                        if (countryData.currency != null)
                          Text('Currency: ${countryData.currency}'),
                        if (countryData.continent != null)
                          Text('Continent: ${countryData.continent}'),
                        if (countryData.languages.isNotEmpty)
                          Text(
                            'Languages: ${countryData.languages.map((l) => l.name).join(", ")}',
                          ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 16),

            // Loading indicator
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 16),

            // Action buttons
            const Text(
              'Test Error Handling Methods:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _buildButton(
              context,
              'Load User (Traditional)',
              Icons.person,
              Colors.blue,
              () => controller.loadUserTraditional(1),
            ),

            _buildButton(
              context,
              'Load User (Result Pattern)',
              Icons.check_circle,
              Colors.green,
              () => controller.loadUserWithResult(1),
            ),

            _buildButton(
              context,
              'Load User (With Retry)',
              Icons.refresh,
              Colors.orange,
              () => controller.loadUserWithRetry(1),
            ),

            _buildButton(
              context,
              'Load All Users (Cached)',
              Icons.people,
              Colors.purple,
              () => controller.loadAllUsers(),
            ),

            const Divider(height: 32),

            const Text(
              'GraphQL Demo:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _buildButton(
              context,
              'Load Country: Iran (IR)',
              Icons.public,
              Colors.teal,
              () => controller.loadCountry('IR'),
            ),

            _buildButton(
              context,
              'Load Country: USA (US)',
              Icons.flag,
              Colors.indigo,
              () => controller.loadCountry('US'),
            ),

            _buildButton(
              context,
              'Load Country: Germany (DE)',
              Icons.location_city,
              Colors.amber.shade700,
              () => controller.loadCountry('DE'),
            ),

            const Divider(height: 32),

            const Text(
              'Test Error Scenarios:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _buildButton(
              context,
              'Test 404 Not Found',
              Icons.search_off,
              Colors.grey,
              () => controller.loadUserWithResult(99999),
            ),

            _buildButton(
              context,
              'Test Invalid Country Code',
              Icons.error,
              Colors.red.shade300,
              () => controller.loadCountry('INVALID'),
            ),

            _buildButton(
              context,
              'Clear Cache',
              Icons.delete_sweep,
              Colors.red,
              () {
                controller.clearApiCache();
                Get.snackbar('موفق', 'کش پاک شد');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
