import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/errors.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/incoming_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/outcoming_chat_message.dart';

const _serverUrl = 'https://localhost:7222/chatHub';

class ChatMessagingService {
  HubConnection? _hubConnection;
  final _logger = Logger("ChatMessaging");

  final _chatMessagesListState = EntityStateNotifier<List<CommonChatMessage>>();
  final _chatMessagesList = <CommonChatMessage>[];

  EntityStateNotifier<List<CommonChatMessage>> get chatMessagesListState =>
      _chatMessagesListState;

  void chatInit() {
    if (_hubConnection == null) {
      // final httpConnectionOptions = HttpConnectionOptions(
      //     httpClient: WebSupportingHttpClient(logger,
      //         httpClientCreateCallback: _httpClientCreateCallback),
      //     logger: logger,
      //     logMessageContent: true);

      _hubConnection = HubConnectionBuilder()
          .withUrl(_serverUrl) //, options: httpConnectionOptions)
          .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
          .configureLogging(_logger)
          .build();

      _hubConnection?.onreconnected(({connectionId}) {
        debugPrint("onreconnected called");
      });

      // Когда на сервере вызывается метод `SendMessageToClient`, обрабатываем полученные от него аргументы
      _hubConnection!.on("SendMessageToClient", _handleIncomingChatMessage);
    }

    if (_hubConnection?.state != HubConnectionState.Connected &&
        _hubConnection != null) {
      _startHubConnection(_hubConnection!)
          .then((_) =>
              debugPrint('--> connection status: ${_hubConnection!.state}'))
          .onError((error, stackTrace) =>
              _chatMessagesListState.error(NotImplementedException()));
    }
  }

  Future<void> _startHubConnection(HubConnection hubConnection) async {
    await hubConnection.start();
  }

  void _handleIncomingChatMessage(List<Object?>? args) {
    if (args != null) {
      final senderName = args.first.toString();
      final message = args.last.toString();
      _chatMessagesList.add(IncomingChatMessage(
        name: senderName,
        message: message,
      ));
      _chatMessagesListState.content(_chatMessagesList);
    }
  }

  void sendMessage(String message) {
    try {
      if (_hubConnection != null) {
        // Вызываем метод на стороне сервера, первый аргумент - название этого метода.
        _hubConnection!
            .invoke("SendMessage", args: <Object>['Peter Tagtgren', message]);
        _chatMessagesList.add(OutcomingChatMessage(
          name: 'Peter Tagtgren',
          message: message,
        ));
      }
    } on Exception catch (e) {
      _chatMessagesListState.error(e);
    }
  }
}
