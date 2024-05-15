
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService
{
  final FlutterLocalNotificationsPlugin local = FlutterLocalNotificationsPlugin();

  void initLocalNotifications()async
  {
    tz.initializeTimeZones();
    var android  = const AndroidInitializationSettings("@mipmap/launcher_icon");
    var ios = const DarwinInitializationSettings();
    var initializeSettings = InitializationSettings(
        android: android,
        iOS: ios
    );

    await local.initialize(
        initializeSettings,

        onDidReceiveNotificationResponse: (response)
        {
          print(response);
        }
    );

  }



  Future<void> scheduleNotification({ required String title, required String body}) async
  {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
        Random.secure().nextInt(8000952).toString(),
        "High Importance Notification",
        importance: Importance.high,
        playSound: true

    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        importance: androidNotificationChannel.importance,
        playSound: true,
        priority: Priority.high,
        ticker: "ticker",
        icon: "@mipmap/launcher_icon",
        showWhen: false
    );

    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,

    );

    NotificationDetails notificationDetails = NotificationDetails(
        iOS: iosNotificationDetails,
        android: androidNotificationDetails
    );

    DateTime scheduledDate = DateTime.now().add(Duration(minutes: 2));
    tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(scheduledDate, tz.local);


    await local.zonedSchedule(
      Random.secure().nextInt(8000952), // Unique ID for the notification
      title, // Notification title
      body, // Notification body
      scheduledDateTime, // Scheduled date and time
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


}