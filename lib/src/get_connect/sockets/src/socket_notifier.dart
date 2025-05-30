import 'dart:convert';

/// Signature for [SocketNotifier.addCloses].
typedef CloseSocket = void Function(Close);

/// Signature for [SocketNotifier.addMessages].
typedef MessageSocket = void Function(dynamic val);

/// Signature for [SocketNotifier.open].
typedef OpenSocket = void Function();

/// Wrapper class to message and reason from SocketNotifier
class Close {
  final String? message;
  final int? reason;

  Close(this.message, this.reason);

  @override
  String toString() {
    return 'Closed by server [$reason => $message]!';
  }
}

/// This class manages the transmission of messages over websockets using
/// GetConnect with enhanced features for better real-time communication
class SocketNotifier {
  List<void Function(dynamic)>? _onMessages = <MessageSocket>[];
  Map<String, void Function(dynamic)>? _onEvents = <String, MessageSocket>{};
  List<void Function(Close)>? _onCloses = <CloseSocket>[];
  List<void Function(Close)>? _onErrors = <CloseSocket>[];
  final List<void Function()> _onReconnects = <void Function()>[];

  late OpenSocket open;

  // Enhanced features
  bool _isReconnecting = false;
  int _reconnectAttempts = 0;
  int maxReconnectAttempts = 5;
  Duration reconnectDelay = const Duration(seconds: 2);
  bool enableAutoReconnect = true;
  bool enableHeartbeat = true;
  Duration heartbeatInterval = const Duration(seconds: 30);

  // Message queue for offline messages
  final List<String> _messageQueue = [];
  bool _isConnected = false;

  /// subscribe to close events
  void addCloses(CloseSocket socket) {
    _onCloses!.add(socket);
  }

  /// subscribe to error events
  void addErrors(CloseSocket socket) {
    _onErrors!.add((socket));
  }

  /// subscribe to named events
  void addEvents(String event, MessageSocket socket) {
    _onEvents![event] = socket;
  }

  /// subscribe to message events
  void addMessages(MessageSocket socket) {
    _onMessages!.add((socket));
  }

  /// subscribe to reconnect events
  void addReconnects(void Function() callback) {
    _onReconnects.add(callback);
  }

  /// Queue message for sending when connection is restored
  void queueMessage(String message) {
    if (!_isConnected) {
      _messageQueue.add(message);
    }
  }

  /// Send all queued messages
  void sendQueuedMessages(void Function(String) sendFunction) {
    if (_isConnected && _messageQueue.isNotEmpty) {
      for (final message in _messageQueue) {
        sendFunction(message);
      }
      _messageQueue.clear();
    }
  }

  /// Mark connection as established
  void markConnected() {
    _isConnected = true;
    _isReconnecting = false;
    _reconnectAttempts = 0;
  }

  /// Mark connection as disconnected
  void markDisconnected() {
    _isConnected = false;
  }

  /// Check if should attempt reconnection
  bool shouldReconnect() {
    return enableAutoReconnect &&
        !_isReconnecting &&
        _reconnectAttempts < maxReconnectAttempts;
  }

  /// Start reconnection attempt
  void startReconnection() {
    _isReconnecting = true;
    _reconnectAttempts++;
  }

  /// Notify reconnection success
  void notifyReconnect() {
    for (var callback in _onReconnects) {
      callback();
    }
  }

  /// Get connection status
  bool get isConnected => _isConnected;

  /// Get reconnection status
  bool get isReconnecting => _isReconnecting;

  /// Get reconnection attempts count
  int get reconnectAttempts => _reconnectAttempts;

  /// Dispose messages, events, closes and errors subscriptions
  void dispose() {
    _onMessages = null;
    _onEvents = null;
    _onCloses = null;
    _onErrors = null;
    _onReconnects.clear();
  }

  /// Notify all subscriptions on [addCloses]
  void notifyClose(Close err) {
    for (var item in _onCloses!) {
      item(err);
    }
  }

  /// Notify all subscriptions on [addMessages]
  void notifyData(dynamic data) {
    for (var item in _onMessages!) {
      item(data);
    }
    if (data is String) {
      _tryOn(data);
    }
  }

  /// Notify all subscriptions on [addErrors]
  void notifyError(Close err) {
    // rooms.removeWhere((key, value) => value.contains(_ws));
    for (var item in _onErrors!) {
      item(err);
    }
  }

  void _tryOn(String message) {
    try {
      var msg = jsonDecode(message);
      final event = msg['type'];
      final data = msg['data'];
      if (_onEvents!.containsKey(event)) {
        _onEvents![event]!(data);
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return;
    }
  }
}
