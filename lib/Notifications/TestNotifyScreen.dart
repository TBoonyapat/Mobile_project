import 'dart:html';

import 'package:flutter/material.dart';
import 'LocalNotifyManager.dart';
import 'ScreenSecond.dart';

class TestNotifyScreen extends StatefulWidget {
  @override
  _TestNotifyScreenState createState() => _TestNotifyScreenState();
}

class _TestNotifyScreenState extends State<TestNotifyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Receive: ${notification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ScreenSecond(payload: payload);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () async {
            await localNotifyManager.showNotification();
            // await localNotifyManager.showWeeklyAtDayAndTimeNotification();
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           FlatButton(
  //               onPressed: () {
  //                 DatePicker.showDateTimePicker(context, showTitleActions: true,
  //                     onChanged: (data) {
  //                   print('change $date');
  //                 }, onConfirm: (date) {
  //                   print('change $date');
  //                   scheuleAtParticularTime(DateTime.fromMillisecondsSinceEpoch(
  //                       date.millisecondsSinceEpoch));
  //                 }, currentTime: DateTime.now(), locale: LocaleType.it);
  //               },
  //               child: Text('Select time for notification arrival',
  //               style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),))
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
