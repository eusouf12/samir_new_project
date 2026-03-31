import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';

class SocketApi {
  static io.Socket? socket;

  static void init(String baseUrl, String userId) {
    disconnect();

    try {
      debugPrint('🟡 Connecting to: $baseUrl with user: $userId');

      socket = io.io(
        baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'id': userId})
            .disableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(999)
            .setReconnectionDelay(1000)
            .setReconnectionDelayMax(5000)
            .build(),
      );
      socket!.onConnect((_) {
        debugPrint("✅ Socket Connected: ${socket!.id}");
      });

      _setupCoreListeners(userId);
      socket!.connect();

    } catch (e) {
      debugPrint("⚠xx Socket init failed: $e");
    }
  }
  static void disconnect() {
    if (socket != null && socket!.connected) {
      socket!.disconnect();
      socket!.dispose();
      socket = null;
      debugPrint("🛑 Previous Socket Disconnected");
    }
  }
  static void _setupCoreListeners(String userId) {
    if (socket == null) return;

    socket!.onConnect((_) {
      debugPrint('✅ Socket connected - UserID: $userId');
    });

    // socket!.onDisconnect((_) {
    //   debugPrint("==========️ Socket disconnected");
    // });

    socket!.onConnectError((err) {
      debugPrint("❌ Connect Error: $err");
    });

    socket!.on('socket-error', (data) {
      debugPrint("❌ Socket Error Event: $data");
    });
  }

  static void on(String event, Function(dynamic) callback) {
    socket?.on(event, callback);
  }

  static void off(String event) {
    socket?.off(event);
  }

  static void emit(String event, dynamic data) {
    if (socket == null || !socket!.connected) {

      debugPrint("❌ Cannot emit - socket not connected");
      return;
    }
    debugPrint("=================================SOCKET NOT NULL AND CONNECTED==========================================");
    debugPrint("📤 Emit [$event]: $data");
    socket!.emit(event, data);
  }

  static bool get isConnected => socket?.connected ?? false;

  static void dispose() {
    socket?.dispose();
    socket = null;
  }
}