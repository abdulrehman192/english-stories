import 'dart:math';
import 'package:get/get.dart';
import '../Services/NotificationService.dart';
import '../Services/Services.dart';

class NotificationController extends GetxController
{
  NotificationService _notificationService = NotificationService();
  @override
  void onInit() {
    super.onInit();
    _notificationService.initLocalNotifications();
    _showTodayNotification();
  }



  _showTodayNotification() async
  {
    final db = SqliteService.instance;
    int id = Random.secure().nextInt(30);
    String date = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    String query = "Select * from notifications where id = '$id' ";
    List list = await db.getAllRows(query);
    print(list.length);
    if(list.isNotEmpty)
    {
      Map<String, dynamic> data = list.first;
      String title = data['title'];
      String message = data['body'];
      _notificationService.scheduleNotification(title: title, body: message);

    }
  }
}