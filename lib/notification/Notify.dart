
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class Notify{
  static Future<bool> instantNotify(String Title, String Body, var date) async{
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(content: NotificationContent(
    id: Random().nextInt(100),
    title: "$Title",
    body: "$Body",
    channelKey: "basic_channel"
  ),
      schedule: NotificationCalendar(hour: date.hour, minute: date.minute, repeats: true)
    );
  }
}