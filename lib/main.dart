import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_bluetooth_status/home_page.dart';
import 'package:wifi_bluetooth_status/notification_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EventChannel _stream = EventChannel('connectivityStatusStream');

  StreamSubscription subscription;
  @override
  void initState() {
    notificationPlugin.setListenerForLowerVersions(() {
      print('Notification came');
    });
    notificationPlugin.setOnNotificationClick(() {
      print('on CLick');
    });
    stremdata();
    super.initState();
  }

  stremdata() {
    subscription = _stream.receiveBroadcastStream().listen((event) {
      notificationPlugin.showNotification(Map.from(event));
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
