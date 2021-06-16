import 'package:flutter_apns/flutter_apns.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_apns/apns.dart';


@singleton
@injectable
class NotificationApplication {

  Future<void> init() async {
    final connector = createPushConnector();
    connector.configure(
      onLaunch: onPush,
      onResume: onPush,
      onMessage: onPush,
      onBackgroundMessage: onBackgroundMessage
    );

    connector.token.addListener(
            ()  => onTokenRefresh(connector.token.value!));
    connector.requestNotificationPermissions();
  }

  Future onTokenRefresh(String token) async {
    print(token);
  }

  Future onPush(RemoteMessage message) async {
    print(message);
  }

  Future onBackgroundMessage(RemoteMessage message) async {
    print(message);
  }

}
