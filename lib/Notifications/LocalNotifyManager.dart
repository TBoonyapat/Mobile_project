import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification>
      get didReceiveLocalNotificationCallback =>
          BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingsAndroid = AndroidInitializationSettings("ic_launcher");
    var initSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceiveNotification notification = ReceiveNotification(
            id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationCallback.add(notification);
      },
    );
    initSetting = InitializationSettings(initSettingsAndroid, initSettingsIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationCallback.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
      'nextflow_noti_001 1',
      'แจ้งเตือนของหมดอายุ 1',
      'สิ่งของหมดอายุ 1',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0, 'Too Yen', 'มีสิ่งของในตู้เย็นหมดอายุ', platformChannel,
        payload: 'New Patload');
  }

  Future scheuleAtParticularTime(DateTime timee) async {
    var time = DateTime(timee.day, timee.month, timee.year, timee.hour,
        timee.minute, timee.second);
    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));
    var androidChannel = AndroidNotificationDetails(
      'nextflow_noti_001 1',
      'แจ้งเตือนของหมดอายุ 1',
      'สิ่งของหมดอายุ 1',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Too Yen',
        'มีสิ่งของในตู้เย็นหมดอายุ2',
        scheduledNotificationDateTime,
        platformChannel);
  }

  // Future<void> showWeeklyAtDayAndTimeNotification() async {
  //   var time = Time(22, 20, 0);
  //   var androidChannel = AndroidNotificationDetails(
  //       'nextflow_noti_002 2', 'แจ้งเตือนของหมดอายุ 2', 'สิ่งของหมดอายุ 2',
  //       importance: Importance.Max,
  //       priority: Priority.High,
  //       playSound: true,
  //       timeoutAfter: 5000,
  //       enableLights: true);
  //   var iosChannel = IOSNotificationDetails();
  //   var platformChannel = NotificationDetails(androidChannel, iosChannel);
  //   await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //       0,
  //       'Weekly Test Title at ${time.hour}-${time.minute}-${time.second}',
  //       'Weekly นี้มีสิ่งของในตู้เย็นหมดอายุ',
  //       Day.Monday,
  //       time,
  //       platformChannel,
  //       payload: 'New Patload');
  // }

  // Future<void> cancelNotification() async {
  //   await flutterLocalNotificationsPlugin.cancel(0);
  // }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
