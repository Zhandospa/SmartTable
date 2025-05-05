import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Core/%D1%81onfig.dart';
import 'package:onay/Features/home/presentation/providers/home_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

final stompWebSocketListenerProvider = Provider<void>((ref) {
  late StompClient client;

  client = StompClient(
    config: StompConfig.SockJS(
      url: 'http://${Config.ip}:8080/ws', // SockJS требует http://
      onConnect: (StompFrame frame) {
        print('[STOMP] Подключено к WebSocket');

        client.subscribe(
          destination: '/topic/menu-updated',
          callback: (StompFrame frame) {
            print('[STOMP] Получено сообщение: ${frame.body}');

            if (frame.body == "UPDATED") {
              print('[STOMP] Обновляем категории и блюда');
              ref.invalidate(menuProvider);

              final currentMenu = ref.read(menuProvider);
              currentMenu.whenData((categories) {
                for (final cat in categories) {
                  ref.invalidate(dishProvider(cat.id));
                }
              });
            }
          },
        );
      },
      onWebSocketError: (error) {
        print('[STOMP] Ошибка WebSocket: $error');
      },
      onDisconnect: (frame) {
        print('[STOMP] Отключено');
      },
      heartbeatOutgoing: const Duration(seconds: 10),
      heartbeatIncoming: const Duration(seconds: 10),
      reconnectDelay: const Duration(seconds: 5),
    ),
  );

  client.activate();

  ref.onDispose(() {
    client.deactivate();
    print('[STOMP] Соединение закрыто');
  });
});
