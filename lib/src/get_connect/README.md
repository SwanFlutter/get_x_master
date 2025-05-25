# GetConnect - Enhanced HTTP Client & WebSocket

GetConnect is a powerful HTTP client and WebSocket implementation for Flutter applications, providing a simple yet feature-rich API for network communication.

## 🚀 Features

### HTTP Client
- ✅ **RESTful API Support** - GET, POST, PUT, PATCH, DELETE
- ✅ **GraphQL Support** - Query and Mutation operations
- ✅ **File Upload** - MultipartFile and FormData support
- ✅ **Request/Response Interceptors** - Modify requests and responses
- ✅ **Custom Decoders** - Type-safe response parsing
- ✅ **Authentication** - Built-in retry mechanism for auth
- ✅ **Certificate Pinning** - Enhanced security
- ✅ **Cross-platform** - Web, Mobile, Desktop support

### Enhanced Features (New!)
- 🆕 **HTTP Caching** - Automatic response caching with TTL
- 🆕 **Smart Retry Logic** - Configurable retry mechanism
- 🆕 **Request Logging** - Detailed request/response logging
- 🆕 **Connection Pooling** - Optimized connection management

### WebSocket (GetSocket)
- ✅ **Real-time Communication** - Bidirectional messaging
- ✅ **Event-based Architecture** - Subscribe to specific events
- ✅ **Auto Reconnection** - Automatic reconnection with backoff
- ✅ **Message Queuing** - Queue messages during disconnection
- ✅ **Heartbeat Support** - Keep connections alive
- ✅ **Connection Status** - Monitor connection state



### HTTP Client

```dart
import 'package:get_x_master/get_x_master.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    // Base configuration
    baseUrl = 'https://api.example.com';
    timeout = Duration(seconds: 30);
    
    // Enhanced features
    enableCaching = true;
    cacheMaxAge = Duration(minutes: 5);
    enableRetry = true;
    maxRetries = 3;
    enableLogging = true;
    
    // Request interceptor
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
    
    // Response interceptor
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        // Handle unauthorized
      }
      return response;
    });
  }
}
```

## 🌐 HTTP Operations

### GET Requests

```dart
// Basic GET
final response = await apiService.get<List<User>>(
  '/users',
  decoder: (json) => (json as List).map((e) => User.fromJson(e)).toList(),
);

// GET with query parameters
final response = await apiService.get<User>(
  '/users/profile',
  query: {'include': 'posts,comments'},
  headers: {'Accept': 'application/json'},
);

// GET with caching (Enhanced!)
final response = await apiService.getCached<List<Post>>(
  '/posts',
  useCache: true, // Use cached response if available
  decoder: (json) => (json as List).map((e) => Post.fromJson(e)).toList(),
);
```

### POST Requests

```dart
// Create user
final response = await apiService.post<User>(
  '/users',
  body: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
  decoder: (json) => User.fromJson(json),
);

// File upload with progress
final response = await apiService.post<UploadResponse>(
  '/upload',
  body: FormData({
    'file': MultipartFile(bytes, filename: 'image.jpg'),
    'description': 'Profile picture',
  }),
  uploadProgress: (percent) {
    print('Upload progress: ${percent}%');
  },
);
```

### PUT/PATCH Requests

```dart
// Update entire resource (PUT)
final response = await apiService.put<User>(
  '/users/123',
  body: updatedUser.toJson(),
  decoder: (json) => User.fromJson(json),
);

// Partial update (PATCH)
final response = await apiService.patch<User>(
  '/users/123',
  body: {'name': 'New Name'},
  decoder: (json) => User.fromJson(json),
);
```

### DELETE Requests

```dart
final response = await apiService.delete<bool>(
  '/users/123',
  headers: {'Authorization': 'Bearer $token'},
);

if (response.isOk) {
  print('User deleted successfully');
}
```

## 🔍 GraphQL Support

```dart
// GraphQL Query
final response = await apiService.query<CountryData>(
  r'''
  query GetCountry($code: String!) {
    country(code: $code) {
      name
      native
      currency
      languages {
        code
        name
      }
    }
  }
  ''',
  variables: {'code': 'US'},
);

// GraphQL Mutation
final response = await apiService.mutation<User>(
  r'''
  mutation CreateUser($input: UserInput!) {
    createUser(input: $input) {
      id
      name
      email
    }
  }
  ''',
  variables: {
    'input': {
      'name': 'John Doe',
      'email': 'john@example.com',
    }
  },
);
```

## 🔌 WebSocket (GetSocket)

### Basic WebSocket Usage

```dart
class ChatService extends GetConnect {
  late GetSocket _socket;
  
  void connectToChat() {
    _socket = socket('wss://chat.example.com/ws');
    
    // Listen to connection events
    _socket.onOpen(() {
      print('Connected to chat');
    });
    
    _socket.onClose((close) {
      print('Disconnected: ${close.reason}');
    });
    
    _socket.onError((error) {
      print('Socket error: $error');
    });
    
    // Listen to messages
    _socket.onMessage((message) {
      print('Received: $message');
    });
    
    // Listen to specific events
    _socket.on('chat_message', (data) {
      final message = ChatMessage.fromJson(data);
      _handleNewMessage(message);
    });
    
    // Enhanced: Listen to reconnection events
    _socket.onReconnect(() {
      print('Reconnected successfully');
      _resendPendingMessages();
    });
  }
  
  void sendMessage(String message) {
    if (_socket.isConnected) {
      _socket.emit('chat_message', {
        'text': message,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } else {
      // Enhanced: Queue message for later
      _socket.queueMessage(jsonEncode({
        'type': 'chat_message',
        'data': {
          'text': message,
          'timestamp': DateTime.now().toIso8601String(),
        }
      }));
    }
  }
}
```

### Enhanced WebSocket Features

```dart
// Configure auto-reconnection
_socket.enableAutoReconnect = true;
_socket.maxReconnectAttempts = 5;
_socket.reconnectDelay = Duration(seconds: 2);

// Enable heartbeat
_socket.enableHeartbeat = true;
_socket.heartbeatInterval = Duration(seconds: 30);

// Check connection status
if (_socket.isConnected) {
  print('Socket is connected');
}

if (_socket.isReconnecting) {
  print('Attempting to reconnect... (${_socket.reconnectAttempts}/${_socket.maxReconnectAttempts})');
}
```

## ⚙️ Advanced Configuration

### HTTP Caching

```dart
class ApiService extends GetConnect {
  @override
  void onInit() {
    // Enable caching
    enableCaching = true;
    cacheMaxAge = Duration(minutes: 10);
    
    super.onInit();
  }
  
  // Clear cache when needed
  void clearApiCache() {
    clearCache();
  }
}
```

### Retry Configuration

```dart
class ApiService extends GetConnect {
  @override
  void onInit() {
    // Configure retry behavior
    enableRetry = true;
    maxRetries = 3;
    retryDelay = Duration(seconds: 2);
    
    super.onInit();
  }
}
```

### Request/Response Logging

```dart
class ApiService extends GetConnect {
  @override
  void onInit() {
    // Enable detailed logging
    enableLogging = true;
    
    super.onInit();
  }
}
```

## 🛡️ Error Handling

```dart
try {
  final response = await apiService.get<User>('/users/123');
  
  if (response.isOk) {
    final user = response.body;
    print('User: ${user?.name}');
  } else {
    print('Error: ${response.statusText}');
  }
} on GetHttpException catch (e) {
  print('HTTP Error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## 🔒 Security Features

### Certificate Pinning

```dart
class SecureApiService extends GetConnect {
  @override
  void onInit() {
    trustedCertificates = [
      TrustedCertificate(
        host: 'api.example.com',
        fingerprint: 'SHA256:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
      ),
    ];
    
    super.onInit();
  }
}
```

### Authentication

```dart
class AuthenticatedApiService extends GetConnect {
  String? _token;
  
  @override
  void onInit() {
    // Auto-retry on auth failure
    maxAuthRetries = 3;
    
    // Add auth header to all requests
    httpClient.addRequestModifier<dynamic>((request) {
      if (_token != null) {
        request.headers['Authorization'] = 'Bearer $_token';
      }
      return request;
    });
    
    // Handle auth errors
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        _refreshToken();
      }
      return response;
    });
    
    super.onInit();
  }
  
  Future<void> _refreshToken() async {
    // Implement token refresh logic
  }
}
```

## 📱 Platform Support

GetConnect works seamlessly across all Flutter platforms:

- ✅ **Android** - Full HTTP and WebSocket support
- ✅ **iOS** - Full HTTP and WebSocket support  
- ✅ **Web** - HTTP and WebSocket with CORS handling
- ✅ **Windows** - Complete desktop support
- ✅ **macOS** - Complete desktop support
- ✅ **Linux** - Complete desktop support

## 🎯 Best Practices

### 1. Use Type-Safe Decoders

```dart
// Good: Type-safe with decoder
final response = await apiService.get<List<User>>(
  '/users',
  decoder: (json) => (json as List).map((e) => User.fromJson(e)).toList(),
);

// Avoid: Untyped response
final response = await apiService.get('/users');
```

### 2. Handle Errors Properly

```dart
// Good: Comprehensive error handling
try {
  final response = await apiService.get<User>('/users/123');
  if (response.isOk && response.body != null) {
    return response.body!;
  } else {
    throw ApiException('Failed to load user: ${response.statusText}');
  }
} on GetHttpException catch (e) {
  throw ApiException('Network error: ${e.message}');
}
```

### 3. Use Caching Wisely

```dart
// Cache read-only data
final posts = await apiService.getCached<List<Post>>('/posts');

// Don't cache user-specific or frequently changing data
final profile = await apiService.get<User>('/profile'); // No caching
```

### 4. Implement Proper WebSocket Cleanup

```dart
class ChatController extends GetxController {
  late GetSocket _socket;
  
  @override
  void onInit() {
    _connectToChat();
    super.onInit();
  }
  
  @override
  void onClose() {
    _socket.close();
    super.onClose();
  }
}
```

## 🔧 Troubleshooting

### Common Issues

1. **Connection Timeout**: Increase timeout duration
2. **Certificate Errors**: Check certificate pinning configuration
3. **CORS Issues**: Configure proper headers for web
4. **WebSocket Disconnections**: Enable auto-reconnection

### Debug Tips

```dart
// Enable logging to see detailed request/response info
apiService.enableLogging = true;

// Check response details
print('Status: ${response.statusCode}');
print('Headers: ${response.headers}');
print('Body: ${response.body}');
```

## 📚 Examples

Check out the [examples](../../example/) directory for complete working examples:

- Basic HTTP operations
- File upload with progress
- WebSocket chat implementation
- Authentication flow
- Caching strategies

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests for any improvements.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
