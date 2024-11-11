import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/firebase_options.dart';

class InitializeFirebase{
  static Future<void> initialize() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBylDdBXP6U5Ba6MqX8dUrZ4Q-N9nR-164",
          appId: "1:539525530321:android:80fdb2100f11d2c57abbf0",
          messagingSenderId: "539525530321",
          projectId: "healthkit-flutter",
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

}