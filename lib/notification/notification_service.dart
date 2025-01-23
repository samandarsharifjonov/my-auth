import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fmcToken;

  String? get fcmToken => _fmcToken;

  // Xabar kelganda bildirishnomalarni ko'rsatish yoki ishlov berish uchun listener funksiyalarini ishga tushirish
  Future<void> initNotification() async {
    // FCM Tokenni olish
    _fmcToken = await _firebaseMessaging.getToken();
    print('FCM Token: $_fmcToken');

    // Tokenni serverga yuborish (kerak bo‘lsa)
    // await _sendTokenToServer(_fmcToken);

    // Foreground xabarlar uchun listener
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        print('Foreground xabar: ${message.notification?.title ?? ''} - ${message.notification?.body ?? ''}');
        // Foydalanuvchiga xabarni ko'rsatish uchun UI interfeysda foydalaning.
        _handleForegroundMessage(message);
      },
    );

    // Background xabarlarni ishlov berish uchun
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Ilova ochilganda xabarlarni qabul qilish
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        print('Ilova ochildi va xabar kelgan: ${message.notification?.title ?? ''}');
        _handleOpenedAppMessage(message);
      },
    );

    // Token yangilanishini kuzatish
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('Token yangilandi: $newToken');
      _fmcToken = newToken;
      notifyListeners();

      // Yangilangan tokenni serverga yuborish (kerak bo‘lsa)
      // await _sendTokenToServer(newToken);
    });
  }

  // Foreground rejimda xabarni ko'rsatish (Dialog yoki boshqa UI orqali)
  void _handleForegroundMessage(RemoteMessage message) {
    // Bu yerda xabarni dialog orqali ko‘rsatishingiz mumkin.
    print('Foreground xabarni UI orqali ko‘rsatish uchun kod yozing.');
  }

  // Ilova ochilganida xabarni boshqarish
  void _handleOpenedAppMessage(RemoteMessage message) {
    // Bu yerda xabar kelganda biror sahifaga yo‘naltirish mumkin.
    print('Ilova ochilganda xabarni boshqarish uchun kod yozing.');
  }

  // Tokenni serverga yuborish
  Future<void> _sendTokenToServer(String? token) async {
    if (token != null) {
      // Tokenni API orqali yuborish kodini yozing
      print('Token serverga yuborildi: $token');
    }
  }
}

// Background rejimda ishlov berish uchun handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background rejimda xabar keldi: ${message.notification?.title ?? ''}');
  // Background xabarlar uchun kerakli amallarni bajaring
}
