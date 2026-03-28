// import 'dart:math';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_firebase_notification/firebase_options.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   /// Initialize notifications (call this on app start)
//   static Future<void> initialize() async {
//     // Initialize Firebase first
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     // ✅ Ask permission immediately when app opens
//     await _requestPermissions();
//
//     // Initialize local notifications
//     await _initializeLocalNotification();
//
//     // Listen for foreground messages
//     FirebaseMessaging.onMessage.listen(_showFlutterNotification);
//
//     // Listen for background messages
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//     // Print FCM token for testing
//     String? token = await _firebaseMessaging.getToken();
//     print('FCM Token: $token');
//   }
//
//   /// Request notification permissions immediately
//   static Future<void> _requestPermissions() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined permission');
//     }
//   }
//
//   /// Background message handler (must be top-level or static)
//   @pragma('vm:entry-point')
//   static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     final FlutterLocalNotificationsPlugin bgPlugin = FlutterLocalNotificationsPlugin();
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'basic_channel',
//       'Basic Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//     );
//
//     await bgPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channelDescription: channel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//
//     DarwinNotificationDetails iOSDetails = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails, iOS: iOSDetails);
//
//     int notificationId = Random().nextInt(1 << 31);
//
//     await bgPlugin.show(
//       id: notificationId,
//       title: message.notification?.title ?? message.data['title'] ?? 'No Title',
//       body: message.notification?.body ?? message.data['body'] ?? 'No Body',
//       notificationDetails: notificationDetails,
//       payload: message.data['payload'] ?? 'Notification Payload',
//     );
//   }
//
//   /// Show notification (foreground)
//   static Future<void> _showFlutterNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     Map<String, dynamic> data = message.data;
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'basic_channel',
//       'Basic Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channelDescription: channel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//
//     DarwinNotificationDetails iOSDetails = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails, iOS: iOSDetails);
//
//     int notificationId = Random().nextInt(1 << 31);
//
//     await flutterLocalNotificationsPlugin.show(
//       id: notificationId,
//       title: notification?.title ?? data['title'] ?? 'No Title',
//       body: notification?.body ?? data['body'] ?? 'No Body',
//       notificationDetails: notificationDetails,
//       payload: data['payload'] ?? 'Notification Payload',
//     );
//   }
//
//   /// Initialize local notifications
//   static Future<void> _initializeLocalNotification() async {
//     AndroidInitializationSettings androidInit =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     DarwinInitializationSettings iOSInit = const DarwinInitializationSettings();
//
//     InitializationSettings initSettings = InitializationSettings(
//       android: androidInit,
//       iOS: iOSInit,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       settings: initSettings,
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//       onDidReceiveNotificationResponse: notificationTapForeground,
//     );
//   }
//
//   // Must be top-level or static
//   @pragma('vm:entry-point')
//   static void notificationTapBackground(NotificationResponse response) {
//     print('User tapped notification (background): ${response.payload}');
//   }
//
//   @pragma('vm:entry-point')
//   static void notificationTapForeground(NotificationResponse response) {
//     print('User tapped notification (foreground): ${response.payload}');
//   }
// }



import 'dart:math';
import 'dart:io'; // ← Platform کے لیے شامل کیا
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';

import '../firebase_options.dart';

/// Mark the class as an entry point so native code can access it
@pragma('vm:entry-point')
class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize notifications (call this in main)
  @pragma('vm:entry-point')
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Permissions فوراً مانگیں (app open ہوتے ہی dialog آئے گا)
    await _requestPermissions();

    // Local notifications initialize کریں
    await _initializeLocalNotification();

    // Foreground messages کے لیے listener
    FirebaseMessaging.onMessage.listen(_showFlutterNotification);

    // Background messages کے لیے handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // FCM token پرنٹ کریں (debug کے لیے)
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  @pragma('vm:entry-point')
  static Future<void> _requestPermissions() async {
    // Firebase Messaging permission (iOS + Android کے لیے اچھا ہے)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false, // silent چاہیے تو true کریں
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Firebase permission granted');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Provisional permission granted (iOS)');
    } else {
      print('Firebase permission denied');
    }

    // Android 13+ (API 33+) کے لیے POST_NOTIFICATIONS runtime permission
    if (Platform.isAndroid) {
      final androidPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        // چیک کریں کہ notifications enabled ہیں یا نہیں
        final bool? areEnabled = await androidPlugin.areNotificationsEnabled();

        if (areEnabled != true) {
          // Permission dialog دکھائیں (یہاں سے Allow/Don't Allow آئے گا)
          final bool? granted = await androidPlugin.requestNotificationsPermission();

          if (granted == true) {
            print('Android notification permission GRANTED');
          } else {
            print('Android notification permission DENIED');
            // optional: اگر deny کیا تو settings کھولیں (permission_handler سے اگر استعمال کر رہے ہو)
            // await openAppSettings();
          }
        } else {
          print('Notifications already enabled on this Android device');
        }
      }
    }

    // iOS کے لیے local notifications کی permission (optional، لیکن محفوظ رکھنے کے لیے)
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  /// Background message handler
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final FlutterLocalNotificationsPlugin bgPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'basic_channel',
      'Basic Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await bgPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    int notificationId = Random().nextInt(1 << 31);

    await bgPlugin.show(
      id: notificationId,
      title: message.notification?.title ?? message.data['title'] ?? 'No Title',
      body: message.notification?.body ?? message.data['body'] ?? 'No Body',
      notificationDetails: notificationDetails,
      payload: message.data['payload'] ?? 'Notification Payload',
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic> data = message.data;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'basic_channel',
      'Basic Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    int notificationId = Random().nextInt(1 << 31);

    await flutterLocalNotificationsPlugin.show(
      id: notificationId,
      title: notification?.title ?? data['title'] ?? 'No Title',
      body: notification?.body ?? data['body'] ?? 'No Body',
      notificationDetails: notificationDetails,
      payload: data['payload'] ?? 'Notification Payload',
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapForeground,
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    print('User tapped notification (background): ${response.payload}');
    // یہاں آپ navigation یا کچھ logic لگا سکتے ہیں
  }

  @pragma('vm:entry-point')
  static void notificationTapForeground(NotificationResponse response) {
    print('User tapped notification (foreground): ${response.payload}');
    // یہاں آپ navigation یا کچھ logic لگا سکتے ہیں
  }
}
