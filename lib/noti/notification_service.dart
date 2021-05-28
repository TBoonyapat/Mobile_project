

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz ;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter/services.dart';
import 'package:mobile_application/noti/timezone.dart';


class NotificationManager {

  final timeZone = TimeZone();
  


  static const MethodChannel _channel =
      const MethodChannel('flutter_native_timezone');
  
  
  
  
  var flutterLocalNotificationsPlugin;

  NotificationManager() {
    
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    
    var initializationSettingsAndroid = new AndroidInitializationSettings('refrigerator');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, 
            iOS: initializationSettingsIOS, 
            macOS: null);
      
    

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
     
    

    tz.initializeTimeZones();
    
    tz.setLocalLocation(tz.getLocation("Asia/Chongqing"));

     
  }

   getLocalTimezone() async {
     String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    
    return currentTimeZone;
  }

   static final _androidNotificationDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    importance: Importance.max,
    priority: Priority.high,
  );


  static final _notificationDetails =
      NotificationDetails(android: _androidNotificationDetails);

  
  Future<void> showNotificationDaily(int id,String name, DateTime expired) async {

    String timeZoneName = await timeZone.getTimeZoneName();
    final location = await timeZone.getLocation(timeZoneName);
    final scheduledDate = tz.TZDateTime.from(expired, location);
    var scheduledNotificationDateTime = new DateTime.now();
    
    await flutterLocalNotificationsPlugin.schedule(
    id,
    'Too Yen',
    name+' กำลังจะหมดอายุ!',
    scheduledDate,
    _notificationDetails);

    
    
    // await flutterLocalNotificationsPlugin.zonedSchedule(
      
    //     id,
    //     name,
    //     "Your ingredient is expired!",
    //     scheduledDate,
    //     _notificationDetails,
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime);
  }
    

  

  getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'Tooyen');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android : androidPlatformChannelSpecifics, iOS :iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}

