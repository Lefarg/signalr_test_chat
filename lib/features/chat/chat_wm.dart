// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:signalr_test_chat/features/chat/chat_model.dart';
import 'package:signalr_test_chat/features/chat/chat_screen.dart';

const _serverUrl = 'https://localhost:7222/chatHub';

/// Factory for [ChatWM].
ChatWM initChatWMFactory(
  BuildContext context,
) {
  final model = ChatModel();

  return ChatWM(model);
}

class ChatWM extends WidgetModel<ChatScreen, ChatModel> implements IChatWM {
  HubConnection? _hubConnection;
  Logger? _logger;

  /// Create an instance [ChatWM].
  ChatWM(ChatModel model) : super(model);

  @override
  void sendMessage() {
    if (_hubConnection != null) {
      _hubConnection!
          .invoke("SendMessage", args: <Object>['username', 'customMessage']);
    }
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _logger = Logger("ChatWM");
    final logger = _logger;

    if (_hubConnection == null) {
      final httpConnectionOptions = HttpConnectionOptions(
          httpClient: WebSupportingHttpClient(logger,
              httpClientCreateCallback: _httpClientCreateCallback),
          logger: logger,
          logMessageContent: true);

      _hubConnection = HubConnectionBuilder()
          .withUrl(_serverUrl, options: httpConnectionOptions)
          .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
          .configureLogging(logger!)
          .build();

      _hubConnection?.onreconnected(({connectionId}) {
        debugPrint("onreconnected called");
      });
    }

    if (_hubConnection?.state != HubConnectionState.Connected &&
        _hubConnection != null) {
      startHubConnection(_hubConnection!)
          .then((_) => debugPrint('--> status: ${_hubConnection!.state}'))
          .onError((error, stackTrace) => debugPrint('--> error: $error'));
    }
  }

  Future<void> startHubConnection(HubConnection hubConnection) async {
    await hubConnection.start();
  }
}

abstract class IChatWM {
  void sendMessage();
}

class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void _httpClientCreateCallback(http.Client httpClient) {
  HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
}
