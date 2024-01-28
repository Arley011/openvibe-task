import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:openvibe_app/common/constants.dart';
import 'package:web_socket_channel/io.dart';

/// Establishes a websocket connection to the server and used to
/// send and receive messages.

const kServerService = 'ServerService';

class ServerService {
  ServerService._(
    this._webSocketChannel,
  );

  factory ServerService() {
    if (!isInitialized) {
      throw Exception('$kServerService is not initialized. '
          'Call ServerService.init() first.');
    }
    return _instance!;
  }

  static ServerService? _instance;

  final IOWebSocketChannel _webSocketChannel;

  static final _onMessageController = StreamController<dynamic>.broadcast();

  static bool _automaticallyReconnect = false;

  static bool get isInitialized => _instance != null;

  static Stream<dynamic> get onMessage => _onMessageController.stream;

  Future<bool> get isConnected async {
    try {
      await _webSocketChannel.ready;
      return true;
    } catch (e) {
      return false;
    }
  }

  static void init({
    bool forceInit = false,
  }) async {
    if (forceInit) {
      await _instance?.destroy();
    }

    if (isInitialized) {
      throw Exception('$kServerService is already initialized. '
          'Call ServerService.destroy() first if you want to re-init.');
    }
    log('$kServerService initializing...');

    final uri = Uri.parse(socketServerUrl);

    _instance = ServerService._(
      IOWebSocketChannel.connect(
        uri,
        connectTimeout: const Duration(seconds: 10),
        pingInterval: const Duration(seconds: 15),
      )
        ..stream.listen(
          _handleMessage,
          onDone: _handleOnDone,
          onError: _handleError,
        )
        ..ready.then(
          (_) => log('$kServerService connected to $uri'),
          onError: (error) => log(
            '$kServerService connection future error',
            error: error,
          ),
        ),
    );
  }

  static void _handleMessage(dynamic message) {
    log('$kServerService received message: $message');
    _onMessageController.add(message);
  }

  static void _handleOnDone() async {
    log('$kServerService connection closed');
    // TODO implement reconnect
    // if (_automaticallyReconnect) {
    //   log('$kServerService Trying to reconnect...');
    //   await Future.delayed(const Duration(seconds: 2));
    // }
  }

  static void _handleError(dynamic error) {
    _instance?.enableAutoReconnect();
    log(
      '$kServerService socket stream error',
      error: error,
    );
  }

  void send(Object message) {
    log('$kServerService sending message: $message');
    _webSocketChannel.sink.add(jsonEncode(message));
  }

  void enableAutoReconnect() {
    _automaticallyReconnect = true;
  }

  void disableAutoReconnect() {
    _automaticallyReconnect = false;
  }

  Future<void> destroy() async {
    log('$kServerService destroying...');
    try {
      await _webSocketChannel.innerWebSocket?.close();
      _instance = null;
      log('$kServerService destroyed');
    } catch (e, st) {
      log('$kServerService destroy error', error: e, stackTrace: st);
    }
  }
}
