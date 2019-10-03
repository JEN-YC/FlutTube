import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging configureMessaging() {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  // only fire on iOS
  firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
  firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });

  firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
    print('on Message: $message');
  }, onLaunch: (Map<String, dynamic> message) async {
    print('on Launch:');
  }, onResume: (Map<String, dynamic> message) async {
    print('on Resume:');
  });
  return firebaseMessaging;
}
