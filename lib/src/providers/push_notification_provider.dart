import 'dart:async';

import 'package:clone_uber_app/src/utils/shared_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {

  StreamController _streamController =
  StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String,dynamic>> get message => _streamController.stream;

  void initPushNotifications() async {

    // ON LAUNCH
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        Map<String, dynamic> data = message.data;
        SharedPref sharedPref = new SharedPref();
        sharedPref.save('isNotification', 'true');
        _streamController.sink.add(data);
      }
    });

    // ON MESSAGE
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      Map<String, dynamic> data = message.data;

      print('Cuando estamos en primer plano');
      print('OnMessage: $data');
      _streamController.sink.add(data);

    });

    // ON RESUME
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Map<String, dynamic> data = message.data;
      print('OnResume $data');
      _streamController.sink.add(data);
    });

  }

}