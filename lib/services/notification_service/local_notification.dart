import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: 'reminder',
      body: 'you have some out standing tasks to finish'
    ),
  );
}
