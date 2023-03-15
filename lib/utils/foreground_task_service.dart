import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

void initForegroundTask() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'notification_channel_id',
      channelName: 'Foreground Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
        backgroundColor: Colors.orange,
      ),
      buttons: [],
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 5000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
}

// start foreground task
Future<bool> startForegroundTask(
    Function registerReceivePort, Function startCallback) async {
  if (!await FlutterForegroundTask.canDrawOverlays) {
    final isGranted =
        await FlutterForegroundTask.openSystemAlertWindowSettings();
    if (!isGranted) {
      print('SYSTEM_ALERT_WINDOW permission denied!');
      return false;
    }
  }

  // You can save data using the saveData function.
  await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

  // Register the receivePort before starting the service.
  final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
  final bool isRegistered = registerReceivePort(receivePort);
  if (!isRegistered) {
    print('Failed to register receivePort!');
    return false;
  }

  if (await FlutterForegroundTask.isRunningService) {
    return FlutterForegroundTask.restartService();
  } else {
    return FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      callback: startCallback,
    );
  }
}
