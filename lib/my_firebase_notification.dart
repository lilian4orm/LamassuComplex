import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationFirebase {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeCloudMessage() async {
    try {
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Initialize local notifications
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // await messaging.subscribeToTopic('center_66656b164cdec95cab679181');
      // await messaging.subscribeToTopic('sales_66656b164cdec95cab679181');
      // await messaging.subscribeToTopic('bbaa');
      // print('Subscribed to topic');

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print(message.notification!.body);
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null &&
            (android != null || apple != null) &&
            !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: DarwinNotificationDetails(),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: 'launch_background',
              ),
            ),
          );
        }
      });
    } catch (e) {
      print('Firebase initialization error: $e');
    }
  }
}


// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationFirebase {
//   initializeCloudMessage() async {
//     try {
//       FirebaseMessaging messaging = FirebaseMessaging.instance;
//       messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       await messaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//           FlutterLocalNotificationsPlugin();
//       flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()!
//           .requestNotificationsPermission();
//       await messaging.subscribeToTopic('center_66656b164cdec95cab679181');
//       await messaging.subscribeToTopic('sales_66656b164cdec95cab679181');
//       await messaging.subscribeToTopic('lama');

//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);

//       var initializationSettingsAndroid = const AndroidInitializationSettings(
//         '@mipmap/ic_launcher',
//       );
//       var initializationSettingsIOS = const DarwinInitializationSettings();
//       var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS,
//       );
//       flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (notification) {
//           //when app is open and click on notification
//         },
//       );
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         print(message.notification!.body);
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android;
//         if (notification != null && android != null && !kIsWeb) {
//           flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 icon: 'launch_background',
//               ),
//             ),
//           );
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp.listen((message) async {});

//       FirebaseMessaging.instance.getInitialMessage().then((message) async {});
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   importance: Importance.max,
// );
