import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

// Models
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// API Service
class ApiService extends GetConnect {
  @override
  void onInit() {
    // Base configuration
    baseUrl = 'https://jsonplaceholder.typicode.com';
    timeout = const Duration(seconds: 30);

    // Enhanced features
    enableCaching = true;
    cacheMaxAge = const Duration(minutes: 5);
    enableRetry = true;
    maxRetries = 3;
    enableLogging = true;

    // Request interceptor
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      debugPrint('Request: ${request.method} ${request.url}');
      return request;
    });

    // Response interceptor
    httpClient.addResponseModifier((request, response) {
      debugPrint('Response: ${response.statusCode} for ${request.url}');
      return response;
    });

    super.onInit();
  }

  // Get all users
  Future<List<User>?> getUsers() async {
    try {
      final response = await get<List<User>>(
        '/users',
        decoder: (json) => (json as List).map((e) => User.fromJson(e)).toList(),
      );

      if (response.isOk) {
        return response.body;
      } else {
        Get.snackbar('Error', 'Failed to load users: ${response.statusText}');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
      return null;
    }
  }

  // Get user by ID
  Future<User?> getUser(int id) async {
    try {
      final response = await get<User>(
        '/users/$id',
        decoder: (json) => User.fromJson(json),
      );

      return response.isOk ? response.body : null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user: $e');
      return null;
    }
  }

  // Get posts with caching
  Future<List<Post>?> getPosts() async {
    try {
      final response = await getCached<List<Post>>(
        '/posts',
        useCache: true,
        decoder: (json) => (json as List).map((e) => Post.fromJson(e)).toList(),
      );

      return response.isOk ? response.body : null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load posts: $e');
      return null;
    }
  }

  // Create user
  Future<User?> createUser(User user) async {
    try {
      final response = await post<User>(
        '/users',
        user.toJson(),
        decoder: (json) => User.fromJson(json),
      );

      if (response.isOk) {
        Get.snackbar('Success', 'User created successfully');
        return response.body;
      } else {
        Get.snackbar('Error', 'Failed to create user: ${response.statusText}');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
      return null;
    }
  }

  // Update user
  Future<User?> updateUser(User user) async {
    try {
      final response = await put<User>(
        '/users/${user.id}',
        user.toJson(),
        decoder: (json) => User.fromJson(json),
      );

      if (response.isOk) {
        Get.snackbar('Success', 'User updated successfully');
        return response.body;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user: $e');
      return null;
    }
  }

  // Delete user
  Future<bool> deleteUser(int id) async {
    try {
      final response = await delete('/users/$id');

      if (response.isOk) {
        Get.snackbar('Success', 'User deleted successfully');
        return true;
      } else {
        Get.snackbar('Error', 'Failed to delete user: ${response.statusText}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
      return false;
    }
  }
}

// WebSocket Service
class ChatService extends GetConnect {
  late GetSocket _socket;
  final RxList<String> messages = <String>[].obs;
  final RxBool isConnected = false.obs;

  void connectToChat() {
    // Note: This is a demo URL, replace with your actual WebSocket server
    _socket = socket('wss://echo.websocket.org');

    // Note: Enhanced features would be available if implemented
    // _socket.enableAutoReconnect = true;
    // _socket.maxReconnectAttempts = 5;
    // _socket.reconnectDelay = const Duration(seconds: 2);

    _socket.onOpen(() {
      debugPrint('Connected to chat');
      isConnected.value = true;
      messages.add('Connected to chat server');
    });

    _socket.onClose((close) {
      debugPrint('Disconnected: ${close.reason}');
      isConnected.value = false;
      messages.add('Disconnected: ${close.reason}');
    });

    _socket.onError((error) {
      debugPrint('Socket error: $error');
      messages.add('Error: $error');
    });

    _socket.onMessage((message) {
      debugPrint('Received: $message');
      messages.add('Received: $message');
    });

    // Note: onReconnect would be available if implemented
    // _socket.onReconnect(() {
    //   print('Reconnected successfully');
    //   messages.add('Reconnected successfully');
    // });
  }

  void sendMessage(String message) {
    if (isConnected.value) {
      _socket.send(message);
      messages.add('Sent: $message');
    } else {
      // Note: queueMessage would be available if implemented
      // _socket.queueMessage(message);
      messages.add('Cannot send: Not connected');
    }
  }

  void disconnect() {
    _socket.close();
  }
}

// Controllers
class ApiController extends GetXController {
  final ApiService _apiService = Get.put(ApiService());

  final RxList<User> users = <User>[].obs;
  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    loadUsers();
    loadPosts();
    super.onInit();
  }

  Future<void> loadUsers() async {
    isLoading.value = true;
    final result = await _apiService.getUsers();
    if (result != null) {
      users.assignAll(result);
    }
    isLoading.value = false;
  }

  Future<void> loadPosts() async {
    final result = await _apiService.getPosts();
    if (result != null) {
      posts.assignAll(result);
    }
  }

  Future<void> createUser(String name, String email) async {
    final user = User(id: 0, name: name, email: email);
    final result = await _apiService.createUser(user);
    if (result != null) {
      users.add(result);
    }
  }

  Future<void> deleteUser(User user) async {
    final success = await _apiService.deleteUser(user.id);
    if (success) {
      users.remove(user);
    }
  }

  void clearCache() {
    _apiService.clearCache();
    Get.snackbar('Cache', 'Cache cleared successfully');
  }
}

class ChatController extends GetXController {
  final ChatService _chatService = Get.put(ChatService());
  final TextEditingController messageController = TextEditingController();

  RxList<String> get messages => _chatService.messages;
  RxBool get isConnected => _chatService.isConnected;

  void connect() {
    _chatService.connectToChat();
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      _chatService.sendMessage(message);
      messageController.clear();
    }
  }

  void disconnect() {
    _chatService.disconnect();
  }

  @override
  void onClose() {
    messageController.dispose();
    _chatService.disconnect();
    super.onClose();
  }
}

// UI
class GetConnectExample extends StatelessWidget {
  const GetConnectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GetConnect Example'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'HTTP Client'),
              Tab(text: 'WebSocket'),
            ],
          ),
        ),
        body: const TabBarView(children: [HttpClientTab(), WebSocketTab()]),
      ),
    );
  }
}

class HttpClientTab extends StatelessWidget {
  const HttpClientTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApiController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.loadUsers,
                  child: const Text('Refresh Users'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.clearCache,
                  child: const Text('Clear Cache'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Card(
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteUser(user),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class WebSocketTab extends StatelessWidget {
  const WebSocketTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isConnected.value
                        ? controller.disconnect
                        : controller.connect,
                    child: Text(
                      controller.isConnected.value ? 'Disconnect' : 'Connect',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(controller.messages[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter message...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: controller.sendMessage,
                child: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
